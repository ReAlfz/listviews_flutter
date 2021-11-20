import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listviews/detail_model.dart';
import 'package:listviews/list_detail.dart';

import 'model.dart';

class DetailPages extends StatefulWidget {
  final User user;

  const DetailPages({Key? key, required this.user}) : super(key: key);

  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPages> {
  Future<DetailUser> getDetailUser() async {
    var username = widget.user.username;
    var url = 'https://api.github.com/users/$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return DetailUser.fromJson(jsonDecode(response.body));
      // return jsonData.map<DetailUser>((json) => DetailUser.fromJson(json));

    } else {
      throw _DetailPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff6E5E61),
        body: FutureBuilder<DetailUser>(
            future: getDetailUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DetailUser? users = snapshot.data;
                return Column(
                  children: [
                    SizedBox(
                      height: 275,
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: const Color(0xff53A2BE),
                              backgroundImage: NetworkImage(users!.image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Text(
                              users.name,
                              style: const TextStyle(
                                color: Color(0xffF5F5F5),
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 5),
                            child: Text(
                              users.username,
                              style: const TextStyle(
                                color: Color(0xffF5F5F5),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              users.company,
                              style: const TextStyle(
                                color: Color(0xffF5F5F5),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffC2C2C1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            )),
                        child: Expanded(
                          child: PageView(
                            controller: PageController(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              FollowingList(
                                follower: users.following,
                                username: users.username,
                              ),
                              FollowerList(
                                follower: users.followers,
                                username: users.username,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Center(
                child: Text('loading...'),
              );
            }));
  }
}
