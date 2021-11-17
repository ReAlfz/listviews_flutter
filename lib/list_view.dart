import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:listviews/detail_page.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class List_Views extends StatefulWidget{
  _ListViews createState() => _ListViews();
}

class _ListViews extends State<List_Views> {
  late Future <List<User>> _listData;

  Future<List<User>> getDatas() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData.map<User>((json) => User.fromJson(json)).toList();

    } else {
      throw Exception('failed get json');
    }
  }

  void initState() {
    _listData = getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextField(
              onChanged: (values) => {},
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
            child: FutureBuilder <List<User>> (
              future: _listData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<User>? list = snapshot.data;
                  return ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (context, position){
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPages(user: list[position])
                                )),
                        child: Container(
                          height: 100,
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: NetworkImage(list[position].image),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(list[position].name, style: TextStyle(fontSize: 20),),
                                )
                              ],
                            ),
                          ),
                        )
                      );
                   });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const Center(
                  child: Text('loading...'),
                );

                //if you want loading indicator...
                // return const Center(
                //   child: CircularProgressIndicator(),
                // );
              }
            ),
          ),
        ],
      ),
    );
  }
}