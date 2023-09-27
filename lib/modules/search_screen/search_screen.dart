import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/components/components.dart';



class Search_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var  searchController=TextEditingController();
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
      return Scaffold(

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: Stack(
            
            children: [
              TextFormField(
                style: TextStyle(fontSize: 20.sp), // Set the desired font size here
controller: searchController,
                decoration: InputDecoration(

                  border: OutlineInputBorder(
                  ),
                  labelText: "Search",
                  labelStyle: TextStyle(
                    fontSize: 20.sp
                  ),

                  prefixIcon: Icon(Icons.search,size: 20.h,),
                ),
                onChanged: (value) {
                HomeCubit.get(context).get_search(value);
                  },
              ),

if(searchController.text.isEmpty)
  Align(alignment: Alignment.center,child: Center(child: Container(height: 50.w,width: 50.w,child: CircularProgressIndicator())),),
         if(searchController.text.isNotEmpty)
           Padding(
                padding:  EdgeInsets.only(top: 70.h),
                child: bulid_condtion(HomeCubit.get(context).search,context,value: true),
              ),

            ],
          ),
        ),

      );
      },

    );
  }
}
