import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckMail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Inbox',),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView.builder(shrinkWrap: true,itemCount: 100,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8.0),
                ),
              height: MediaQuery.of(context).size.height*.09,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('mail descriptions',style: TextStyle(fontSize: 16),),
              ],),
            ),
          );
        }),
      ),
    );
  }

}