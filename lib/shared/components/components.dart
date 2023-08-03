import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/modules/web_veiw/web_veiw.dart';
import 'package:news/shared/cubit/cubit.dart';

Widget build_item(busines, context) => Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Web_Veiw(busines["url"]),
                  ));
            },
            child: Container(
              width: 120.w,
              height: 120.w,
clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: "${busines["urlToImage"]}",
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
                      "${busines["title"]}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      "${busines["publishedAt"]}",
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
    );
Widget bulid_condtion(List<dynamic>task,context,{required bool value}){

  if(task.length>0){
   return ListView.builder(physics: BouncingScrollPhysics(),itemBuilder: (context, index) => build_item(task[index], context),itemCount: task.length,);

  }else{
  return value? Container():Center(child: CircularProgressIndicator());
  }
}

