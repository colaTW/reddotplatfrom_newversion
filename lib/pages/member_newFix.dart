import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddotplatfrom_newversion/APIs.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';



class member_newFix extends StatefulWidget {
  dynamic data;
  member_newFix({this.data});
  @override
  State<StatefulWidget> createState() {
    return _member_newFix();
  }
}
class _member_newFix extends State<member_newFix> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cases = TextEditingController();
  TextEditingController num = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController household = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController fix = TextEditingController();
  TextEditingController memos = TextEditingController();
  TextEditingController email = TextEditingController();
  ScrollController control=ScrollController();
  var img1Path,img2Path,img3Path,img4Path,img5Path;
  var Category;
  var img1id,img2id,img3id,img4id,img5id;
  var buildID;
  var _filepath;
  var file1_id;
  var buildInfo;
  var Itmes;
  var residentID;
  String camera='assets/images/mainten_create/cream.png';
  String upfile='assets/images/mainten_create/flieupload.png';
  String over='assets/images/mainten_create/bar1.png';

  List buliddate=List();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    name.text=widget.data['memberinfo']['constructionName'];
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("客服報修"),
        backgroundColor: Color(0xA0979F97),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body:
    GestureDetector(
    onTap: (){FocusScope.of(context).requestFocus(FocusNode());
    },
    child:SingleChildScrollView(
          child:
          Container(
            height: height,
            //  margin:  EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Color(0xA0979F97),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //Image.asset('assets/images/mainten_create/name.png',height:20,width:100,),
                    Text('建案名稱 ',
                      style: TextStyle(height: 2, fontSize: 20,color:Colors.white),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                        ),
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Row(
                  children: <Widget>[
                   // Image.asset('assets/images/mainten_create/phone.png',height:20,width:100,),
                    Text('住戶姓名 ',
                      style: TextStyle(height: 2, fontSize: 20,color:Colors.white),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(

                        ),
                      ),
                    ),
                    SizedBox(width: 10,)

                  ],
                ),
                Row(
                  children: <Widget>[
                   // Image.asset('assets/images/mainten_create/email.png',height:20,width:100,),
                    Text('聯繫電話 ',
                      style: TextStyle(height: 2, fontSize: 20,color:Colors.white),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                        ),
                      ),
                    ),
                    SizedBox(width: 10,)

                  ],
                ),
                SizedBox(width: 10,height: 10,),

                SizedBox(height: 10,),
                Visibility(
                    visible: false,
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: building,
                        decoration: const InputDecoration(
                          hintText: "棟別",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: household,
                        decoration: const InputDecoration(
                          hintText: "戶別",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: floor,
                        decoration: const InputDecoration(
                          hintText: "樓層",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),

                    SizedBox(width: 10,)

                    //  Expanded(
                    //     child: TextFormField(
                    //       controller: floor,
                    //       decoration: const InputDecoration(
                    //         hintText: "填入樓層",
                    //       ),
                    //     ),
                    //   )
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   // Image.asset('assets/images/mainten_create/bt004.png',height:20,width:100,),
                    Text('住戶地址 ',
                      style: TextStyle(height: 2, fontSize: 20,color:Colors.white),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: num,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "填入地址",
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Image.asset(over),),
                  ],
                ),
                SizedBox(width: 10,height: 10,),
             /*  memos==null?SizedBox(width: 10,height: 10,): Padding(
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  child:
                Container(
                  constraints: BoxConstraints(maxHeight: 50),
                  child:VsScrollbar(
                      color: Colors.yellow,
                      controller:control,
                      isAlwaysShown: true,
                      thickness: 3.0,
                      child:
                  SingleChildScrollView(
                    controller: control,
                    child: TextField(
                      decoration: new InputDecoration(
                          disabledBorder:new OutlineInputBorder(  //添加边框
                           // borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),
                      ),
                      controller: memos,
                      maxLines: null,
                      enabled: false,
                    ),
                  )),
                ),),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                    new Expanded(child:
                    new Container(color:Colors.white,
                      child:new DropdownButtonHideUnderline(child:
                      new DropdownButton<dynamic>(
                        isExpanded: true,
                        hint:Center(child: Text('－－請選擇分類－－',textAlign: TextAlign.center)),
                        items: widget.data['Categories'].skip(1).map<DropdownMenuItem<dynamic>>((item) {
                          return new DropdownMenuItem<dynamic>(
                            child: Center(child:new Text(item['name'])),
                            value: item['id'],
                          );
                        }).toList(),
                        onChanged: (selectvalue) {
                          print(selectvalue);
                          setState(() {
                            Category=selectvalue;
                            Itmes=null;
                          });
                        },
                        value: Category,
                      )),)),
                    SizedBox(width: 10,)
                  ],
                ),
                SizedBox(height: 10,),
                Category!=null?Row(children: [
                  Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                  Expanded(child:
                  new Container(color:Colors.white,
                    child:new DropdownButtonHideUnderline(child:
                    new DropdownButton<dynamic>(
                      isExpanded: true,
                      hint:Center(child: Text('－－請選擇分類－－',textAlign: TextAlign.center)),
                      items: widget.data['Items'][Category.toString()].skip(1).map<DropdownMenuItem<dynamic>>((item) {
                        return new DropdownMenuItem<dynamic>(
                          child: Center(child:new Text(item['name'])),
                          value: item['id'],
                        );
                      }).toList(),
                      onChanged: (selectvalue) {
                        print(selectvalue);
                        setState(() {
                          Itmes=selectvalue;
                        });
                      },
                      value: Itmes,
                    )),)),
                  SizedBox(width: 10,)
                ],):
                Row(children: [
                  Image.asset('assets/images/mainten_create/list.png',height:20,width:100,),
                  Expanded(child:
                  new Container(color:Colors.white,
                    child:new DropdownButtonHideUnderline(child:
                    new DropdownButton<dynamic>(
                      isExpanded: true,
                      hint:Center(child: Text('－－請選擇分類－－',textAlign: TextAlign.center)),

                      onChanged: (selectvalue) {
                        print(selectvalue);
                        setState(() {
                          Itmes=selectvalue;
                        });
                      },
                      value: Itmes,
                    )),)),
                  SizedBox(width: 10,)
                ],),


                SizedBox(width: 10,height: 10,),
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/mainten_create/messg.png',height:20,width:100,),
                    Expanded(
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(  //添加边框
                            borderSide: BorderSide(color: Colors.blue, width: 5.0),
                          ),
                        ),
                        controller: fix,
                        minLines: 5,
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/mainten_create/flie.png',height:20,width:100,),
                    Expanded(child: Text("")),
                  ],
                ),
                //  Row(children:<Widget>[new IconButton(icon:Icon(Icons.backup), onPressed: getFilePath),_filepath==null?Text('尚未選擇檔案'):
                // Expanded(child:Text(_filepath,softWrap: true,)
                //  ,) ]),
                Row(
                  children: <Widget>[
                    Expanded(child: IconButton(icon:Image.asset(camera),onPressed: _takePhoto,iconSize:100,)),
                    Expanded(child: IconButton(icon:Image.asset(upfile),onPressed: _openGallery,iconSize:100)),
                  ],
                ),
                Scrollbar(
                  child:
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         img1Path==null?Text(''): Image.network(img1Path,height:75,width:75,fit: BoxFit.fill,),
                          img1Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img1Path = null;});} ,
                            child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img2Path==null?Text(''): Image.network(img2Path,height:75,width:75,fit: BoxFit.fill),
                          img2Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img2Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img3Path==null?Text(''): Image.network(img3Path,height:75,width:75,fit: BoxFit.fill),
                          img3Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img3Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img4Path==null?Text(''): Image.network(img4Path,height:75,width:75,fit: BoxFit.fill),
                          img4Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img4Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                          SizedBox(width: 50,),
                          img5Path==null?Text(''): Image.network(img5Path,height:75,width:75,fit: BoxFit.fill),
                          img5Path==null? Text(''):GestureDetector(onTap:(){ setState(() {img5Path = null;});} ,
                              child: Image.network('https://i.kfs.io/album/tw/166074,0v3/fit/500x500.jpg',fit:BoxFit.cover,width: 20,height: 20,)),
                        ]
                    ),
                )),
                Row(children: [
                  Expanded(child: IconButton(
                    icon:
                    Image.asset('assets/images/mainten_create/sent.png'),
                    onPressed: ()  {
                      sentfix();
                    },
                    iconSize: 100,
                  )),
                ],)
              ],
            ),
          )
      ),
    ));
  }
  void showEnd(BuildContext context,var show) {
    Alert(
        title: '結果',
        context: context,
        type: AlertType.warning,
        desc: "失敗:"+show,
    ).show();
  }
  _takePhoto() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          camera = 'assets/images/cupertino.gif';
        });
        var name = image.toString().split('/');
        var filename = name[name.length - 1];
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(await APIs().uploadimg_project(widget.data['tk'],base64Image, filename));
        if (img1Path == null) {
          if (re['code'] == 0) {
            img1id = re['projectFileId'].toString();
            setState(() {
              img1Path = re['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img2Path == null) {
          if (re['code'] == 0) {
            img2id = re['projectFileId'].toString();
            setState(() {
              img2Path = re['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img3Path == null) {
          if (re['code'] == 0) {
            img3id = re['projectFileId'].toString();
            setState(() {
              img3Path = re['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else if (img4Path == null) {
          if (re['code'] == 0) {
            img4id = re['projectFileId'].toString();
            setState(() {
              img4Path = re['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        } else if (img5Path == null) {
          if (re['code'] == 0) {
            img5id = re['projectFileId'].toString();
            setState(() {
              img5Path = re['projectFileUrl'];
              camera = 'assets/images/mainten_create/cream.png';
            });
          }
        }
        else {
          setState(() {
            camera = 'assets/images/mainten_create/cream.png';
          });
          Alert(context: context, title: "提醒", desc: "上傳以五張為限",buttons:[]).show();
        }
      }
    }
  }
  /*相册*/
  _openGallery() async {
    if (await APIs().isNetWorkAvailable() == 0) {
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          upfile = 'assets/images/cupertino.gif';
        });
        var name = image.toString().split('/');
        var filename = name[name.length - 1];
        List<int> imageBytes = image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        var re = json.decode(await APIs().uploadimg_project(widget.data['tk'],base64Image, filename));
        print(re);
        if (img1Path == null) {
          if (re['code'] == 0) {
            img1id = re['projectFileId'].toString();
            setState(() {
              img1Path = re['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img2Path == null) {
          if (re['code'] == 0) {
            img2id = re['projectFileId'].toString();
            setState(() {
              img2Path = re['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img3Path == null) {
          if (re['code'] == 0) {
            img3id = re['projectFileId'].toString();
            setState(() {
              img3Path = re['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img4Path == null) {
          if (re['code'] == 0) {
            img4id = re['projectFileId'].toString();
            setState(() {
              img4Path = re['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else if (img5Path == null) {
          if (re['code'] == 0) {
            img5id = re['projectFileId'].toString();
            setState(() {
              img5Path = re['projectFileUrl'];
              upfile = 'assets/images/mainten_create/flieupload.png';
            });
          }
        }
        else {
          Alert(context: context, title: "提醒", desc: "上傳以五張為限", buttons: [])
              .show();
          setState(() {
            upfile = 'assets/images/mainten_create/flieupload.png';
          });
        }
      }
    }
  }
/*  void getFilePath() async {
    var filePath = await FilePicker.getFilePath(type: FileType.custom,allowedExtensions: ['pdf', 'doc'],);
    var name=filePath.split("/");
    var filename=name[name.length-1];
    var file=File(filePath);
    List<int> file_64 = await file.readAsBytes();
    String base64file= base64Encode(file_64);
    var re=json.decode(await APIs().uploadfile_no(filename, base64file));
    print(re);
    if(re['data']['errors']==''){
      file1_id= re['data']['projectFileId'].toString();
      setState((){_filepath = filename;});
    }
    if (filePath == '') {
      return;
    }
    print("File path: " + filePath);

  }*/
  sentfix()async{
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "請連接WIFI或使用行動網路",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      var info = Map<String, dynamic>();
      print(name.text);
      info['projectCategoryId'] = Category.toString();
      info['projectItemId'] = Itmes.toString();
      info['name']=name.text.toString();
      info['phone']=phone.text.toString();
      info['mobile']=phone.text.toString();
      info['email']=email.text.toString();
      info['address']=num.text.toString()  ;
      info['building']=""  ;
      info['household']=household.text.toString();
      info['floor']=floor.text.toString();
      info['message'] = fix.text.toString();
      List<dynamic> images=[];
      if(img1id!=null)images.add(img1id);
      if(img2id!=null)images.add(img2id);
      if(img3id!=null)images.add(img3id);
      if(img4id!=null)images.add(img4id);
      if(img5id!=null)images.add(img5id);
      info['images'] = images;
      if(file1_id!=null)info['files'] = [file1_id];
      else info['files'] = [];


      var end = json.decode(await APIs().menberfix(widget.data['tk'], info));

      if (end['code'] == 0) {
        Alert(
            title: '結果',
            context: context,
            type: AlertType.success,
            desc: "成功",
            buttons: [
              DialogButton(onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context,"test");
              }, child: Text('確認'))
            ]
        ).show();
      }
      else {
        showEnd(context, end['message']);
      }
    }
  }


}
