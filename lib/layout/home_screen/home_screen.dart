import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Model(2,"https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/280px-Flag_of_Australia_%28converted%29.svg.png","Australia"),
  Model(3,"https://www.marefa.org/w/images/thumb/1/1a/Flag_of_Argentina.svg/1200px-Flag_of_Argentina.svg.png","Argentina"),
  Model(4,"https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/280px-Flag_of_the_People%27s_Republic_of_China.svg.png","China"),
  Model(5,"https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/280px-Flag_of_the_United_Arab_Emirates.svg.png","UAE"),
  Model(6,"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/240px-Flag_of_Turkey.svg.png","Turkey"),
  Model(7,"https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Flag_of_Switzerland_%28Pantone%29.svg/420px-Flag_of_Switzerland_%28Pantone%29.svg.png","Canada"),
  Model(8,"https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/240px-Flag_of_South_Korea.svg.png","Korea"),
  Model(9,"https://bramjnaa.com/wp-content/uploads/2019/12/006c8b01649c16b9c7617df0d375d07e5cd6c12a.jpg","Mexico"),
  Model(10,"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/240px-Flag_of_France.svg.png","France"),

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
           textDirection: AppCubit.get(context).isDirctionlty?TextDirection.ltr:TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).change_theme();
                    },
                    icon: Icon(Icons.brightness_4_outlined)),
                IconButton(onPressed: () {
               final alert=AlertDialog(

                 content:Container(
                   width: 500,
                    height: 400,
                   child:Container(height: 100,width: 200,child: ListView.separated( physics: BouncingScrollPhysics(),itemBuilder: (context, index) =>bulid_item(item[index],context) , separatorBuilder: (context, index) =>Padding(
                     padding: const EdgeInsets.only(top: 10,bottom: 10),
                     child: Container(color: Colors.grey,width: double.infinity,height: 1),
                   ) , itemCount: item.length))
                 )

               );
                  showDialog(context: context, builder: (context) =>alert ,);
                }, icon: Icon(Icons.flag))

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
          ),
        );
      },
    );
  }

  Widget bulid_item([Model? item,context])=>Row(
children: [
  Container(
      width: 30,
      height: 30,
      child: Image(image: NetworkImage("${item!.Text}") ,)),
  SizedBox(width:15),
  Text("${item.image}"),
Spacer(),
IconButton(padding: EdgeInsets.zero,onPressed: () {
  if(item.id==1){
  AppCubit.get(context).get_business('us');
  AppCubit.get(context).get_sports('us');
  AppCubit.get(context).get_science('us');
  Cacth_Helper.putLang('lang', 'us');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==2){
  AppCubit.get(context).get_business('au');
  AppCubit.get(context).get_sports('au');
  AppCubit.get(context).get_science('au');
  Cacth_Helper.putLang('lang', 'au');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==3){
  AppCubit.get(context).get_business('ar');
  AppCubit.get(context).get_sports('ar');
  AppCubit.get(context).get_science('ar');
  Cacth_Helper.putLang('lang', 'ar');
  var i=AppCubit.get(context).isDirctionlty=true;
  Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  Navigator.pop(context);

  }else if(item.id==4){
    AppCubit.get(context).get_business('cn');
    AppCubit.get(context).get_sports('cn');
    AppCubit.get(context).get_science('cn');
    Cacth_Helper.putLang('lang', 'cn');
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);

  }else if(item.id==5){
    AppCubit.get(context).get_business('ae');
    AppCubit.get(context).get_sports('ae');
    AppCubit.get(context).get_science('ae');
    Cacth_Helper.putLang('lang', 'ae');
    var i=AppCubit.get(context).isDirctionlty=false;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);
  }else if(item.id==6){
    AppCubit.get(context).get_business('tr');
    AppCubit.get(context).get_sports('tr');
    AppCubit.get(context).get_science('tr');
    Cacth_Helper.putLang('lang', 'tr');
    Navigator.pop(context);
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
  }else if(item.id==7){
    AppCubit.get(context).get_business('ch');
    AppCubit.get(context).get_sports('ch');
    AppCubit.get(context).get_science('ch');
    Cacth_Helper.putLang('lang', 'ch');
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);
  }
  else if(item.id==8){
    AppCubit.get(context).get_business('kr');
    AppCubit.get(context).get_sports('kr');
    AppCubit.get(context).get_science('kr');
    Cacth_Helper.putLang('lang', 'kr');
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);

  }else if(item.id==9){
    AppCubit.get(context).get_business('mx');
    AppCubit.get(context).get_sports('mx');
    AppCubit.get(context).get_science('mx');
    Cacth_Helper.putLang('lang', 'mx');
var i=AppCubit.get(context).isDirctionlty=true;
Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);
  }else if(item.id==10){
    AppCubit.get(context).get_business('fr');
    AppCubit.get(context).get_sports('fr');
    AppCubit.get(context).get_science('fr');
    Cacth_Helper.putLang('lang', 'fr');
    var i=AppCubit.get(context).isDirctionlty=true;
    Cacth_Helper.put_Dirctionlty('Dirctionlty', i);
    Navigator.pop(context);
  }
}, icon: Icon(Icons.arrow_forward_ios))
],
  );
}
