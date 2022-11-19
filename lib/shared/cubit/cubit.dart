import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int? currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen()
  ];

  changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'b22ad4fe40e442d3923a5e8c588914cf',
      // b22ad4fe40e442d3923a5e8c588914cf
    })!
        .then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        NewsGetBusinessErrorStates(
          error.toString(),
        ),
      );
    });
  }

  List<dynamic> sports = [];

  getSports() {
    emit(NewsGetSportsLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'b22ad4fe40e442d3923a5e8c588914cf',
      // b22ad4fe40e442d3923a5e8c588914cf
    })!
        .then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessStates());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        NewsGetSportsErrorStates(
          error.toString(),
        ),
      );
    });
  }

  List<dynamic> science = [];

  getScience() {
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'b22ad4fe40e442d3923a5e8c588914cf',
      // b22ad4fe40e442d3923a5e8c588914cf
    })!
        .then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessStates());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        NewsGetScienceErrorStates(
          error.toString(),
        ),
      );
    });
  }

  List<dynamic> search = [];

  getSearch(value) {
    emit(NewsGetSearchLoadingStates());
    DioHelper.getData(url: '/v2/everything', query: {
      'q': value,
      'apiKey': 'b22ad4fe40e442d3923a5e8c588914cf',
      // b22ad4fe40e442d3923a5e8c588914cf
    })!
        .then((value) {
      search = value.data['articles'];
      print(search);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        NewsGetSearchErrorStates(
          error.toString(),
        ),
      );
    });
  }
}
