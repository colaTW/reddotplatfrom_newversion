import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:reddotplatfrom_newversion/APIs.dart';


class adminManage extends StatefulWidget {
  dynamic data;
  adminManage({this.data});
  @override
  State<StatefulWidget> createState() {
    return _adminManage();
  }
}
class _adminManage extends State<adminManage> {
  var data;
  var constructionlist;
  TextEditingController buildname = TextEditingController();
  TextEditingController buildcode = TextEditingController();
  TextEditingController buildphone = TextEditingController();
  TextEditingController buildurl = TextEditingController();
  var buildID=0;
  int nowpage=1;
  int totalpage=0;
  var isloading=false;
  Future<String> getData(String token,var name,var code,int page) async {
    var response = await APIs().getlist_construction(token,name,code,page);
    this.setState(() {
      data = json.decode(response);
      constructionlist=data['data']['lists'];
      totalpage=data['data']['items']['last_page'];
      isloading=false;
    });
    print(constructionlist);

    return "Success!";
  }

  @override
  void initState(){
    this.getData(widget.data['tk'],"","",nowpage);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("建案管理"), backgroundColor: Colors.blue),
      body:SingleChildScrollView(
        child:
        new Column(children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              child: Text('新增建案'),
              onPressed: ()async{
                buildphone.clear();
                buildname.clear();
                buildcode.clear();
                buildurl.clear();
                buildID=0;
              var result = await newBulidingDialog(context,"new");

            },),
           /* ElevatedButton(
              child: Text('廣告管理'),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => adsManage()));
              },),
          */
          ],),
        new Card(
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text('建案代碼'),
              new Text('建案名稱'),
              new Text('建案網址'),
              new Text('建案電話'),
              new Text('刪除'),
              new Text('修改'),
            ],) ,
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: constructionlist == null ? 0 : constructionlist.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Text(constructionlist[index]["constructionCode"]),
                    new Text(constructionlist[index]["constructionName"]),
                    new Text(constructionlist[index]["constructionOfficialUrl"]),
                    new Text(constructionlist[index]["constructionTel"]),
                    new ElevatedButton(
                      child: Text("刪除"),
                      onPressed: (){
                        Alert(
                            title: '刪除',
                            context: context,
                            type: AlertType.warning,
                            desc: constructionlist[index]["constructionName"]+"建案",
                            buttons: [
                              DialogButton(
                                child: Text('確認'),
                                onPressed: ()async{
                                  var response = await APIs().delete_construction(widget.data['tk'],constructionlist[index]["constructionId"]);
                                  var getdata=json.decode(response);
                                  print (getdata);
                                  if(getdata['code']==0){
                                    Fluttertoast.showToast(
                                        msg: "刪除成功",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.black,
                                        fontSize: 16.0
                                    );
                                    getData(widget.data['tk'], "", "", nowpage);
                                    Navigator.of(context,rootNavigator: true).pop();
                                  }
                              },
                                  ),
                              DialogButton(
                                child: Text('取消'),
                                color: Colors.red,
                                onPressed: (){
                                Navigator.of(context,rootNavigator: true).pop();
                              },)
                            ]
                        ).show();
                      },),
                    new ElevatedButton(
                      child: Text("修改"),
                      onPressed: ()async{
                        buildphone.text= constructionlist[index]["constructionTel"];
                        buildname.text= constructionlist[index]["constructionName"];
                        buildcode.text= constructionlist[index]["constructionCode"];
                        buildurl.text= constructionlist[index]["constructionOfficialUrl"];
                        buildID= constructionlist[index]["constructionId"];
                        var result = await newBulidingDialog(context,"revise");
                      }, )
                  ], )
            );
          },
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isloading?Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed:nowpage==1?null:(){
              setState(() {
                nowpage--;
                isloading=true;
                getData(widget.data['tk'],"","", nowpage);
              });
            }, child: Text("<")),
            Text(nowpage.toString()+"/"+totalpage.toString()),
              isloading?Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed:nowpage==totalpage?null:(){
              setState(() {
                nowpage++;
                isloading=true;
                getData(widget.data['tk'],"","", nowpage);
              });
            }, child: Text(">")),


            ],)
      ]),)
    );
  }
  Future<bool> newBulidingDialog(BuildContext context,String way) async{
    return await
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(

            title: way=="new"?Text("新增建案"):Text("修改建案"),
            content: Container(
                child:Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildcode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "代號",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildname,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "名稱",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildurl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "網址",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: TextFormField(
                      controller:buildphone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "電話",
                      ),
                    ),
                  ),
                ],)
            ),
            actions: <Widget>[
              new ElevatedButton(
                onPressed: () async{
                  //新增建案
                  if(way=="new") {
                    var response = await APIs().new_construction(
                        widget.data['tk'], buildcode.text, buildname.text,
                        buildurl.text, buildphone.text);
                    var getdata = json.decode(response);
                    print(getdata);
                    if (getdata['code'] == 0) {
                      Fluttertoast.showToast(
                          msg: "新增成功",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          fontSize: 16.0
                      );
                      getData(widget.data['tk'], "", "", nowpage);
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: getdata['message'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          fontSize: 16.0
                      );
                      return;
                    }
                  }
                  //修改建案
                  else{
                    var response = await APIs().revise_construction(
                        widget.data['tk'], buildcode.text, buildname.text,
                        buildurl.text, buildphone.text,buildID);
                    var getdata = json.decode(response);
                    print(getdata);
                    if (getdata['code'] == 0) {
                      Fluttertoast.showToast(
                          msg: "修改成功",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          fontSize: 16.0
                      );
                      getData(widget.data['tk'], "", "", nowpage);
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: getdata['message'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          fontSize: 16.0
                      );
                      return;
                    }
                  }
                  buildphone.clear();
                  buildname.clear();
                  buildcode.clear();
                  buildurl.clear();
                  buildID=0;

                  Navigator.pop(context, true);
                },
                child: new Text("確認"),
              ),

            ],
          );
        });
  }
}

