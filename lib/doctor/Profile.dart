import 'package:flutter/material.dart';





class ProFile extends StatefulWidget {
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(26, 50, 50, 224),
        appBar: AppBar(
    
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
             
            Center(child: Text("Your Profile    ",style: TextStyle(fontWeight: FontWeight.bold),)),

          ],
        )
      ,backgroundColor: Colors.blue,),
      body: Material(
        color: Color.fromARGB(255, 240, 239, 235),

        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.symmetric(horizontal:100),
              child: Column(
                children: [
                  
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                         decoration: BoxDecoration(
                          image: DecorationImage(
                            image:AssetImage("images/doctor1.jpg",), fit: BoxFit.cover,
                            ),
                              borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                        BoxShadow(
                                          color:Colors.blue,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      
                                      ]
                            ),
                            
                      ),
      
                    ],
                    
                  ),
                //  Divider(color: Colors.blue,),

                  
                  
                  
                ],
              ), 


      
              ),

              SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.only(right: 40,left: 40),
                    child: Column(
                      children: [


                          ListTile(
                                  title: Text("First Name"),
                                  leading: Icon(Icons.person),
                                  trailing: Text('first name'),
                                 // focusColor: Colors.black,
                                 // tileColor: Colors.white,
                                 // splashColor: Colors.black,
                           
                                 ),
                                 Divider(color:Colors.blue.withOpacity(0.4),)
                  
                      ],
                    ),
                  )
          ],
        ),


        
      ),
    
        
    );
  }
}