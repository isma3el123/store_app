import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/core/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LayoutCubit>(
              create: (context) => LayoutCubit()
                ..getHomeProducts()
                ..getBunnerData()
                ..getCategoriesData()
                ..getFavorites()
                ..getCart()),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ));
  }
}
