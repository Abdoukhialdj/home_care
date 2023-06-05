import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}


class _SettingsState extends
 State<Settings> {
  bool  switshValue=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        backgroundColor: Color.fromARGB(255, 240, 239, 235),
        appBar: AppBar(
    
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Settings ",style: TextStyle(fontWeight: FontWeight.bold),)),

          ],
        )
      ,backgroundColor: Colors.blue,),

      body: Column(
        children: [
           Column(children: [

            SizedBox(height: 30,),
              Card(
            elevation: 8.0,


                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("Dark mode",style: TextStyle(fontSize: 18)),
                  leading: Icon( Icons.dark_mode_outlined, ),
                  trailing: Switch(value: switshValue, onChanged: null,)
                  

                )
                ,
              )
           ],),
                 SizedBox(height: 20,),

          Card(
            elevation: 8.0,
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
           child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.lock_outline ,color: Colors.amber,),
                title: Text("Change password",style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  
                },
              ),
              _buildDivider(),
               ListTile(
                leading: Icon(FontAwesomeIcons.language,color: Colors.amber,),
                title: Text("Change language",style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  
                },
              ),
              _buildDivider(),

               ListTile(
                leading: Icon(Icons.location_on ,color: Colors.amber,),
                title: Text("Change location",style: TextStyle(fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  
                },
              )
            ],
           ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right:180),
            child: Text("Notofication Settings",style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          
            ),
            ),
          ),
          SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.only(right:10,left: 15),
            value: true,
            title: Text("Data save mode",style: TextStyle(fontSize: 20),), 
            onChanged:null,
            ),
             SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.only(right:10,left: 15),
            value: true,
            title: Text("Turn of notification",style: TextStyle(fontSize: 20)), 
            onChanged:null,
            ),
             SwitchListTile(
            activeColor: Colors.blue,
            contentPadding: const EdgeInsets.only(right:10,left: 15),
            value: true,
            title: Text("Recived App Updates",style: TextStyle(fontSize: 20)), 
            onChanged:(val){}
            ),
            
        ],
      ),
      ),

    );
  }
}

class _buildDivider extends StatelessWidget {
  const _buildDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height:1.0 ,
      color: Colors.grey.shade400,
    );
  }
}