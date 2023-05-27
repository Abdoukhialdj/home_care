import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:home_me/driver/Exitepage.dart';
import 'package:home_me/driver/ProfileDoct.dart';
import 'package:home_me/driver/Settings.dart';
import 'package:home_me/driver/dashboard.dart';

import 'dashboard.dart';

class Navdriver extends StatefulWidget {


  const Navdriver({super.key, });



  @override
  State<Navdriver> createState() => _Navdriver();
}

class _Navdriver extends State<Navdriver> {
  int index =0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.white,
              color: Colors.blue,
              buttonBackgroundColor: Colors.white,
              height: 50,
              items:[
              Icon(Icons.home),
              Icon(Icons.person),
              Icon(Icons.settings),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Exit App'),
                          content: Text('Are you sure you want to exit?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Exit' ,style: TextStyle(color: Colors.redAccent),),
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.exit_to_app),
                )
            ],
            animationDuration: Duration(milliseconds: 200),
            index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
            ),
            body:Container(
          child:getSeletedWidget(index:index),
        )
    );
  }
   Widget getSeletedWidget ({required int index}){

    Widget widget;
    
    switch (index){
      
      case 0:
      widget =const Dashboard();
        break;
      case 1:
      widget =const Profile();
        break;

        case 2:
        widget=const Settings();
        break;

        default:
        widget=ExitPage();
        break;

        
    }
     
   return widget  ;
 
} 
}