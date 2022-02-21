import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search_screen/search_screen.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(onPressed: () {
                AppCubit.get(context).get_business("us");
                AppCubit.get(context).get_sports("us");
                AppCubit.get(context).get_science("us");


              }, icon: Icon(Icons.add)),
              IconButton(onPressed: () {
                AppCubit.get(context).get_business("cn");
                AppCubit.get(context).get_sports("cn");
                AppCubit.get(context).get_science("cn");


              }, icon: Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Search_Screen(),
                        ));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).change_theme();
                  },
                  icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: AppCubit.get(context).screen[AppCubit.get(context).index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).index,
            onTap: (value) {
              AppCubit.get(context).bottom_index(value);
            },
            items: AppCubit.get(context).bottom,
          ),
        );
      },
    );
  }
}
