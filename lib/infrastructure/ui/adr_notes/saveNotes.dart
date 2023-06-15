import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/ui/adr_styles/color.dart';

class SaveNotes extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: colorGrey,
      appBar: AppBar(

        //Como usar las imagenes como iconos de la carpeta icons en assets para botones
        leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.home),
        ),
        backgroundColor: colorGrey,//Uso de Styles colorGrey
        elevation: 0,//delete shadowness in bottom border
        actions: [
          IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.call),
          ),
          IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
          ),
        ],


        
      
      ),
      body: Container(child: _FormSave()),
    

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorGreen,
        selectedItemColor: colorWhite,
        unselectedItemColor: colorWhite,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ajustes"
          ),
        ],
      ),
      
    );
  }
}


class _FormSave extends StatelessWidget{
  final titleController = TextEditingController();
  final bodyController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),//add padding all minus bottom
      child: Form(child: Column(children: <Widget>[
        TextFormField( //TITULO DE LA NOTA
          controller: titleController,


          //remove lower separation strip
          
          scrollPadding: EdgeInsets.all(15),
          maxLines: null,//Extend the text box when necessary but when it does not cover the entire space of the maximum number of lines
          //keyboardType: TextInputType.multiline,//Max lines but the box is not scrollable
          decoration: const InputDecoration( 
            hintText: "TÍTULO",
            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorGrey)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorGrey)
            ),
            
        ),),
        TextFormField( //CUERPO DE LA NOTA
          controller: bodyController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Empieza a escribir",
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorGrey)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorGrey)
            ),
        ),),
        
        
      ])),
    );
  }
}