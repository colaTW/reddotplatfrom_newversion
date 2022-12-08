import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reddotplatfrom_newversion/pages/adminManage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reddotplatfrom_newversion/APIs.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class adminLogin extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  var isDisable=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF445154),
        title: Text("Login"),
      ),
      body:
          Container(
              child:
      GestureDetector(

        onTap: (){FocusScope.of(context).requestFocus(FocusNode());
        },
          child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                  controller:login,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),

                  labelText: "管理帳號",
                  hintText: "Your account username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:password,
                obscureText:  true,

                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),

                  labelText: "管理密碼",
                  hintText: "Your account password",

                ),
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: isDisable?null:()
                async{

                if(await APIs().isNetWorkAvailable()==0){
                  Fluttertoast.showToast(
                      msg: "請連接WIFI或使用行動網路",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,

                  );
                }
                else {
                  String login_info;
                  login_info = await APIs().login_manage(
                      login.text, password.text); //getData()延遲執行後賦值給data
                  var info = json.decode(login_info);

                   print(info);
                  if (info['code'] == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => adminManage(
                            data: {
                              'tk': info['token'],
                            }
                        )));
                  }
                  else {
                    loginfailDialog(context);
                  }
                }
                  }
                ,
              ),
            ),
          ],
        ),
      ))),
    );
  }
  void loginfailDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('登入失敗'),
            title: Center(
                child: Text(
                  '登入訊息',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('确定')),

            ],
          );
        });
  }


}

