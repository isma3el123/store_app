import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';

class Categoris extends StatelessWidget {
  const Categoris({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 52, 94), fontSize: 17),
              ),
              Text(
                "View All",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 52, 94), fontSize: 13),
              ),
            ],
          ),
        ),
        cubit.categoriesList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.categoriesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          cubit.categoriesList[index].url!,
                        ),
                        child: ClipOval(
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
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const Icon(Icons.error,
                                  size: 35); // رمز خطأ بدلاً من الصورة
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}
