import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/home_screen/home_screen.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dio_Helpers.inti();
  await Cacth_Helper.inti();
  bool? isDark = Cacth_Helper.getBoolean('isDark');
 String? value=Cacth_Helper.getLang('lang');
 bool?Dirctionlty=Cacth_Helper.get_Dirctionlty('Dirctionlty');
 if(Dirctionlty==null){
   Dirctionlty=false;
 }
if(value==null){
  value='eg';
}
 print(value);
  runApp(MyApp(isDark,value,Dirctionlty));
}

class MyApp extends StatelessWidget {
  bool? isDark;
String?value;
  bool? Dirctionlty;

  MyApp(this.isDark,this.value,this.Dirctionlty);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..get_business(value)
        ..get_sports(value)
        ..get_science(value)
        ..change_theme(value: isDark)..change_lang(value)..Dirctionlty(Dirctionlty!),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                  body1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  actionsIconTheme: IconThemeData(color: Colors.black),
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor("333739"),
              textTheme: TextTheme(
                  body1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),

              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: HexColor("333739"),
                  ),
                  backgroundColor: HexColor("333739"),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  actionsIconTheme: IconThemeData(color: Colors.white)),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor("333739"),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
