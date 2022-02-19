import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class Search_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(

                  border: OutlineInputBorder(
                  ),
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                AppCubit.get(context).get_search(value);
                  },
              ),
              Expanded(
                child: bulid_condtion(AppCubit.get(context).search,context,value: true)
              ),

            ],
          ),
        ),

      );
      },

    );
  }
}
