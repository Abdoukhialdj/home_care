import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:home_me/doctor/navigationBar.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

import '../fieldScreen.dart';

enum Gender { male, female }

class InscreptionForm extends StatefulWidget {
  const InscreptionForm({Key? key}) : super(key: key);

  @override
  _InscreptionFormState createState() => _InscreptionFormState();
}

class _InscreptionFormState extends State<InscreptionForm> {
  Gender? _gender;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  List<String> genders = ['Male', "Female"];
  String? _SelectedGender = 'Male';


  signup() async {
    try {
      await http.post(
          Uri.parse(
            "http://10.0.2.2:8000/register/",
          ),
          body: {
            "first_name": _firstNameController.text,
            "last_name": _lastNameController.text,
            "email": _emailController.text,
            "address": _addressController.text,
            "gender": _SelectedGender,
            "phone_number": _phoneNumberController.text,
            "password": _passwordController.text,
          }).then((value) {
        print(value.body);
        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("account has been created successfully , please log in"),
            backgroundColor: Colors.green,
          ));
        }
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneNumberController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _addressController.clear();
        _SelectedGender = "";
      }).catchError((error) {
        print(error);
      });
    } catch (e) {
      print(e);
    }
  }

  bool passToggle = true;
  bool confirmPassToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/homecare.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    filled: true,
                    fillColor:
                        Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person,
                        color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your first name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 247, 231, 231)
                        .withOpacity(0.5),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person,
                        color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your last name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 247, 231, 231)
                        .withOpacity(0.5),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.phone,
                        color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your phone number' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 247, 231, 231)
                        .withOpacity(0.5),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email,
                        color: const Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter your email' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor:
                        Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 248, 185, 27)),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        color: Color.fromARGB(255, 248, 185, 27),
                      ),
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your password' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: confirmPassToggle,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor:
                        Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 248, 185, 27)),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmPassToggle = !confirmPassToggle;
                        });
                      },
                      child: Icon(
                        confirmPassToggle
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 248, 185, 27),
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Confirm your password';
                    } else if (val != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 247, 231, 231)
                        .withOpacity(0.5),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.home,
                        color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your Address' : null,
                  onTap: () async {
                    /*LatLng? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectLocationScreen(),
                      ),
                    );
                    if (result != null) {
                      _addressController.text = result.toString();
                    }*/
                  },
                ),
                const SizedBox(height: 20),
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
                          dropdownColor: const Color.fromARGB(211, 255, 254, 254),
                          value: _SelectedGender,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.amber,
                          ),
                          items: genders
                              .map((item) => DropdownMenuItem(
                                    child:  Text(item),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _SelectedGender = item),
                        ),
                      ),
                    ), const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    signup();
                    // Put your form submission logic here
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // <-- Add this
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? selectedLocation;
  List<Marker> markers = [];

  /* Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: selectedLocation!,
          builder: (ctx) =>  Container(
            child : const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      );
    });
  }*/

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: selectedLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: selectedLocation,
                zoom: 13.0,
                onTap: (LatLng, latlng) {
                  setState(() {
                    selectedLocation = latlng;
                    markers.clear();
                    markers.add(
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: latlng,
                        builder: (ctx) => Container(
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: markers),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (selectedLocation != null) {
            Navigator.of(context).pop(selectedLocation);
          }
        },
      ),
    );
  }
}
