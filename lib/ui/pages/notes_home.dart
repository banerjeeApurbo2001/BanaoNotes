import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesHomPage extends StatefulWidget {
  @override
  _NotesHomPageState createState() => _NotesHomPageState();
}

class _NotesHomPageState extends State<NotesHomPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Banao Notes"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(219, 84, 84, 1),
        notchMargin: 8.0,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('My Notes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              title: Text('Bin'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        //backgroundColor: Colors.indigo,
        onPressed: () => Navigator.pushNamed(context, "add_note"),
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () => Navigator.pushNamed(context, "add_note"),
//      ),
    );
  }


}
