import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/app/color_palette.dart';
import 'package:notes/core/app/config.dart';
import 'package:notes/feature/spalshscreen/controller/splashscreen_controller.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashscreenController>(
      init: SplashscreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsetsGeometry.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icon/perisaiku.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  child: Text(
                    Config.version,
                    style: const TextStyle(color: ColorPalette.primary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
