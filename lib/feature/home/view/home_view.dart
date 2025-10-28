import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notes/feature/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/image/topappbar_home.png',
              width: double.infinity,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          floatingActionButton: Card(),
        );
      },
    );
  }
}
