import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cacth_helper.dart';
class Model{
  int? id;
  String?Text;
  String?image;
  Model(this.id,this.Text,this.image);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<Model>item=[
 Model(1,"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/240px-Flag_of_the_United_States.svg.png","United State"),
  Model(2,"https://cdn.britannica.com/97/1597-050-008F30FA/Flag-India.jpg","India"),
  Model(3,"https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Flag_of_Japan.svg/280px-Flag_of_Japan.svg.png","japan"),
  Model(4,"https://cdn.britannica.com/49/1949-050-39ED83BA/Flag-South-Korea.jpg","South Korea"),

];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
           textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).change_theme();
                    },
                    icon: Icon(Icons.brightness_4_outlined,size: 20.h,)),
                IconButton(onPressed: () {
               final alert=AlertDialog(
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                 content:Container(
                   width: 500.w,
                    height: 200.h,
                   child:Container(height: 200.h,child: ListView.separated( physics: BouncingScrollPhysics(),itemBuilder: (context, index) =>bulid_item(item[index],context) , separatorBuilder: (context, index) =>Padding(
                     padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
                     child: Container(color: Colors.grey,width: double.infinity,height: 1.h),
                   ) , itemCount: item.length))
                 )

               );
                  showDialog(context: context, builder: (context) =>alert ,);
                }, icon: Icon(Icons.flag,size: 20.h,))

              ],
            ),
            body: AppCubit.get(context).screen[AppCubit.get(context).index],
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                fontSize: 15.sp,
              ),

                       iconSize: 20.h,
                       unselectedLabelStyle: TextStyle(
              fontSize: 13.sp,
            ),
              currentIndex: AppCubit.get(context).index,
              onTap: (value) {
                AppCubit.get(context).bottom_index(value);
              },
              items: AppCubit.get(context).bottom,
            ),
          ),
        );
      },
    );
  }

  Widget bulid_item([Model? item,context])=>Row(
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
  AppCubit.get(context).get_business('us');
  AppCubit.get(context).get_sports('us');
  AppCubit.get(context).get_science('us');
  Cacth_Helper.putLang('lang', 'us');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==2){
  AppCubit.get(context).get_business('IN');
  AppCubit.get(context).get_sports('IN');
  AppCubit.get(context).get_science('IN');
  Cacth_Helper.putLang('lang', 'IN');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==3){
  AppCubit.get(context).get_business('JP');
  AppCubit.get(context).get_sports('JP');
  AppCubit.get(context).get_science('JP');
  Cacth_Helper.putLang('lang', 'JP');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==4){
    AppCubit.get(context).get_business('KR');
    AppCubit.get(context).get_sports('KR');
    AppCubit.get(context).get_science('KR');
    Cacth_Helper.putLang('lang', 'KR');
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);

  }
}, icon: Icon(Icons.arrow_forward_ios))
],
  );
}
