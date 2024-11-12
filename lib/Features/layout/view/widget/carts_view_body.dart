import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_state.dart';

class CartsViewBody extends StatelessWidget {
  const CartsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getCart(); // استدعاء getCart عند بناء الشاشة

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 205, 141),
        title: const Text("Cart"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: cubit.cartList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: cubit.cartList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 226, 205, 141),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Image.network(
                                          cubit.cartList[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.cartList[index].name,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 110, 236),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  '${cubit.cartList[index].price}\$'),
                                              const SizedBox(width: 5),
                                              Text(
                                                  '${cubit.cartList[index].oldPrice}\$'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              // عرض حوار تأكيد الحذف
                                              bool confirmDeletion =
                                                  await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      "Confirm Deletion"),
                                                  content: const Text(
                                                      "Are you sure you want to remove this item from the cart?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child:
                                                          const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );

                                              if (confirmDeletion == true) {
                                                // حذف العنصر من السلة وتحديث الواجهة
                                                await cubit
                                                    .addOrRemoveProductFromCart(
                                                        productid: cubit
                                                            .cartList[index].id
                                                            .toString());
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 205, 141),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total: ${cubit.totalPrice}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 110, 236),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
