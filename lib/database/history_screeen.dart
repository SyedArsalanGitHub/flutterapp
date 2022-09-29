import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/database/history.dart';

import 'package:flutterproject/ui/screens/map_screen.dart';
import 'package:flutterproject/database/db_helper.dart';



class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title, required this.distance, required this.time}) : super(key: key);


  final String title;
  String distance;
  String time;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  late  Future<List<NotesModel>> cartList ;
  DBHelper? dbHelper ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper() ;
    loadData();

  }

  loadData ()async{

    cartList =  dbHelper!.getCartListWithUserId() ;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: cartList,
        builder: (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                        child: Card(
                            child: ListTile(
                              horizontalTitleGap: 3,
                              minVerticalPadding: 5,
                              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              title: Text(snapshot.data![index].distance , style: TextStyle(color: Colors.black ,fontSize: 18, fontWeight: FontWeight.bold),),
                              subtitle: Text(snapshot.data![index].time.toString() , style: TextStyle(color: Colors.black , fontWeight: FontWeight.normal)),
                            )),
                      );

                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dbHelper!.insert(
              NotesModel(
                  distance: "$distance",
                  time: "$time",

              )
          ).then((value){
            print('added');
          }).onError((error, stackTrace) {
            print("error"+error.toString());
          });
          setState(() {
            cartList = dbHelper!.getCartListWithUserId() ;
          });

        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
