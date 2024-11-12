import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:store_app/Features/authentication/presentation/manager/auth_cubit/auth_state.dart';
import 'package:store_app/core/utils/cached_network.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // دالة التسجيل
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/register"),
      body: {
        'name': name,
        'password': password,
        'phone': phone,
        'email': email,
      },
    );
    await SharedPreferencesHelper().savePassword(password);
    log('Stored password: $password');
    var responsebody = jsonDecode(response.body);
    log('Register response = $responsebody');
    if (responsebody['status'] == true) {
      String token = responsebody['data']['token'];
      await SharedPreferencesHelper().saveToken(token);

      log('Stored Token: $token');

      emit(RegisterSuccessState());
    } else {
      emit(RegisterFailedState(message: responsebody['message']));
    }
  }

  // دالة تسجيل الدخول
  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/login"),
      body: {
        'password': password,
        'email': email,
      },
    );
    var responsebody = jsonDecode(response.body);

    if (responsebody['status'] == true) {
      String token = responsebody['data']['token'];
      await SharedPreferencesHelper().saveToken(token);
      await SharedPreferencesHelper().savePassword(password);

      log('Stored Token: $token');
      emit(LoginSuccessState());
    } else {
      emit(LoginFailedState(message: responsebody['message']));
    }
  }
}
