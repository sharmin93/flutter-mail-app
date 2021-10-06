import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

class LogIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

   return Scaffold(body:Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
     Row(
       children: <Widget>[
         SizedBox(height: 10.0),
         Text('Welcome'),
         SizedBox(height: 5.0),
       ],
     ),
     /// Email
     Container(
       decoration: BoxDecoration(
     color: Color(0xFFF2F2F2),
     borderRadius: BorderRadius.circular(8.0)
      ),
           child: TextField(
         onChanged: (email){
         },
     keyboardType: TextInputType.emailAddress,
     decoration: InputDecoration(
     contentPadding: EdgeInsets.all(22.0),
     border: InputBorder.none,
     labelText: 'Email',
    labelStyle: TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    color: Color(0xFF353B50),
       ),
       hintText: 'Please enter email'
      ),
      )
    ),

     // Password
     Container(
       decoration: BoxDecoration(
           color: Color(0xFFF2F2F2),
           borderRadius: BorderRadius.circular(8.0)
       ),
       child: TextField(
         onChanged: (password){

         },
         decoration: InputDecoration(
           contentPadding: EdgeInsets.all(22.0),
           border: InputBorder.none,
           labelText: 'Password',
           labelStyle: TextStyle(
             fontFamily: 'OpenSans',
             fontSize: 12,
             color: Color(0xFF353B50),
           ),
           hintText: 'Please enter password',
           // suffixIcon: IconButton(
           //   icon: Icon(
           //     _hidePassword
           //         ? Icons.visibility
           //         : Icons.visibility_off,
           //     color: Color(0xff353B50),
           //   ),
           //   onPressed: () {
           //     setState(() {
           //       _hidePassword = !_hidePassword;
           //     });
           //   },
           // ),
         ),
       )
     ),
     SizedBox(height: 10),

     // Sign In button
     SizedBox(
       width: double.maxFinite,
       child: RaisedButton(
         elevation: 0.0,
         color:Colors.grey,
         padding: EdgeInsets.all(16.0),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
         onPressed: () async {
           var apiCall=APICall();
          var res= await apiCall.logIn({
               "address": "usssy@pussport.com",
               "password": "us12003456"});
           if(res.success){
             print('logIn SuccessFull ${res.token}');
           }else{
             print('error ${res.errorTitle}');
             print('error mesage${res.errorMessage}');
           }
         },
         child: Text('Sign In',
           style: TextStyle(
               fontFamily: 'SFProDisplaySemibold',
               fontSize: 18,
               color: Colors.white
           ),
         )

       ),
     ),
   ],),);
  }

}