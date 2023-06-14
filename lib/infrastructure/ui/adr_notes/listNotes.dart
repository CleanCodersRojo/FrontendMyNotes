import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton
      (child: Icon(Icons.add), onPressed: (){
        //Navigator.pushNamed(context, SaveNotes.ROUTE);
      },),
      appBar: AppBar(title: Text("Listado"),),
      body: Container (child: ListView(children: <Widget>[
        ListTile(title: Text("Nota 3"),),
        ListTile(title: Text("Nota 1"),),
        ListTile(title: Text("Nota 1"),),
        ListTile(title: Text("Nota 1"),),
        ListTile(title: Text("Nota 1"),),
        ListTile(title: Text("Nota 1"),),
        ListTile(title: Text("Nota 3"),),
        ListTile(title: Text("Nota 2"),),
      ],),),
    );
  }
}