import 'package:flutter/material.dart';
import 'edit.dart';

class InformationScreen extends StatelessWidget{
  // final String text;
  
  const InformationScreen({superKey});

  @override
  Widget build(BuildContext context){  
    
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(30.0),
      
      child: Column(
        children: [
          Row(

            children: [
              IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditScreen()),
                      );
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )),
            ],
          )
        ],
      )
    ),
    
  );
  }
}

