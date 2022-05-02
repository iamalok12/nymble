import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nymble/presentation_layer/screens/auth_page.dart';


void main() {
  testWidgets ("Auth Page", (WidgetTester tester) async {
    await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 640),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(fontFamily: "Poppins"),
              useInheritedMediaQuery: true,
              home: const GetMaterialApp(
                home: AuthPage(),
              ),
            );
          },
        ),
    );
    expect(find.text("Nymble"), findsOneWidget);
    expect(find.text("Skip"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
