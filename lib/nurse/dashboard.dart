

import 'package:flutter/material.dart';

import 'ItemPagedash.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List imgs=[
    "plan.png",
    "tashe.png",
    "typerepport.png",
    "absent.png",
    
  ];

  List texte=[
    'Consult Plan',
    "Team Mates",
    "Type Repport",
    "Declare Absence",
    

  ];
    int index =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
          Text('Hello Nurse',style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold),),
            CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/nurse.png"),
    
                    ), 
          ],
        ),
        
      ),
      body: Material(
      color: Colors.white,
      child: SingleChildScrollView(
        
        padding: EdgeInsets.only(top:5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  SizedBox(height: 15,),
                     Row(
                       children: [
                         Padding(
                          padding:EdgeInsets.only(left: 15) ,
                          child: Text("What do we have today?",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color:Colors.black54,
                          ),),),
                          Expanded(child:Divider(color: Colors.blue,) )
                       ],
                     ),

                     SizedBox(height: 44,),
                     GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                       itemCount:4,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index ){
                          return InkWell(
                            onTap: (){
                           switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemPage()),
            );
            break;
          case 1:
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinishTashe()),
            );
            break;
        
        }
                            },
                            child: Container(
                              margin:EdgeInsets.all(10) ,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:Colors.blue,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ]

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage("assets/${imgs[index]}"),
                                    
                                  ),
                                  Text("${texte[index]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                  ,
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    )
                     

          
        ),

        
        
                 
                
    
      ),
     
      

      
        
      
      );
  
  }
  
}