import 'package:car/core/config/bnpl_config.dart';
import 'package:dio/dio.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class BnplService {
  final Dio _dio = Dio();

  // Initialize Tabby SDK
  void initTabby() {
    TabbySDK().setup(withApiKey: BnplConfig.tabbyApiKey);
  }

  // --- TABBY: Create Checkout Session ---
  Future<String?> createTabbySession({
    required double amount,
    required String currency,
    required String buyerEmail,
    required String buyerPhone,
    required String buyerName,
    required String orderId,
  }) async {
    try {
      final response = await _dio.post(
        '${BnplConfig.tabbyBaseUrl}checkout',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${BnplConfig.tabbyApiKey}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "payment": {
            "amount": amount.toStringAsFixed(2),
            "currency": currency,
            "description": "Purchase from Car App",
            "buyer": {"phone": buyerPhone, "email": buyerEmail, "name": buyerName},
            "order": {
              "reference_id": orderId,
              "items": [
                {
                  "description": "Car Purchase/Booking",
                  "quantity": 1,
                  "unit_price": amount.toStringAsFixed(2),
                  "reference_id": orderId,
                },
              ],
            },
            "buyer_history": {
              "registered_since": DateTime.now().toIso8601String(),
              "loyalty_level": 0,
            },
            "order_history": [],
          },
          "lang": "ar",
          "merchant_code": "YOUR_MERCHANT_CODE", // Provided by Tabby
          "merchant_urls": {
            "success": BnplConfig.successUrl,
            "cancel": BnplConfig.cancelUrl,
            "failure": BnplConfig.failureUrl,
          },
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Return the checkout URL or configuration
        return response.data['configuration']['available_products']['installments'][0]['web_url'];
      }
    } catch (e) {
      print('Tabby Session Error: $e');
    }
    return null;
  }

  // --- TAMARA: Create Checkout Session ---
  Future<String?> createTamaraSession({
    required double amount,
    required String currency,
    required String buyerEmail,
    required String buyerPhone,
    required String buyerFullName,
    required String orderId,
  }) async {
    try {
      final response = await _dio.post(
        '${BnplConfig.tamaraBaseUrl}checkout',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${BnplConfig.tamaraToken}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "order_reference_id": orderId,
          "order_number": orderId,
          "total_amount": {"amount": amount, "currency": currency},
          "description": "Purchase from Car App",
          "country_code": "SA",
          "payment_type": "PAY_BY_INSTALMENTS",
          "instalments": 4,
          "consumer": {
            "first_name": buyerFullName.split(' ').first,
            "last_name": buyerFullName.split(' ').last,
            "phone_number": buyerPhone,
            "email": buyerEmail,
          },
          "merchant_url": {
            "success": BnplConfig.successUrl,
            "cancel": BnplConfig.cancelUrl,
            "failure": BnplConfig.failureUrl,
          },
          "items": [
            {
              "reference_id": orderId,
              "type": "Car",
              "name": "Car Purchase",
              "sku": "CAR-001",
              "quantity": 1,
              "total_amount": {"amount": amount, "currency": currency},
            },
          ],
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['checkout_url'];
      }
    } catch (e) {
      print('Tamara Session Error: $e');
    }
    return null;
  }
}
