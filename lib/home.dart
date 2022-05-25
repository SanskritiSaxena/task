// ignore_for_file: unused_import, prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_declarations, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, unused_field

import 'package:development/detail.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Future<Modeluser?> createuser(String name, String job) async {
  final String Url = "https://reqres.in/api/users";

  var response =
      await http.post(Uri.parse(Url), body: {"name": name, "job": job});
  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;

    return modeluserFromJson(responseString);
  } else {
    return null;
  }
}

class _HomeState extends State<Home> {
  Modeluser? _modeluser;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController JobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: NameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Job Name",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: JobController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Job cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 380,
                ),
                Container(
                  height: 40,
                  width: 350,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          String name = NameController.text;
                          String job = JobController.text;
                          Modeluser? data = await createuser(name, job);
                          setState(() {
                            _modeluser = data;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail()));
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
