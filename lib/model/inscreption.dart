import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

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

  bool passToggle = true;
  bool confirmPassToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter your first name' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter your last name' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter your phone number' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter your email' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 248, 185, 27)),
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
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 248, 185, 27)),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmPassToggle = !confirmPassToggle;
                        });
                      },
                      child: Icon(
                        confirmPassToggle ? Icons.visibility : Icons.visibility_off,
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
                SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    filled: true,
                    fillColor: Color.fromARGB(255, 247, 231, 231).withOpacity(0.5),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home, color: Color.fromARGB(255, 248, 185, 27)),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter your Address' : null,
                  onTap: () async {
                    LatLng? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectLocationScreen(),
                      ),
                    );
                    if (result != null) {
                      _addressController.text = result.toString();
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Put your form submission logic here
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // <-- Add this
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(),
                          ),
                        );
                      },
                      child: Text(
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

  Future<void> _getUserLocation() async {
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
          builder: (ctx) => Container(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: selectedLocation == null
          ? Center(child: CircularProgressIndicator())
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
                    child: Icon(
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
