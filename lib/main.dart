import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API call'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
        final user = users[index];
        return ListTile(
          leading: Text('$index'),
          title: Text(user),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchApi,
        child: Icon(Icons.add), // Add an icon to the button
      ),
    );
  }

  void fetchApi() async{
    debugPrint('fetch API is called');
    const url = 'http://52.195.186.47:4208/getName';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState((){
      users = json['name'];
    });
    debugPrint('fetch API is finished');
  }
}
