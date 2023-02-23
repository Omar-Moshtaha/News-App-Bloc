import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business_screen/business_screen.dart';
import 'package:news/modules/science_screen/science_screen.dart';
import 'package:news/modules/search_screen/search_screen.dart';
import 'package:news/modules/sports_screen/sports_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int index = 0;
  List<BottomNavigationBarItem> bottom = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
  ];
  void bottom_index(value) {
    index = value;
    emit(BottomIndex());
  }
  List<Widget> screen = [
    Business_Screen(),
    Sports_Screen(),
    Science_Screen(),
    Search_Screen(),
  ];
  List<dynamic?> business = [];

  void get_business(lang) {
    emit(Business_Load());
    Dio_Helpers.getdata(mothed: 'v2/top-headlines', qeruy: {
      'country': '$lang',
      'category': 'business',
      'apiKey': 'bdfcbb962eaf4f1b98d913768795a893'
    }).then((value) {
      business = value!.data["articles"];
      emit(Business_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Business_Fail(error.toString()));
    });
  }
  List<dynamic?> sports = [];
  void get_sports(lang) {
    emit(Sports_Load());
    Dio_Helpers.getdata(mothed: 'v2/top-headlines', qeruy: {
      'country': '$lang',
      'category': 'sports',
      'apiKey': 'bdfcbb962eaf4f1b98d913768795a893'
    }).then((value) {
      sports = value!.data["articles"];
      emit(Sports_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Sports_Fail(error.toString()));
    });
  }
  List<dynamic?> science = [];
  void get_science(lang) {
    emit(Science_Load());
    Dio_Helpers.getdata(mothed: 'v2/top-headlines', qeruy: {
      'country': '$lang',
      'category': 'science',
      'apiKey': 'bdfcbb962eaf4f1b98d913768795a893'
    }).then((value) {
      science = value!.data["articles"];
      emit(Science_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Science_Fail(error.toString()));
    });
  }
  bool isDark = false;
  void change_theme({bool? value}) {
    if (value != null) {
      isDark = value;
      emit(Change_Theme());
    } else {
      isDark = !isDark;
      Cacth_Helper.putBoolean('isDark', isDark).then((value) {
        emit(Change_Theme());
      });
    }
  }
  List<dynamic?> search = [];
  void get_search(String value) {
    emit(Search_Load());
    Dio_Helpers.getdata(mothed: 'v2/everything', qeruy: {
      'q': '$value',
      'apiKey': 'bdfcbb962eaf4f1b98d913768795a893'
    }).then((value) {
      search = value!.data["articles"];
      emit(Search_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Search_Fail(error.toString()));
    });
  }
String lang="eg";
  void change_lang(String? value){
    if(value != null){
      lang=value;
      emit(Country());
    }else{
      lang="eg";
      Cacth_Helper.putLang('lang','$lang');
      emit(Country());

    }
  }
  bool isDirctionlty=false;
  void Dirctionlty(bool value){
    if(value!=null){
      isDirctionlty=value;
    }else{
      isDirctionlty=false;
    };

  }
}
