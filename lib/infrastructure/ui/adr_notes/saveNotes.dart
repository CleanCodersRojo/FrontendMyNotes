import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/adr_styles/color.dart';

class SaveNotes extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: colorGrey,
      appBar: AppBar(
        title: Text("Iconos"),
        backgroundColor: colorGrey,//Uso de Styles colorGrey
        //delete shadowness in bottom border
        elevation: 0,
        
        ),
      body: Container(child: _FormSave()),
    );
  }
}


class _FormSave extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),//add padding all minus bottom
      child: Form(child: Column(children: <Widget>[
        TextFormField( //TITULO DE LA NOTA
          //remove lower separation strip
          
          scrollPadding: EdgeInsets.all(15),
          maxLines: null,//Extend the text box when necessary but when it does not cover the entire space of the maximum number of lines
          //keyboardType: TextInputType.multiline,//Max lines but the box is not scrollable
          decoration: InputDecoration(
            hintText: "TÍTULO",
            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorWhite)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorWhite)
            ),
        ),),
        TextFormField( //CUERPO DE LA NOTA
          maxLines: null,
          decoration: InputDecoration(
            hintText: "Empieza a escribir...",
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorWhite)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorWhite)
            ),
        ),)
      ])),
    );
  }
}