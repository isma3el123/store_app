import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToRegister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: Image.asset(
              fit: BoxFit.fill,
              'images/1.png',
            ),
          ),
          const Text("Developed By IsmaelAbduallah")
        ],
      ),
    );
  }

  void navigateToRegister() {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).push(AppRouter.kregister);
    });
  }
}
