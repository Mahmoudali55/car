import 'package:car/core/routes/app_routers_import.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('track order route generates a screen', (tester) async {
    final route = AppRouters.onGenerateRoute(
      const RouteSettings(name: RoutesName.trackOrderScreen),
    );

    expect(route, isNotNull);
    expect(route, isA<MaterialPageRoute>());
    expect(route!.settings.name, RoutesName.trackOrderScreen);
  });
}
