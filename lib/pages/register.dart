import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reddotplatfrom_newversion/pages/fisrtpage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reddotplatfrom_newversion/APIs.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class register extends StatelessWidget {
  TextEditingController buildaccount = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController checkpassword = TextEditingController();
  TextEditingController buildname = TextEditingController();
  TextEditingController buildcode = TextEditingController();
  TextEditingController buildmail = TextEditingController();
  TextEditingController buildphone = TextEditingController();
  var buildID;

  var isDisable=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF445154),
        title: Text("Register"),
      ),
      body:
          SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:buildname,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "名稱",
                  hintText: "Your account username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                  controller:buildaccount,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "帳號",
                  hintText: "Your account",
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
                  labelText: "密碼",
                  hintText: "Your account password",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:checkpassword,
                obscureText:  true,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "確認密碼",
                  hintText: "Confirm your password",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:buildmail,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Email",
                  hintText: "Your account Email",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:buildphone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "電話",
                  hintText: "Your phone number",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                controller:buildcode,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.assignment),
                  labelText: "建案代碼",
                  hintText: "Your building Code",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              ElevatedButton(
                child: Text("確認代碼"),
                onPressed: ()async{
                String get;
                get = await APIs().getID_construction(buildcode.text.toString()); //getData()延遲執行後賦值給data
                var info = json.decode(get);
                if(info.length==0){
                  Fluttertoast.showToast(
                      msg: "查無此代碼",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      fontSize: 16.0
                  );
                }
                else{
                  Fluttertoast.showToast(
                      msg: "建案名稱:"+info['constructionName'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      fontSize: 16.0
                  );
                  buildID=info['constructionId'].toString();
                }
              },)
            ],),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: ElevatedButton(
                child: Text("註冊"),
                onPressed: isDisable?null:()
                async{
                if(await APIs().isNetWorkAvailable()==0){
                  Fluttertoast.showToast(
                      msg: "請連接WIFI或使用行動網路",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                  );
                  return;
                }
                if(buildID==null){
                  Fluttertoast.showToast(
                      msg: "請先確認代碼並確定為您的建案名稱",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      fontSize: 16.0
                  );
                }
                else {
                  String get;
                  get = await APIs().register_member(buildID,buildname.text,buildaccount.text,password.text,checkpassword.text,buildphone.text,buildmail.text); //getData()延遲執行後賦值給data
                  var info = json.decode(get);
                  if(info['code']!=0){
                    Fluttertoast.showToast(
                        msg: info['message'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        fontSize: 16.0
                    );
                    return;
                  }
                   //success
                  Navigator.of(context).pop();
                  registerSuccesssDialog(context);
                }

                  }
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void registerSuccesssDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('註冊成功'),
            title: Center(
                child: Text(
                  '註冊狀態',
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

