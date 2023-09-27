import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/modules/news_details_screen/news_details_screen.dart';
import 'package:news/modules/web_veiw/web_veiw.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';

Widget build_item(model, context) => GestureDetector(
  onTap: (){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewsDetailsScreen(model["urlToImage"],model["title"],model['description'])), (route) => false);
  },
  child:   Padding(

        padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h ),

        child: Row(

          children: [

            GestureDetector(

              onTap: () {

                Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) => Web_Veiw(model["url"]),

                    ));

              },

              child: Container(

                width: 120.w,

                height: 120.w,

  clipBehavior: Clip.antiAlias,

                child: CachedNetworkImage(

                  imageUrl: "${model["urlToImage"]}",

                  fit: BoxFit.cover,

                  placeholder: (context, url) => Container(height: 120.w,width: 120.w),

                  errorWidget: (context, url, error) => Container(height: 120.w,width: 120.w),

                ),

                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.r),



                ),

              ),

            ),

            SizedBox(

              width: 20.w,

            ),

            Expanded(

              child: Container(

                height: 140.h,

                child: Padding(

                  padding:  EdgeInsets.only(bottom: 10.h),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [

                      Text(

                        "${model["title"]}",

                        style: Theme.of(context).textTheme.bodyText1?.copyWith(

                          color: HomeCubit.get(context).isDark?Colors.white:Colors.black,

                        ),

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                      Spacer(),

                      Text(

                        "${model["publishedAt"].toString().substring(0,10)}",

                        style: TextStyle(

                          color: Colors.grey,

                          fontSize: 15.sp

                        ),

                      )

                    ],

                  ),

                ),

              ),

            ),

          ],

        ),

      ),
);
Widget bulid_condtion( list,context,{required bool value}){

  if(list.length>0){

   return ListView.builder(physics: BouncingScrollPhysics(),itemBuilder: (context, index) => build_item(list[index], context),itemCount: list.length,);

  }else{
  return value? Container():Center(child: CircularProgressIndicator());


  }
}

