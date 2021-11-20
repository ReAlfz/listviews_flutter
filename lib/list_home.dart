import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listviews/detail_page.dart';

import 'model.dart';

class List_Home extends StatefulWidget {
  const List_Home({Key? key}) : super(key: key);

  @override
  _ListViews createState() => _ListViews();
}

class _ListViews extends State<List_Home> {
  late Future<List> _future;
  String searchText = '';
  Future<List<User>> getDatas() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw getDatas();
    }
  }

  Future<List<User>> getSearchData(String data) async {
    var dataUrl = 'https://api.github.com/search/users?q=$data';
    final response = await http.get(Uri.parse(dataUrl));

    if (response.statusCode == 200) {
      SearchUser datas =  SearchUser.fromJson(jsonDecode(response.body));
      return datas.items.toList();
    } else {
      throw getDatas();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _future = getDatas();
    });
  }

  void _changeData (String data) {
    searchText = data;
    setState(() {
      if (searchText.isEmpty || searchText == '') {
        _future = getDatas();
      } else {
        _future = getSearchData(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC2C2C1),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 10),
            child: TextField(
              style: const TextStyle(color: Color(0xff50514F)),
              cursorColor: const Color(0xff50514F),
              onChanged: (values) => _changeData(values),
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'search',
                prefixIcon: const Icon(Icons.search,color: Color(0xff50514F),),
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xff53A2BE), width: 2.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<User>? list = snapshot.data!.cast<User>();
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPages(user: list[position]))),
                              child: SizedBox(
                                height: 115,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  color:
                                      const Color(0xffF5F5F5),
                                  margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 10, 10),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundColor:
                                              const Color(0xff53A2BE),
                                          backgroundImage: NetworkImage(
                                              list[position].image),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          list[position].username,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff50514F)),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const Padding(
                                        padding: EdgeInsets.all(25),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff50514F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
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
                }),
          ),
        ],
      ),
    );
  }
}
