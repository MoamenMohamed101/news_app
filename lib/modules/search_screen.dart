import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var controller = TextEditingController();
  String? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit(),
        child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (BuildContext context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              body: Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: controller,
                        keyboard: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter any thing';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          onChanged = value;
                          cubit.getSearch(value);
                          print(value);
                        },
                        text: 'search',
                        prefixIcon: Icons.search,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.search.isEmpty,
                      builder: (BuildContext context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.search, size: 100, color: Colors.grey),
                            Text(
                              'Search about your favorites',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      fallback: (BuildContext context) {
                        if (onChanged!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.dashboard_outlined,
                                    size: 130, color: Colors.grey),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Empty Dashboard , Please search about something',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildArticleItem(
                                  cubit.search[index], context),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                      height: 1, width: double.infinity),
                              itemCount: cubit.search.length);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }
}
