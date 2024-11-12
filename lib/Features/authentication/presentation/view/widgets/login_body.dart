import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_state.dart';
import 'package:store_app/core/utils/app_router.dart';
import 'package:store_app/core/utils/cached_network.dart';
import 'package:store_app/core/widgets/custom_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset(
                      'images/2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Positioned(
                      top: 250,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Login to continue process",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      )),
                  Positioned(
                    top: 350,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .6,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 243, 235, 209),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                    ),
                  ),
                  Positioned(
                      top: 450,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          controller: emailController, // متحكم النص للإيميل
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.person)),
                        ),
                      )),
                  Positioned(
                      top: 530,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          controller:
                              passwordController, // متحكم النص لكلمة المرور
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.password)),
                          obscureText: true, // إخفاء النص عند إدخال كلمة المرور
                        ),
                      )),
                  Positioned(
                      top: 630,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomButton(
                          color: const Color.fromARGB(255, 8, 9, 90),
                          ontap: () async {
                            setState(() {
                              final email = emailController.text;
                              final password = passwordController.text;

                              context.read<AuthCubit>().login(
                                    email: email,
                                    password: password,
                                  );
                            });

                            final token =
                                await SharedPreferencesHelper.getToken();
                            print(
                                'Token: 00000000000000000000000000000000 $token');
                            if (token.isNotEmpty) {
                              GoRouter.of(context).push(AppRouter.khomeview);
                            } else {
                              print('Token is empty, cannot navigate.');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Login failed, token is empty')),
                              );
                            }
                          },
                          text: state is LoginLoadingState
                              ? 'Loading . . . '
                              : 'Login',
                        ),
                      ))
                ],
              );
            }));
  }
}
