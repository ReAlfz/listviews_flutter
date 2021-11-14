import 'dart:convert';
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class List_Views extends StatefulWidget{
  _ListViews createState() => _ListViews();
}

class _ListViews extends State<List_Views> {
  late final List<User> _list = [];
  String filter = '';

  Future<List<User>> getDatas() async {
    List<User> nList = [];
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        nList = jsonData.map<User>((json) => User.fromJson(json)).toList();
      });

    } else {
      throw Exception('failed get json');
    }

    return nList;
  }

  void initState() {
    getDatas().then((value) => {
      _list.addAll(value)
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextField(
              onChanged: (values) {},
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'search',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.5
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, position) {
                  return Container(
                    height: 100,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.blue,
                              backgroundImage: NetworkImage(_list[position].image),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(_list[position].name, style: TextStyle(fontSize: 20),),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}