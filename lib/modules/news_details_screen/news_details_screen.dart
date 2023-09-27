import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/layout/home_screen/home_screen.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';

class NewsDetailsScreen extends StatelessWidget {
String ?  imageUrl;
String ? title;
String?description;
  NewsDetailsScreen(this.imageUrl,this.title,this.description);
  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Container(
            height: double.infinity,
            width: double.infinity,

            child: CachedNetworkImage(

              imageUrl: "${imageUrl}",

              fit: BoxFit.cover,

              placeholder: (context, url) => Container(height: 120.w,width: 120.w),

              errorWidget: (context, url, error) => Container(height: 120.w,width: 120.w),

            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(height: 200.h,child: Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 20.w,bottom: description!.length>110?20.h:40.h,top: 30.h),
                child:
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Text("${description?.replaceAll("...", "")}",style: Theme.of(context).textTheme.bodyText1?.copyWith(

                      color: HomeCubit.get(context).isDark?Colors.white:Colors.black,

                    ),
                    ),
                  ),
                ),
              ),width: double.infinity,decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight:  Radius.circular(30),topLeft: Radius.circular(30))
                  ,color: Theme.of(context).scaffoldBackgroundColor,
              ),),
              Positioned(
                bottom: description!.length>90?170.h: 150.h,

                child: Container(child:          Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: Center(
                    child: Text("$title",style: Theme.of(context).textTheme.bodyText1?.copyWith(

                      color: HomeCubit.get(context).isDark?Colors.white:Colors.black,

                    ),
                    ),
                  ),
                ),width: 300.w,decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF5F5F5).withOpacity(0.55),
                ),),
              ),

            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Container(
                child: IconButton(onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                }, icon: Icon(Icons.arrow_back_ios_new)),
                height: 40,width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF5F5F5).withOpacity(0.55),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
