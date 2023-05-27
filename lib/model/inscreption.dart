import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../fieldScreen.dart';
import 'ComptePatient.dart';

class InscreptionForm extends StatefulWidget {
  const InscreptionForm({super.key});

  @override
  State<InscreptionForm> createState() => _InscreptionFormState();
}

class _InscreptionFormState extends State<InscreptionForm> {
  TextEditingController dateController=TextEditingController();
  bool passToggle =true;
  String firstName='';
  String lastName='';
  String  phone='';
  String adress='';
  String  birthDay='';
  TextEditingController _confirmPassword =TextEditingController();
  final _formKey =GlobalKey<FormState>();
  final passcontroller=TextEditingController();
  @override
  void initState(){
    super.initState();
    dateController.text='';
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50,
              horizontal: 30
          ),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.stretch ,
                children: [
                  Image.asset('assets/homecare.png',height: 100,width: 100),
                  Center(
                    child: Text('Creer un compte ',
                      style:TextStyle(fontSize: 25) ,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                    ),
                    validator: (val) => val!.isEmpty ? 'Entrer your First Name':null,
                    onChanged: (val) => firstName =val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person)
                    ),
                    validator: (val) => val!.isEmpty ? 'Entrer your Last Name':null,
                    onChanged: (val) => lastName =val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone)
                    ),
                    validator: (val) => val!.isEmpty ? 'Entrer your phone':null,
                    onChanged: (val) => phone=val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Adress',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home)
                    ),
                    validator: (val) => val!.isEmpty ? 'Entrer your Adress':null,
                    onChanged: (val) => adress=val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:dateController ,
                    decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: 'Birth day',
                        border: OutlineInputBorder()
                    ) ,
                    validator: (val) => val!.isEmpty ? 'Entrer your Birth day':null,
                    onChanged: (val) => birthDay =val,
                    onTap: () async {
                      DateTime? pickeDate= await  showDatePicker(context: context,
                          initialDate:DateTime.now(),
                          firstDate: DateTime(0000),
                          lastDate: DateTime(2101)
                      );
                      if(pickeDate!=null){
                        String formattedDate=DateFormat("yyyy-MM-dd").format(pickeDate);
                        setState(() {
                          dateController.text=pickeDate.toString();
                        });
                      }else{
                        print('not selected');
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
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon:Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle ? Icons.visibility :Icons.visibility_off ,color: Color.fromARGB(255, 241, 176, 10)),
                        )

                    ),
                    validator: (value){
                      if(  value!.isEmpty){
                        return 'Entrer password';
                      } else if (value.length <9){
                        return "password length should not be less than 8 charactars";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:  _confirmPassword ,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Valider password',
                        border: OutlineInputBorder(),
                        prefixIcon:Icon(Icons.lock,)
                    ),

                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please enter re-password';
                      }else if(passcontroller.text !=_confirmPassword.text){
                        return 'password not correct';
                      }  },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        //TODO:Appliquer de la logique
                        print("compte created");
                        passcontroller.clear();
                        _confirmPassword.clear();
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>COmptePatient()));
                      }
                    },
                    child:Text('S\'inscrire'),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top:0.4),
                      child: Center(
                        child: Divider(
                          color: Color.fromARGB(255, 28, 22, 22),
                          indent:5,
                          height: 10,

                          thickness: 0.2,
                        ),
                      ) ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: [
                      Text(" you have acount  ?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>FormScreen()));
                        },
                        child: Text(
                          'log in',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:Color.fromARGB(255, 248, 185, 27),

                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}