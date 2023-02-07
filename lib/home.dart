import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  List list=[];
  ///=============Read Date============///
  Future ReadDate() async{
    final url = "http://192.168.1.63/Flutter_api2/controllers/readDate.php ";
    final res = await http.get(Uri.parse(url));

    if(res.statusCode == 200){
      final red = jsonDecode(res.body);

      setState(() {
        list.addAll(red);
        print(list);
      });
    }
    // return ReadDate();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
    }

    getDate() async{
      await ReadDate();

  Adduser(){
    showDialog(
        context:context,
        build: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: username,
                decoration: InputDecoration(),

              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(),
              ),
              ElevatedButton(onPressed: () {
                print(username.text);
                print(name.text);
              }, child: Text("Send"))
            ],
        ),
      ),
     );
    };
  };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flutter_API"),
        actions: [
          IconButton(onPressed: () {
            Adduser();
          }, icon: Icon(Icons.add_circle_outlined,size: 30.0,))
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index]['username']),
            subtitle: Text(list[index]['name']),
            leading: CircleAvatar(
              radius: 20.0,
              child: Text(list[index]['name'].toString().substring(0,2).toUpperCase()),
            ),
            trailing: Container(
              width: 100.0,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: Colors.teal,)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.red,)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

