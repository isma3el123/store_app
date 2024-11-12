import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_state.dart';
import 'package:store_app/core/widgets/custom_button.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_textfaild.dart';

class SiginViewBody extends StatefulWidget {
  const SiginViewBody({super.key});

  @override
  State<SiginViewBody> createState() => _SiginViewBodyState();
}

class _SiginViewBodyState extends State<SiginViewBody> {
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "Sigin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: const Color.fromARGB(255, 8, 9, 90),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextFaild(
                        hintText: 'Enter your name',
                        inputType: TextInputType.text,
                        obscureText: false,
                        onchange: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFaild(
                        hintText: 'Enter your email',
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                        onchange: (value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFaild(
                        hintText: 'Enter your phone number',
                        inputType: TextInputType.phone,
                        obscureText: false,
                        onchange: (value) {
                          phone = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFaild(
                        hintText: 'Enter your password',
                        inputType: TextInputType.text,
                        obscureText: true,
                        onchange: (value) {
                          password = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        color: const Color.fromARGB(255, 8, 9, 90),
                        ontap: () {
                          context.read<AuthCubit>().register(
                                name: name,
                                email: email,
                                phone: phone,
                                password: password,
                              );
                        },
                        text: state is RegisterLoadingState
                            ? 'Loading . . . '
                            : 'Sigin',
                      ),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.klogin);
                          },
                          child: const Text("Login"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
