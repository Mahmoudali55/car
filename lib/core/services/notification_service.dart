import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Request permission for local notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  static Future<String?> getFCMToken() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        // Wait for APNs token to be available before fetching FCM token
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          // Add a short delay to allow APNs token to be generated
          await Future.delayed(const Duration(seconds: 3));
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
        
        if (apnsToken != null) {
          return await _firebaseMessaging.getToken();
        } else {
          return null; // Silently return null for Simulators
        }
      } else {
        return await _firebaseMessaging.getToken();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed to get FCM token: $e");
      }
      return null;
    }
  }
}
