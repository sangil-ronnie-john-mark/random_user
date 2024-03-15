import 'package:flutter/material.dart';
import 'variable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

String? name;
String? gender;
String? country;
String? email;
String? age;
String? phoneNumber;
String? username;
String? status;
class _HomepageState extends State<Homepage> {
  Future<void> getData() async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      user = [jsonDecode(response.body)];
    });


    name = user[0]['results'][0]['name']['title'] + '. ' + user[0]['results'][0]['name']['first'] + ' ' + user[0]['results'][0]['name']['last'];
    gender = user[0]['results'][0]['gender'];
    country = user[0]['results'][0]['location']['country'];
    email = user[0]['results'][0]['email'];
    username = user[0]['results'][0]['login']['username'];
    age = user[0]['results'][0]['dob']['age'].toString();
    phoneNumber = user[0]['results'][0]['phone'];
    print(age);
    await Future.delayed(Duration(seconds: 2));

  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Home'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          child: ListView(
          children: [
          Column(
          children: [
            
            //image and name
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  ClipOval(child: Image.network(user[0]['results'][0]['picture']['large']),),
                    SizedBox(height: 20,),
                    Text('$name', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          //data of the user

            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Icon((gender == "male")? Icons.male_outlined : Icons.female_outlined, color: (gender == "male")? Colors.blue : Colors.pink,),
                     Text('$gender'),
                   ],
                 ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Icon(Icons.location_city, color: Colors.red[800],),
                      Text('$country'),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.email, color: Colors.yellow[800],),
                      Text('$email'),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_2_outlined, color: Colors.green[800],),
                      Text('$username'),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue[800],),
                      Text('$age'),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.phone_android_outlined, color: Colors.purple[800],),
                      Text('$phoneNumber'),
                    ],
                  ),
              ],
              ),
            )
            
            
          ],
          )
        ],
      ), onRefresh: getData)
    );
  }
}
