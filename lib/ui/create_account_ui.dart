import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mail_app/bloc/create_account_bloc.dart';
import 'package:flutter_mail_app/response_model/create_account_response_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

class CreateAccount extends StatelessWidget {
  bool _hidePassword = true;
  final accountCreateBloc = CreateAccountBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Text(
                    'Create Account',
                    style:
                        TextStyle(fontSize: 25, color: Colors.deepOrangeAccent),
                  ),

                  /// Email
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  StreamBuilder<String>(
                      stream: accountCreateBloc.email,
                      builder: (context, snapshot) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.deepOrangeAccent)),
                            child: TextField(
                              onChanged: (email) {
                                accountCreateBloc.changedEmail.call(email);
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
                                  hintText: 'Please enter email'),
                            ));
                      }),
                  SizedBox(
                    height: 15,
                  ),

                  /// Password
                  Row(
                    children: [
                      Expanded(
                        child: StreamBuilder<String>(
                            stream: accountCreateBloc.password,
                            builder: (context, snapshot) {
                              return Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      border: Border.all(
                                          color: Colors.deepOrangeAccent),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: TextField(
                                    onChanged: (password) {
                                      accountCreateBloc.changedPassword
                                          .call(password);
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
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xff353B50),
                                        ),
                                        onPressed: () {
                                          // setState(() {
                                          //   _hidePassword = !_hidePassword;
                                          // });
                                        },
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  // Sign In button
                  StreamBuilder<CreateAccountResponse>(
                      stream: accountCreateBloc.accountCreate,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: RaisedButton(
                                        elevation: 0.0,
                                        color: Colors.deepOrangeAccent,
                                        padding: EdgeInsets.all(16.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        onPressed: () async {
                                          CreateAccountResponse resp =
                                              await accountCreateBloc
                                                  .createAccountButton();
                                          if (resp.success) {
                                            Navigator.pushNamed(
                                                context, '/login');
                                          }
                                        },
                                        child: Text(
                                          'Create Account',
                                          style: TextStyle(
                                              fontFamily:
                                                  'SFProDisplaySemibold',
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            snapshot.hasError
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: Text(
                                      snapshot.hasError
                                          ? snapshot.error.toString()
                                          : '',
                                      style: TextStyle(
                                        fontFamily: 'SFProDisplayRegular',
                                        fontSize: 14,
                                        color: Color(0xFFF55A51),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account?',
                        style:
                            TextStyle(color: Color(0xFF371D32), fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 18, color: Colors.deepOrangeAccent),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
