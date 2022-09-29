import 'package:flutter/material.dart';
import 'package:flutterproject/ui/screens/history_screen.dart';
import 'package:flutterproject/ui/screens/map_screen.dart';
import 'package:flutterproject/widgets/navigation_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
        backgroundColor: Colors.blueAccent,
        elevation: 30,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                HistoryScreen(),
                ));
              },
              icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      drawer:  NavigationDrawer(),
      body: MapScreen(),
    );
  }
}

