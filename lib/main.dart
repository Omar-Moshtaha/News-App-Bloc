import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/home_screen/home_screen.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'dart:ui' as ui;

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
  value='JP';
}
 print(value);
  runApp( DevicePreview(
    builder: (context) => MyApp(isDark,value,Dirctionlty), // Wrap your app
  ),);
}
class MyApp extends StatelessWidget {
  bool? isDark;
String?value;
  bool? Dirctionlty;
  MyApp(this.isDark,this.value,this.Dirctionlty);
  @override
  Widget build(BuildContext context) {
    final windowSize = ui.window.physicalSize;
    final screenScale = ui.window.devicePixelRatio;
    double  screenWidth = windowSize.width / screenScale;
    double screenHeight = windowSize.height / screenScale;
    return BlocProvider(
      create: (context) => AppCubit()
        ..get_business(value)
        ..get_sports(value)
        ..get_science(value)
        ..change_theme(value: isDark)..change_lang(value)..Dirctionlty(Dirctionlty!),

      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return ScreenUtilInit(
            designSize: Size(screenWidth, screenHeight),
            builder: (BuildContext context, Widget? child)=>MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.white, onPrimary: Colors.white, secondary: Colors.white, onSecondary: Colors.white, error: Colors.white, onError: Colors.white, background: Colors.white, onBackground: Colors.white, surface: Colors.white, onSurface: Colors.white),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                appBarTheme: AppBarTheme(
                    titleSpacing: 20.w,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,

                        statusBarColor: Colors.transparent
                    ),
                    actionsIconTheme: IconThemeData(color: Colors.black),
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
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
                colorScheme: ColorScheme(brightness: Brightness.dark, primary: Colors.black, onPrimary: Colors.black, secondary: Colors.black, onSecondary: Colors.black, error: Colors.black, onError: Colors.black, background: Colors.black, onBackground: Colors.black, surface: Colors.black, onSurface: Colors.black),

                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                appBarTheme: AppBarTheme(
                    titleSpacing: 20.w,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: Colors.transparent
                    ),
                    backgroundColor: HexColor("333739"),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
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
              home:
              AnimatedSplashScreen(splashIconSize: double.infinity,splash:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/image/newspaper.png"),height: 100.h,),

                  Padding(
                    padding:  EdgeInsets.only(top: 10.h),
                    child: Text("News App",style: TextStyle(
                        fontSize: 20.sp
                    ),),
                  )
                ],
              )
                , nextScreen: HomeScreen(),
                splashTransition: SplashTransition.sizeTransition,

              ),
            ),
          );
        },
      ),
    );
  }
}
