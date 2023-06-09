import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_me/main.dart';
import 'package:home_me/patient/navpatient.dart';

import 'doctor/navigationBar.dart';
import 'driver/navdriver.dart';
import 'model/getHelp.dart';
import 'model/inscreption.dart';
import 'nurse/navnurse.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  _FormScreenState() {
    _SelectedVal = _speList[0];
  }

  final _formfield = GlobalKey<FormState>();
  final _form = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  List<String> _speList = ['Patient', 'Doctor', 'Nurse', 'Driver', 'Admin'];
  String? _SelectedVal = 'Patient';

  bool passToggle = true;

  login() async {
    try {
      await http.post(
          Uri.parse(
            "http://10.0.2.2:8000/login/",
          ),
          body: {
            "role": _SelectedVal?.toLowerCase(),
            "email": emailcontroller.text,
            "password": passcontroller.text,
          }).then((value) {
        print(value.body);
        if (value.statusCode == 200) {
          var body = jsonDecode(value.body);
          token = body["access_token"];
          email = emailcontroller.text;
          if (_SelectedVal == 'Patient') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Navnpatient(),
              ),
            );
          } else if (_SelectedVal == 'Doctor') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationBaar(),
              ),
            );
          } else if (_SelectedVal == 'Nurse') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Navnurse(),
              ),
            );
          } else if (_SelectedVal == 'Driver') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Navdriver(),
              ),
            );
          }
        }
      }).catchError((error) {
        print(error);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Form(
                key: _formfield,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/doctor2.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 248, 185, 27),
                        ),
                      ),
                      validator: (value) {
                        bool emailValid =
                            RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!emailValid) {
                          return "Please,Check your Adress Email  ";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passcontroller,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 248, 185, 27),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(
                            passToggle
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 248, 185, 27),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entrer password';
                        } else if (value.length < 8) {
                          return "password length should not be less than 8 characters";
                        }
                      },
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 46, right: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: Color.fromARGB(69, 54, 44, 44), width: 0.5),
                        color:
                            Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          style: const TextStyle(
                            color: Color.fromARGB(181, 8, 8, 5),
                            fontSize: 16,
                          ),
                          dropdownColor: Color.fromARGB(211, 255, 254, 254),
                          value: _SelectedVal,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.amber,
                          ),
                          items: _speList
                              .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _SelectedVal = item),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formfield.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Need help  ?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetHelp(),
                              ),
                            );
                          },
                          child: Text(
                            'Get help',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 248, 185, 27),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(82, 255, 255, 255),
                          ),
                        ),
                        Text(
                          "    OR     ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Flexible(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(82, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: _form,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont have an account?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InscreptionForm(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 185, 27),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
