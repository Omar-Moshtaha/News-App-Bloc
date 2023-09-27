import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/firebase_options.dart';
import 'package:news/layout/home_screen/home_screen.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'dart:ui' as ui;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  Dio_Helpers.inti();
  await Cacth_Helper.inti();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
  runApp(MyApp(isDark,value,Dirctionlty));
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
      create: (context) => HomeCubit()
        ..get_business(value)
        ..get_sports(value)
        ..get_science(value)
        ..change_theme(value: isDark)..change_lang(value)..Dirctionlty(Dirctionlty!),

      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {

          return ScreenUtilInit(
            designSize: Size(screenWidth, screenHeight),
            builder: (BuildContext context, Widget? child)=>MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
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
              HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
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
