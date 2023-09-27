import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/components/constant.dart';



class Sports_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: bulid_condtion(checkWifi==true?HomeCubit.get(context).sports:HomeCubit.get(context).sport_news, context, value: false),
        );
          }
    );



      }
}
