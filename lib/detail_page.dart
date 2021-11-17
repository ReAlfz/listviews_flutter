import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class DetailPages extends StatelessWidget {
  final User user;
  const DetailPages({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('detail page : ${user.name}'),
      ),
    );
  }
}