import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/Features/authentication/presentation/view/widgets/login.dart';
import 'package:store_app/Features/authentication/presentation/view/widgets/sigin.dart';
import 'package:store_app/Features/home/view_model/model/bunner_model.dart';
import 'package:store_app/Features/home/view_model/model/categories_model.dart';
import 'package:store_app/Features/home/view_model/model/product_model.dart';
import 'package:store_app/Features/home/view_model/model/user_model.dart';
import 'package:store_app/Features/home/presentation/view/home_view.dart';
import 'package:store_app/core/utils/cached_network.dart';

import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int bottomNavIndex = 0;
  List<Widget> layoutScreen = [HomeView(), LoginView(), SiginView()];
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  UserModel? userModel;
  void getUserData() async {
    final token = await SharedPreferencesHelper.getToken();

    try {
      Response response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/profile"),
          headers: {"Authorization": token, 'lang': "en"});
      print("0021222222222222222222$token");
      var responseData = jsonDecode(response.body);
      print(response.statusCode);
      print("responseData $responseData");
      userModel = UserModel.fromJson(data: responseData['data']);
      emit(GetUserDataSuccessState());
    } catch (e) {
      emit(FaildGetUserDataState(erMassage: e.toString()));
      print(e);
    }
  }

  List<BunnerModels> bunnerList = [];

  void getBunnerData() async {
    try {
      final response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/banners"),
      );

      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          bunnerList = (responsebody['data'] as List)
              .map((item) => BunnerModels.fromJson(data: item))
              .toList();

          emit(GetBunnersSuccessState());
        } else {
          emit(FaildGetBunnersState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildGetBunnersState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildGetBunnersState());
      print("Exception occurred: $e");
    }
  }

  List<CategoriesModel> categoriesList = [];

  void getCategoriesData() async {
    try {
      final response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories"),
      );

      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          categoriesList = (responsebody['data']['data'] as List)
              .map((item) => CategoriesModel.fromJson(data: item))
              .toList();

          emit(GetCategoriesLoadingState());
        } else {
          emit(FaildGetCategoriesState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildGetCategoriesState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildGetCategoriesState());
      print("Exception occurred: $e");
    }
  }

  List<ProuductModels> productLis = [];

  void getHomeProducts() async {
    final token = await SharedPreferencesHelper.getToken();

    try {
      final response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/home"),
          headers: {"Authorization": token, "lang": "en"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          for (var item in responsebody['data']['products']) {
            productLis.add(ProuductModels.fromJson(data: item));
          }
          emit(GetHomeProductSuccessState());
        } else {
          emit(FaildGetHomeProductState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildGetHomeProductState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildGetHomeProductState());
      print("Exception occurred: $e");
    }
  }

  List<ProuductModels> filteredProductList = [];
  void filterProuducts({required String input}) {
    filteredProductList = productLis
        .where((element) =>
            element.name.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProductSuccessState());
  }

  List<ProuductModels> favoritesList = [];
  Set<String> favoritesId = {};
  Future<void> getFavorites() async {
    final token = await SharedPreferencesHelper.getToken();
    favoritesList.clear();
    try {
      final response = await http.get(
          Uri.parse("https://student.valuxapps.com/api/favorites"),
          headers: {"Authorization": token, "lang": "en"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          for (var item in responsebody['data']['data']) {
            favoritesList.add(ProuductModels.fromJson(data: item['product']));
            favoritesId.add(item['product']['id'].toString());
          }
          print(responsebody);
          print(favoritesList.length);

          emit(GetFavoritesSuccessState());
        } else {
          emit(FaildGetFavoritesState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildGetFavoritesState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildGetFavoritesState());
      print("Exception occurred: $e");
    }
  }

  void addOrRemoveFavorites({required String productId}) async {
    final token = await SharedPreferencesHelper.getToken();
    favoritesList.clear();
    try {
      final response = await http.post(
          Uri.parse("https://student.valuxapps.com/api/favorites"),
          headers: {"Authorization": token, "lang": "en"},
          body: {"product_id": productId});
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          if (favoritesId.contains(productId) == true) {
            favoritesId.remove(productId);
          } else {
            favoritesId.add(productId);
          }
          await getFavorites();
          emit(AddOrRemoveFavoritesSuccessState());
        } else {
          emit(FaildAddOrRemoveFavoritesFavoritesState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildAddOrRemoveFavoritesFavoritesState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildAddOrRemoveFavoritesFavoritesState());
      print("Exception occurred: $e");
    }
  }

  List<ProuductModels> cartList = [];
  int totalPrice = 0;
  Set<String> cartsId = {};
  Future<void> getCart() async {
    emit(GetCartsLoadingState());
    final token = await SharedPreferencesHelper.getToken();
    cartList.clear();
    try {
      final response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers: {"Authorization": token, "lang": "en"},
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);

        if (responsebody['status'] == true) {
          totalPrice = responsebody['data']['total']?.toInt() ?? 0;

          // التأكد من استخدام الاسم الصحيح cart_items
          if (responsebody['data']['cart_items'] != null) {
            for (var item in responsebody['data']['cart_items']) {
              cartsId.add(item['product']['id'].toString());
              cartList.add(ProuductModels.fromJson(data: item['product']));
            }
          } else {
            print("Warning: cart_items is null or empty.");
          }

          print(responsebody);
          print("Cart List Length: ${cartList.length}");
          emit(GetCartsSuccessState());
        } else {
          emit(FaildGetCartsState());
          print("Error: Status in response body is false.");
        }
      } else {
        emit(FaildGetCartsState());
        print("Error: Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      emit(FaildGetCartsState());
      print("Exception occurred: $e");
    }
  }

  Future<void> addOrRemoveProductFromCart({required String productid}) async {
    final token = await SharedPreferencesHelper.getToken();
    print("Attempting to add/remove product with ID: $productid");

    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/carts"), // تأكد من الرابط
      headers: {"Authorization": token, "lang": "en"},
      body: {"product_id": productid},
    );
    var responsebody = jsonDecode(response.body);

    if (responsebody['status'] == true) {
      if (cartsId.contains(productid)) {
        cartsId.remove(productid);
      } else {
        cartsId.add(productid);
      }
      await getCart();
      emit(AddOrRemoveCartSuccessState());
      print(
          "Product ${cartsId.contains(productid) ? 'added to' : 'removed from'} cart.");
    } else {
      emit(FaildAddOrRemoveCartState());
      print(
          "Error: Failed to add or remove product. ${responsebody['message']}");
    }
  }

  void changePassword(
      {required String currentPassword, required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    final token = await SharedPreferencesHelper.getToken();

    Response response = await http.post(
        Uri.parse(
          "https://student.valuxapps.com/api/change-password",
        ),
        headers: {
          "Authorization": token,
          "lang": "en",
          "Content-Type": "application/json"
        },
        body: {
          "current_password": currentPassword,
          "new_password": newPassword
        });

    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == true) {
      emit(ChangePasswordSuccessState());
    } else {
      emit(FaildChangePasswordState("error"));
    }
  }

  Future<void> updateDataUser({
    required String email,
    required String phone,
    required String name,
    required String password,
  }) async {
    emit(ChangePasswordLoadingState());

    final token = await SharedPreferencesHelper.getToken();

    try {
      Response response = await http.put(
        Uri.parse("https://student.valuxapps.com/api/update-profile"),
        headers: {
          "Authorization": "Bearer $token",
          "lang": "en",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "phone": phone,
        }),
      );

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == true) {
          log(responsebody.toString());
          emit(UpdateUserProfileSuccessState());
        } else {
          emit(
              FaildUpdateUserProfileState("Error: ${responsebody['message']}"));
        }
      } else {
        emit(FaildUpdateUserProfileState(
            "Request failed with status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(FaildUpdateUserProfileState("An error occurred: $e"));
    }
  }
}
