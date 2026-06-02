import 'dart:async';

import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/services/services_locator.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const InternetConnectivityWrapper({super.key, required this.child});

  @override
  State<InternetConnectivityWrapper> createState() => _InternetConnectivityWrapperState();
}

class _InternetConnectivityWrapperState extends State<InternetConnectivityWrapper>
    with WidgetsBindingObserver {
  bool _isConnected = true;
  bool _isChecking = false;
  late final InternetConnection _connection;
  StreamSubscription<InternetStatus>? _subscription;
  Timer? _offlineTimer;
  AppLifecycleState _lastLifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Bulletproof: check if registered in GetIt, fallback to new instance
    _connection = sl.isRegistered<InternetConnection>()
        ? sl<InternetConnection>()
        : InternetConnection();
    _checkInitialConnection();
    _subscribeToConnectionChanges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _offlineTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      _checkConnectionOnResume();
    } else if (state == AppLifecycleState.paused) {
      _offlineTimer?.cancel();
      _offlineTimer = null;
    }
  }

  Future<void> _checkConnectionOnResume() async {
    _offlineTimer?.cancel();
    _offlineTimer = null;

    try {
      final hasAccess = await _connection.hasInternetAccess;
      if (mounted && _lastLifecycleState == AppLifecycleState.resumed) {
        if (hasAccess) {
          final wasOffline = !_isConnected;
          setState(() {
            _isConnected = true;
          });
          if (wasOffline) {
            _refreshData();
          }
        } else {
          // If offline immediately after resume, give OS network stack 1.5s to initialize
          await Future.delayed(const Duration(milliseconds: 1500));
          if (mounted && _lastLifecycleState == AppLifecycleState.resumed) {
            final recheckAccess = await _connection.hasInternetAccess;
            if (recheckAccess) {
              final wasOffline = !_isConnected;
              setState(() {
                _isConnected = true;
              });
              if (wasOffline) {
                _refreshData();
              }
            } else {
              setState(() {
                _isConnected = false;
              });
            }
          }
        }
      }
    } catch (_) {
      // Fallback
    }
  }

  Future<void> _checkInitialConnection() async {
    try {
      final hasAccess = await _connection.hasInternetAccess;
      if (mounted) {
        setState(() {
          _isConnected = hasAccess;
        });
      }
    } catch (_) {
      // Fallback
    }
  }

  void _subscribeToConnectionChanges() {
    _subscription = _connection.onStatusChange.listen((status) {
      if (!mounted) return;

      // Ignore background events
      if (_lastLifecycleState != AppLifecycleState.resumed) {
        return;
      }

      final newConnected = (status == InternetStatus.connected);
      _handleConnectionChange(newConnected);
    });
  }

  void _handleConnectionChange(bool newConnected) {
    if (newConnected) {
      _offlineTimer?.cancel();
      _offlineTimer = null;
      if (!_isConnected) {
        setState(() {
          _isConnected = true;
        });
        _refreshData();
      }
    } else {
      // Delay showing offline screen to handle brief disconnects
      if (_isConnected && _offlineTimer == null) {
        _offlineTimer = Timer(const Duration(seconds: 3), () {
          if (mounted && _lastLifecycleState == AppLifecycleState.resumed) {
            setState(() {
              _isConnected = false;
            });
          }
        });
      }
    }
  }

  void _refreshData() {
    try {
      final homeCubit = context.read<HomeCubit>();
      homeCubit.getCarsModels();

      final selectedBrandId = homeCubit.state.selectedBrandId;
      if (selectedBrandId != null) {
        homeCubit.getBrandCars(selectedBrandId.toString());
      }
    } catch (_) {
      // In case HomeCubit is not active or available in context
    }
  }

  Future<void> _retryConnection() async {
    if (_isChecking) return;
    setState(() {
      _isChecking = true;
    });

    // Premium experience: delay slightly to show check animation/feedback
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final hasAccess = await _connection.hasInternetAccess;
      if (mounted) {
        final wasOffline = !_isConnected;
        setState(() {
          _isConnected = hasAccess;
          _isChecking = false;
        });
        if (hasAccess && wasOffline) {
          _refreshData();
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) {
      return widget.child;
    }
    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(absorbing: true, child: widget.child),
          Positioned.fill(child: Container(color: AppColor.scaffoldColor(context))),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      width: 150.r,
                      height: 150.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor(context).withValues(alpha: 0.12),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppImages.assetsGlobalIconOfflineIcon,
                        colorFilter: ColorFilter.mode(
                          AppColor.primaryColor(context),
                          BlendMode.srcIn,
                        ),
                        width: 80.r,
                        height: 80.r,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Gap(40.h),
                    Text(
                      AppLocaleKey.noInternetConnection.tr(),
                      style: AppTextStyle.formTitleStyle(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        AppLocaleKey.pleaseCheckYourInternet.tr(),
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.70),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 52.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          colors: [
                            AppColor.primaryColor(context),
                            AppColor.primaryColor(context).withBlue(220),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: _isChecking ? null : _retryConnection,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Center(
                          child: _isChecking
                              ? SizedBox(
                                  width: 24.r,
                                  height: 24.r,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.whiteColor(context),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh_rounded,
                                      color: AppColor.whiteColor(context),
                                      size: 20.sp,
                                    ),
                                    Gap(8.w),
                                    Text(
                                      AppLocaleKey.tryAgain.tr(),
                                      style: AppTextStyle.titleMedium(context).copyWith(
                                        color: AppColor.whiteColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    Gap(30.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
