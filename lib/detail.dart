// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
List? listResponse;

class Detail extends StatefulWidget {
  Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future api() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    api();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(listResponse![index]['avatar']),
              ),
              title: Row(
                children: [
                  Text(listResponse![index]['first_name']),
                  SizedBox(
                    width: 5,
                  ),
                  Text(listResponse![index]['last_name']),
                ],
              ),
              subtitle: Text(listResponse![index]['email']),
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse?.length,
      ),
    );
  }
}
