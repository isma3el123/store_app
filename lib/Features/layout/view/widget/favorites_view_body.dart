import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_state.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 226, 205, 141),
            title: const Text("Favorites"),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // مسافة بين الحقول
                Expanded(
                  child: cubit.favoritesList.isEmpty
                      ? Center(child: Text("No favorites"))
                      : ListView.builder(
                          itemCount: cubit.favoritesList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              width: 200,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                        fit: BoxFit.cover,
                                        cubit.favoritesList[index].image),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        cubit.favoritesList[index].name,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
