import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/web_veiw/web_veiw.dart';

Widget build_item(busines, context) => Padding(
      padding: const EdgeInsets.all(20.0),
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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage("${busines["urlToImage"]}"),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    "${busines["title"]}",
                    style: Theme.of(context).textTheme.body1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text(
                    "${busines["publishedAt"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
Widget bulid_condtion(List<dynamic?>task,context,{required bool value}){

  if(task.length>0){
   return ListView.builder(physics: BouncingScrollPhysics(),itemBuilder: (context, index) => build_item(task[index], context),itemCount: task.length,);

  }else{
  return value? Container():Center(child: CircularProgressIndicator());
  }
}

