import 'package:flutter/material.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            
          
          decoration:BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50)
        )
            ),
            
            child: Column(
              children: [
                SizedBox(height: 50),
                ListTile(
                  title: Text("Hi doctor"),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}