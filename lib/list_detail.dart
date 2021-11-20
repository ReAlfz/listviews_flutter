import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';
import 'model.dart';

class FollowerList extends StatefulWidget {
  int follower;
  String username;

  FollowerList({Key? key, required this.follower, required this.username})
      : super(key: key);

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  @override
  Widget build(BuildContext context) {
    Future<List<User>> getData() async {
      var dataUrl = 'https://api.github.com/users/${widget.username}/followers';
      final response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData.map<User>((json) => User.fromJson(json)).toList();
      } else {
        throw getData();
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xff1f2633),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'follower ${widget.follower}',
                  style: const TextStyle(
                    color: Color(0xff1f2633),
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.all(5)),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<User>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<User>? list = snapshot.data;
                  return ListView.builder(
                      itemCount: list!.length,
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
                                color: const Color(0xffF5F5F5),
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
                                        backgroundImage:
                                            NetworkImage(list[position].image),
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
              }),
        ),
      ],
    );
  }
}

class FollowingList extends StatefulWidget {
  int follower;
  String username;

  FollowingList({Key? key, required this.follower, required this.username})
      : super(key: key);

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  @override
  Widget build(BuildContext context) {
    Future<List<User>> getData() async {
      var dataUrl = 'https://api.github.com/users/${widget.username}/following';
      final response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData.map<User>((json) => User.fromJson(json)).toList();
      } else {
        throw getData();
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Padding(padding: EdgeInsets.all(5)),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'follower ${widget.follower}',
                  style: const TextStyle(
                    color: Color(0xff1f2633),
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xff1f2633),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<User>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<User>? list = snapshot.data;
                  return ListView.builder(
                      itemCount: list!.length,
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
                                color: const Color(0xffF5F5F5),
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
                                        backgroundImage:
                                            NetworkImage(list[position].image),
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
              }),
        ),
      ],
    );
  }
}
