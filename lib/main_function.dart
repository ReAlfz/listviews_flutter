import 'package:flutter/material.dart';
import 'package:listviews/list_view.dart';

class Main_Function extends StatefulWidget {
  const Main_Function({Key? key}) : super(key: key);

  _MainFunction createState() => _MainFunction();
}

class _MainFunction extends State<Main_Function> {
  int _currentIndex = 0;

  void _changed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadPage(),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade900,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => _changed(0),
                icon: Icon(
                  Icons.person,
                  size: 25,
                  color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                ),
              ),

              IconButton(
                onPressed: () => _changed(1),
                icon: Icon(
                  Icons.settings,
                  size: 25,
                  color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadPage() {
    switch (_currentIndex){
      case 0 :
        return List_Views();
      case 1 :
        return Center(child: Text('Index = $_currentIndex'));
      default :
        return Container();
    }
  }
}