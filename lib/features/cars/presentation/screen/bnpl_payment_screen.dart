import 'package:car/core/config/bnpl_config.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/common/presentation/screen/payment_result_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BnplPaymentScreen extends StatefulWidget {
  final String checkoutUrl;
  final String providerName;

  const BnplPaymentScreen({
    super.key,
    required this.checkoutUrl,
    required this.providerName,
  });

  @override
  State<BnplPaymentScreen> createState() => _BnplPaymentScreenState();
}

class _BnplPaymentScreenState extends State<BnplPaymentScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          '${widget.providerName.toUpperCase()} Payment',
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.scaffoldColor(context),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close_rounded, color: AppColor.blackTextColor(context)),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.checkoutUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              useShouldOverrideUrlLoading: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              iframeAllow: "camera; microphone",
              iframeAllowFullscreen: true,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url.toString();

              if (url.contains(BnplConfig.successUrl)) {
                _handlePaymentResult(context, true);
                return NavigationActionPolicy.CANCEL;
              } else if (url.contains(BnplConfig.cancelUrl) || url.contains(BnplConfig.failureUrl)) {
                _handlePaymentResult(context, false);
                return NavigationActionPolicy.CANCEL;
              }

              return NavigationActionPolicy.ALLOW;
            },
          ),
          if (progress < 1.0)
            LinearProgressIndicator(
              value: progress,
              color: AppColor.primaryColor(context),
              backgroundColor: Colors.transparent,
              minHeight: 2.h,
            ),
        ],
      ),
    );
  }

  void _handlePaymentResult(BuildContext context, bool isSuccess) {
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentResultScreen(
          isSuccess: isSuccess,
          providerName: widget.providerName,
        ),
      ),
    );
  }
}
