import 'package:car/core/routes/routes_name.dart';
import 'package:car/features/auth/presentation/view/screen/login_screen.dart';
import 'package:car/features/auth/presentation/view/screen/register_screen.dart';
import 'package:car/features/home/presentation/view/screen/all_brands_screen.dart';
import 'package:car/features/home/presentation/view/screen/guest_home_screen.dart';
import 'package:car/features/home/presentation/view/screen/main_layout.dart';
import 'package:car/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'package:car/features/splash/presentation/view/screen/splash_screen.dart';
import 'package:car/features/cars/presentation/screen/car_details_screen.dart'; // Added
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/view/cubit/auth_cubit.dart';
import '../services/services_locator.dart';

part 'app_routers.dart';
