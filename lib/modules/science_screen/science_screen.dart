import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/app_cubit/home_cubit/home_cubit.dart';
import 'package:news/shared/app_cubit/home_cubit/home_states.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/components/constant.dart';



class Science_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(body:
        bulid_condtion(checkWifi==true?HomeCubit
            .get(context)
            .science:HomeCubit
            .get(context)
            .science_news, context, value: false),);
      }
    );


  }
}
