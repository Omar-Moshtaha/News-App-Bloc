import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/model/flags_model.dart';
import 'package:news/modules/business_screen/business_screen.dart';
import 'package:news/modules/science_screen/science_screen.dart';
import 'package:news/modules/search_screen/search_screen.dart';
import 'package:news/modules/sports_screen/sports_screen.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/components/constant.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int index = 0;
  List<FlagsModel>flags=[
    FlagsModel(1,"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/240px-Flag_of_the_United_States.svg.png","United State"),
    FlagsModel(2,"https://cdn.britannica.com/97/1597-050-008F30FA/Flag-India.jpg","India"),
    FlagsModel(3,"https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Flag_of_Japan.svg/280px-Flag_of_Japan.svg.png","japan"),
    FlagsModel(4,"https://cdn.britannica.com/49/1949-050-39ED83BA/Flag-South-Korea.jpg","South Korea"),

  ];
  Future<void> handleRefresh()async{
    if(checkWifi==true){
      String ?lang=Cacth_Helper.getLang('lang');
      print(lang);
      get_sports(Cacth_Helper.getLang('lang'));
      get_science(Cacth_Helper.getLang('lang'));
      get_business(Cacth_Helper.getLang('lang'));
      print("yez");
    }else{
      getAllNews(db);
    }

    return await Future.delayed(Duration(seconds:2 ));
  }

  List<BottomNavigationBarItem> bottom = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: "Business"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: "Sports"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: "Science"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
        label: "Search"),
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
    Dio_Helpers.getdata(method: 'v2/top-headlines', query: {
      'country': '$lang',
      'category': 'business',
      'apiKey': '65702bc37dd441b797629b8f9b7a044b'
    }).then((value) {
      business = value!.data["articles"];
      business.forEach((element) {
            insertToDd(
                title: element['title'],
                time: element['publishedAt'],
                description: element['description'],
                urlToImage: element['urlToImage'],
                value: "business",url: element['url']);


      });

      emit(Business_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Business_Fail(error.toString()));
    });
  }

  List<dynamic?> sports = [];

  void get_sports(lang) {
    emit(Sports_Load());
    Dio_Helpers.getdata(method: 'v2/top-headlines', query: {
      'country': '$lang',
      'category': 'sports',
      'apiKey': '65702bc37dd441b797629b8f9b7a044b'
    }).then((value) {
      sports = value!.data["articles"];
      sports.forEach((element) {
            insertToDd(
                title: element['title'],
                time: element['publishedAt'],
                description: element['description'],
                urlToImage: element['urlToImage'],
                value: "sports",url: element['url']);


        emit(Sports_Succeeded());

      });

    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Sports_Fail(error.toString()));
    });
  }

  List<dynamic?> science = [];

  Future<void> get_science(lang) async {
    emit(Science_Load());
    Dio_Helpers.getdata(method: 'v2/top-headlines', query: {
      'country': '$lang',
      'category': 'science',
      'apiKey': '65702bc37dd441b797629b8f9b7a044b'
    }).then((value) {
      science = value!.data["articles"];
      science.forEach((element) {
            insertToDd(
                title: element['title'],
                time: element['publishedAt'],
                description: element['description'],
                urlToImage: element['urlToImage'],
                value: "science",
                url: element['url']);
            emit(Science_Succeeded());

      });
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Science_Fail(error.toString()));
    });
  }

  bool isDark = false;

  void change_theme({bool? value}) {
    if (value != null) {
      isDark = value;
    } else {
      isDark = !isDark;
      Cacth_Helper.putBoolean('isDark', isDark).then((value) {});
    }
    emit(Change_Theme());
  }

  List<dynamic> search = [];

  void get_search(String value) {
    emit(Search_Load());
    Dio_Helpers.getdata(method: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'e1c7d32a6244401c9d5e277e00d15d19'
    }).then((value) {
      search = value!.data["articles"];

      emit(Search_Succeeded());
    }).catchError((error) {
      print("error ${error.toString()}");
      emit(Search_Fail(error.toString()));
    });
  }

  String lang = "eg";

  void change_lang(String? value) {
    if (value != null) {
      lang = value;
      emit(Country());
    } else {
      lang = "eg";
      Cacth_Helper.putLang('lang', '$lang');
      emit(Country());
    }
  }

  bool isDirctionlty = false;

  void Dirctionlty(bool value) {
    if (value != null) {
      isDirctionlty = value;
    } else {
      isDirctionlty = false;
    }
    ;
  }

  late Database db;

  void creatDd() async {
    openDatabase(
      'News.db',
      version: 3,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE Science (id INTEGER PRIMARY KEY, title  TEXT UNIQUE,publishedAt TEXT ,description TEXT ,urlToImage TEXT,url TEXT)')
            .then((value) {
          print("table creat");
        }).catchError((error) {
          print("error is ${error.toString()}");
        });
        db
            .execute(
                'CREATE TABLE Sports (id INTEGER PRIMARY KEY, title TEXT UNIQUE,publishedAt TEXT ,description TEXT ,urlToImage TEXT,url TEXT)')
            .then((value) {
          print("table creat");
        }).catchError((error) {
          print("error is ${error.toString()}");
        });
        db
            .execute(
                'CREATE TABLE Business (id INTEGER PRIMARY KEY, title TEXT UNIQUE,publishedAt TEXT ,description TEXT ,urlToImage TEXT,url TEXT)')
            .then((value) {
          print("table creat");
        }).catchError((error) {
          print("error is ${error.toString()}");
        });
        print("data base creat");
      },
      onOpen: (db) {
        print("data base open");
        getAllNews(db);
        emit(CreatDb());

      },
    ).then((value) {
      db = value;
      emit(CreatDb());
    });
  }

  Future<void> insertToDd({
    required String title,
    required String time,
    required String description,
    required String urlToImage,
    required String value,
    required String url,

  }) async =>
      db.transaction((txn) async {
        if (value.toString()== "science") {
          print("science");
          await txn
              .rawInsert(
                  'INSERT INTO Science(title, publishedAt, description,urlToImage,url) VALUES("$title", "$time", "$description","$urlToImage","$url")')
              .then((value) {
            emit(InsertToDb());
            getAllNews(db);

          }).catchError((error) {
            print("Error s");
          });
        }
        if (value.toString().trim() == "business") {
          await txn
              .rawInsert(
                  'INSERT INTO Business(title, publishedAt, description,urlToImage,url) VALUES("$title", "$time", "$description","$urlToImage","$url")')
              .then((value) {
            // print("$value insert succfelod");
            emit(InsertToDb());
            getAllNews(db);

          }).catchError((error) {
            print("Error");
          });
        }
        if (value.toString().trim() == "sports") {
          await txn
              .rawInsert(
                  'INSERT INTO Sports(title, publishedAt, description,urlToImage,url) VALUES("$title", "$time", "$description","$urlToImage","$url")')
              .then((value) {
            // print("$value insert succfelod");
            getAllNews(db);
            emit(InsertToDb());

          }).catchError((error) {
            print("Error");
          });
        }
      });
  List<dynamic?>science_news = [];
  List<dynamic?>  sport_news = [];
  List<dynamic?>business_news = [];

  void getAllNews(db) {
    business_news=[];
    sport_news=[];
    sport_news=[];
    emit(LoadData());
    db.rawQuery('SELECT * FROM Science').then((value) {
      science_news = value;
      print("Science length is${sport_news.length}");
print("the Science$science");
      emit(GetFormDb());
    });
    db.rawQuery('SELECT * FROM Sports').then((value) {
      sport_news = value;
      print(science_news.length);
      print("Sports length is${sport_news.length}");


      emit(GetFormDb());
    });
    db.rawQuery('SELECT * FROM Business').then((value) {
      business_news = value;
print("Business length is${business_news.length}");

      emit(GetFormDb());
    });
    emit(GetFormDb());

  }
  // Future<void> deleteAllElements() async {
  //   db.rawDelete('DELETE FROM Business').then((value) {
  //     getAllNews(db);
  //     emit(DeleteElement());
  //   });
  //   db.rawDelete('DELETE FROM Sports').then((value) {
  //     getAllNews(db);
  //     emit(DeleteElement());
  //   });
  //   db.rawDelete('DELETE FROM Science').then((value) {
  //     getAllNews(db);
  //     emit(DeleteElement());
  //   });
  //   emit(DeleteElement());
  // }
}
