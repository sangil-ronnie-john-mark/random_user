import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'variable.dart';
import 'homepage.dart';
void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Loading(),
));

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getData() async {

try {
  final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 7));

  user = [jsonDecode(response.body)];
  print(user[0]['info']['version']);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> Homepage()));

}catch(e) {
 showDialog(context: context, builder: (context){
   return AlertDialog(
     title: Text('Message'),
     content: Text('No Internet Connection'),
     actions: [
       TextButton(onPressed: (){
         getData();
         Navigator.pop(context);
       }, child: Text('Retry'))
     ],
   );
 });
}


 }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://cdn.pixabay.com/animation/2023/10/08/03/19/03-19-26-213_512.gif', height: 200,),
            Text('Random User API', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            LinearProgressIndicator(color: Colors.blue,)
          ],
        ),
      ),
    );
  }
}
