import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/cubit2/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (BuildContext context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex!],
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                ),
              ],
              title: const Text('News app'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItem,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex!,
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
