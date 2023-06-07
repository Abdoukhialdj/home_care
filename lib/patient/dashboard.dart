import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> imgs = [
    "asknurse.png",
    "askdoctor.png",
    "tashe.png",
    "medicalfolder.png",
  ];

  List<String> texte = [
    'Ask For Nurse',
    "Ask For Doctor",
    "Consult planing",
    "medical folder",
  ];

  DateTime? selectedDate;
  int selectedIndex = -1;

  void _openCalendar(BuildContext context, VoidCallback callBack) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      print(selectedDate);
      callBack();
      _showDialog(context, pickedDate);
    }
  }

  reserve(String path) async {
    print(selectedDate);
    try {
      print(token);
      print(selectedDate?.toUtc().toString());
      await http.post(
          Uri.parse(
            "http://10.0.2.2:8000/$path/",
            
          ),
          body: {
            "patient" : token,
            "appointment_time" : selectedDate?.toUtc().toString(),
          },headers: {
            "Authorization" : "Bearer $token"
          }).then((value) {
        print(value.body);
        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar( const SnackBar(content: Text("reserved")));
        }
      }).catchError((error) {
        print("object");
        print(error);
      });
    } catch (e) {
      print(e);
    }
  }

  void _showDialog(BuildContext context, DateTime pickedDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Date'),
          content: Text('Date: ${pickedDate.toIso8601String()}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const[
            Text(
              'Hello patient',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/patient.png"),
            ),
          ],
        ),
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const SizedBox(height: 15),
              Row(
                children: const[
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "What do we have today?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.blue)),
                ],
              ),
             const SizedBox(height: 44),
              GridView.builder(
                gridDelegate : const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (index == 0 || index == 1) {
                        _openCalendar(context, (){
                          reserve(index == 0 
                         ? "nurseappointments" : "doctorappointments");
                        });
                      } else {
                        // Handle other cards
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:  const [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage("assets/${imgs[index]}"),
                          ),
                          Text(
                            "${texte[index]}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
