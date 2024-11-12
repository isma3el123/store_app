import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 205, 141),
        title: const Text("Categories"),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.categoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          cubit.categoriesList[index].url!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.blue,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Text(
                    cubit.categoriesList[index].name!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            );
          }),
    );
  }
}
