import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'User.dart';

void main() {
  runApp( const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<User> postsFuture = fetchAlbum();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  

  static Future<User> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<User>(
            future: postsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {

                return ListView.builder(
                  itemCount:  snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data!.data![index];
                    return Container(

                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      height: 100,
                      width: double.maxFinite,
                      child:Row(

                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: Image.network(
                                  user.avatar.toString()
                              ),
                            ),
                          ),
                          SizedBox(width: 60,),
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              Expanded(flex: 3, child: Text('${user.firstName.toString()}  ${user.firstName.toString()}')),
                              Expanded(flex: 3, child: Text(user.email.toString())),
                            ],
                          ),

                        ],
                      )

                    );
                  },
                );
              } else {
                return const Text("No data available");
              }
            },
          ),
        ),
      ),
    );
  }}










