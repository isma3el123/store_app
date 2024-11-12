import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_cubit.dart';
import 'package:store_app/Features/layout/manager/cubit/layout_state.dart';

class BunnerList extends StatelessWidget {
  BunnerList({super.key});
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              cubit.bunnerList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: SizedBox(
                      height: 125,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.bunnerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                cubit.bunnerList[index].url!,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      color: Colors.blue,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
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
                          );
                        },
                      ),
                    )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 25,
                      dotWidth: 16.0,
                      dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: Color.fromARGB(255, 231, 245, 172)),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
