import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/cubit_navbar_index/navbar_index_cubit.dart';
import 'package:store_app/Features/home/presentation/view/home_view.dart';
import 'package:store_app/Features/layout/view/widget/carts_view_body.dart';
import 'package:store_app/Features/layout/view/widget/categories_view_body.dart';
import 'package:store_app/Features/layout/view/widget/favorites_view_body.dart';
import 'package:store_app/Features/layout/view/widget/user_update_body.dart';

class LayoutViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            switch (state) {
              case 0:
                return const HomeView();
              case 1:
                return const CategoriesViewBody();
              case 2:
                return const FavoritesViewBody();
              case 3:
                return const CartsViewBody();
              case 4:
                return const UserUpdateBody();
              default:
                return const HomeView();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              currentIndex: state,
              onTap: (index) {
                // تحديث الفهرس عند اختيار عنصر جديد
                context.read<BottomNavCubit>().updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Person',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
