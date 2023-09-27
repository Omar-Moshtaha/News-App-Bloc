import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news/model/flags_model.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/components/constant.dart';

import 'package:news/shared/network/local/cacth_helper.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if(_connectionStatus.toString()=="ConnectivityResult.wifi"){
        checkWifi=true;
        print("$checkWifi");
      }
      if(_connectionStatus.toString()=="ConnectivityResult.none"){
        checkWifi=false;
        print("$checkWifi");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {if(state is Change_Theme){
        print("object");
      }},
      builder: (context, state) {
        return Directionality(
           textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).change_theme();
                    },
                    icon: Icon(Icons.brightness_4_outlined,size: 20.h,)),
                IconButton(onPressed: () {
               final alert=AlertDialog(
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                 content:Container(
                   width: 500.w,
                    height: 200.h,
                   child:Container(height: 200.h,child: ListView.separated( physics: BouncingScrollPhysics(),itemBuilder: (context, index) =>bulid_item(HomeCubit.get(context).flags[index],context) , separatorBuilder: (context, index) =>Padding(
                     padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
                     child: Container(color: Colors.grey,width: double.infinity,height: 1.h),
                   ) , itemCount: HomeCubit.get(context).flags.length))
                 )

               );
                  showDialog(context: context, builder: (context) =>alert ,);
                }, icon: Icon(Icons.flag,size: 20.h,))

              ],
            ),
            body: LiquidPullToRefresh (color: Colors.orange,onRefresh: HomeCubit.get(context).handleRefresh,child: HomeCubit.get(context).screen[HomeCubit.get(context).index]),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                fontSize: 15.sp,
              ),

                       iconSize: 20.h,
                       unselectedLabelStyle: TextStyle(
              fontSize: 13.sp,
            ),
              currentIndex: HomeCubit.get(context).index,
              onTap: (value) {
                HomeCubit.get(context).bottom_index(value);
              },
              items: HomeCubit.get(context).bottom,
            ),
          ),
        );
      },
    );
  }

  Widget bulid_item([FlagsModel? item,context])=>Row(
children: [
  Container(
      width: 30.w,
      height: 30.h,
      child: Image(image: NetworkImage("${item!.Text}") ,)),
  SizedBox(width:15.w),
  Text("${item.image}",style: Theme.of(context).textTheme.bodyText1,),
Spacer(),
IconButton(padding: EdgeInsets.zero,color: Theme.of(context).textTheme.bodyText1?.color,onPressed: () {
  if(item.id==1){
  HomeCubit.get(context).get_business('us');
  HomeCubit.get(context).get_sports('us');
  HomeCubit.get(context).get_science('us');
  Cacth_Helper.putLang('lang', 'us');
  var i=HomeCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==2){
  HomeCubit.get(context).get_business('IN');
  HomeCubit.get(context).get_sports('IN');
  HomeCubit.get(context).get_science('IN');
  Cacth_Helper.putLang('lang', 'IN');
  var i=HomeCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==3){
  HomeCubit.get(context).get_business('JP');
  HomeCubit.get(context).get_sports('JP');
  HomeCubit.get(context).get_science('JP');
  Cacth_Helper.putLang('lang', 'JP');
  var i=HomeCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==4){
    HomeCubit.get(context).get_business('KR');
    HomeCubit.get(context).get_sports('KR');
    HomeCubit.get(context).get_science('KR');
    Cacth_Helper.putLang('lang', 'KR');
    var i=HomeCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);

  }
}, icon: Icon(Icons.arrow_forward_ios))
],
  );
}
