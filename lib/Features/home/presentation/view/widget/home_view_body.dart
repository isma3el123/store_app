import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/home/view_model/model/product_model.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_state.dart';
import 'package:store_app/Features/home/presentation/view/widget/bunner_list.dart';
import 'package:store_app/Features/home/presentation/view/widget/categoris.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 87, 66, 2),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      cubit.filterProuducts(input: value);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search",
                        suffixIcon: const Icon(Icons.clear),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.1),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.1),
                            borderSide: const BorderSide(color: Colors.amber))),
                  ),
                  BunnerList(),
                  const Categoris(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                            color: Color.fromARGB(255, 13, 5, 58),
                            fontSize: 17),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                            color: Color.fromARGB(255, 13, 5, 58),
                            fontSize: 13),
                      )
                    ],
                  ),
                  cubit.productLis.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.filteredProductList.isEmpty
                              ? cubit.productLis.length
                              : cubit.filteredProductList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            return productWidget(
                                product: cubit.productLis[index],
                                context: context,
                                index: index);
                          })
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}

Widget productWidget(
    {required ProuductModels product,
    required BuildContext context,
    required int index}) {
  final cubit = BlocProvider.of<LayoutCubit>(context); // الحصول على الكيوبت

  bool isFavorite = cubit.favoritesList.any((item) => item.id == product.id);

  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 214, 214).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.blue,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error, size: 35);
                },
              ),
            ),
            Text(
              product.name,
              style: const TextStyle(
                  color: Colors.black, overflow: TextOverflow.ellipsis),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.price}\$",
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    cubit.addOrRemoveFavorites(
                        productId: product.id.toString());
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons
                            .favorite_border, // تغيير الأيقونة بناءً على الحالة
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 182, 181, 181),
          child: GestureDetector(
            onTap: () {
              cubit.addOrRemoveProductFromCart(
                  productid: product.id.toString());
            },
            child: Icon(
              cubit.cartsId.contains(product.id.toString())
                  ? Icons.remove_shopping_cart // أيقونة مختلفة عند الإضافة
                  : Icons.add_shopping_cart, // أيقونة مختلفة عند عدم الإضافة
              color: cubit.cartsId.contains(product.id.toString())
                  ? const Color.fromARGB(
                      255, 0, 255, 85) // تغيير اللون عند الإضافة
                  : const Color.fromARGB(
                      255, 0, 0, 0), // اللون الافتراضي عند عدم الإضافة
            ),
          ),
        ),
      )
    ],
  );
}
