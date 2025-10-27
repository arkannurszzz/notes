import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:notes/core/services/dio_services.dart';
import 'package:notes/core/services/env_services.dart';
import 'package:notes/feature/spalshscreen/view/splashscreen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

Future init() async {
  await Get.putAsync(() => EnvServices().init(), permanent: true);
  await Get.putAsync(() => DioServices().init(), permanent: true);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return GetMaterialApp(
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashscreenView(),
    );
  }
}
