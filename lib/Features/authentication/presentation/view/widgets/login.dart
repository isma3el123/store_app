import 'package:flutter/material.dart';
import 'package:store_app/Features/authentication/presentation/view/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginViewBody());
  }
}
