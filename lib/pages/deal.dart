import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reddotplatfrom_newversion/pages/Employee.dart';
import 'package:reddotplatfrom_newversion/pages/deal_how.dart';
import 'package:reddotplatfrom_newversion/pages/deal_file.dart';
import 'package:reddotplatfrom_newversion/pages/deal_img.dart';
import 'package:reddotplatfrom_newversion/pages/deal_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reddotplatfrom_newversion/APIs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class deal extends StatefulWidget {
  static var filelist=List();
  dynamic data;
  deal({this.data});
  @override
  State<StatefulWidget> createState() {

    return _deal();
  }
}

class _deal extends State<deal> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  /*CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm');
  String formatted = (DateTime.now()).toString();*/
  TextEditingController _eventName = TextEditingController();
  var img1, img2, img3,img4,img5;
  var img1_id = "";
  var img2_id = "";
  var img3_id = "";
  var img4_id = "";
  var img5_id = "";
  var _filepath;
  var file1_id;
  var file1_name;
  String upfilegif = 'assets/images/memberlogin/bt002.png';
  int way;
  int how;
  bool _visible = false;

  TextEditingController mesg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return new Scaffold(
        appBar: AppBar(
          title: Text("????????????"),
          backgroundColor: Color(0xFF445154),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('how');
                prefs.remove('img1');
                prefs.remove('img2');
                prefs.remove('img3');
                prefs.remove('img4');
                prefs.remove('img5');
                prefs.remove('img1_id');
                prefs.remove('img2_id');
                prefs.remove('img3_id');
                prefs.remove('img4_id');
                prefs.remove('img5_id');
                deal.filelist.clear();
                prefs.remove('message');
                prefs.remove('price');

                Navigator.pop(context);
              }),
        ),
        body: Container(
            height: height,
            color: Color(0xFF2A3233),
            child:SingleChildScrollView (
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(margin: EdgeInsets.only(left: 10.0),child:Image.asset('assets/images/memberlogin/sub1.png') ,),
                    Row(
                      children: <Widget>[
                Theme(
                data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white,
                    disabledColor: Colors.blue
                ),
              child:
                        Radio(
                          hoverColor: Colors.white,
                          value: 0,
                          groupValue: way,
                          onChanged: (value) {
                           _visible=false;
                            setState(() {
                              way = value;
                            });
                          },
                        )),
                        Text("?????????????????????",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                                disabledColor: Colors.blue
                            ),
                            child:
                            Radio(
                              hoverColor: Colors.white,
                              value: 3,
                              groupValue: way,
                              onChanged: (value) {
                                _visible=false;
                                setState(() {
                                  way = value;
                                });
                              },
                            )),
                        Text("???????????????",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Theme(
                          data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                              disabledColor: Colors.blue
                          ),
                          child:
                        Radio(
                          value: 1,
                          groupValue: way,
                          onChanged: (value) {
                            _visible=true;
                            setState(() {
                              way = value;
                            });
                          },
                        )),
                        Text("??????????????????",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    // RaisedButton(child: Text('GO'),onPressed:() async{
                    //   var go=await (APIs().read('way'));
                    //   print(go);
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => deal_way(data:go)));
                    // }
                    //     ,) ,

                    Row(
                      children: <Widget>[
                        Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                                disabledColor: Colors.blue
                            ),
                            child:
                            Radio(
                              hoverColor: Colors.white,
                              value: 4,
                              groupValue: way,
                              onChanged: (value) {
                                _visible=false;
                                setState(() {
                                  way = value;
                                });
                              },
                            )),
                        Text("??????????????????",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                                disabledColor: Colors.blue
                            ),
                            child:
                            Radio(
                              hoverColor: Colors.white,
                              value: 5,
                              groupValue: way,
                              onChanged: (value) {
                                _visible=false;
                                setState(() {
                                  way = value;
                                });
                              },
                            )),
                        Text("??????????????????",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                   // Row(
                   //   children: <Widget>[
                    //    Expanded(
                    //        child: IconButton(
                    //          icon: Image.asset(
                    //              '''assets/images/memberlogin/addtoC.png'''),
                    //          onPressed: () {
                            //log('add event pressed');
                     //           calendarClient.insert(
                     //             "????????????",
                     //             startTime,
                      //            startTime.add(Duration(days: 1)),
                      //          );
                       //       },
                        //      iconSize: 100,
                      //      ))
                     // ],
                    //),
                    Container(margin: EdgeInsets.only(left: 10.0),child:Image.asset('assets/images/memberlogin/sub2.png') ,),


                    Row(children: <Widget>[
                      Expanded(
                          child: IconButton(
                            icon: Image.asset('assets/images/memberlogin/bt005.png'),

                            onPressed: () async {
                              var go1 = await (APIs().read_string('img1'));
                              var go2 = await (APIs().read_string('img2'));
                              var go3 = await (APIs().read_string('img3'));
                              var go4 = await (APIs().read_string('img4'));
                              var go5 = await (APIs().read_string('img5'));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          deal_img(data: {
                                            "0": go1,
                                            "1": go2,
                                            "2": go3,
                                            "3":go4,
                                            "4":go5,
                                            "tk": widget.data['tk']
                                          })));
                            },
                            iconSize: 100,
                          )),
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: IconButton(
                            icon: Image.asset(upfilegif),
                            onPressed: () async {
                              getFilePath();
                            },
                            iconSize: 100,
                          )),
                    ]),
                    Row(children: [
                      Expanded(child: IconButton(
                        icon:
                        Image.asset('assets/images/memberlogin/bt001.png'),
                        onPressed: () async {
                          var go = await (APIs().read_string('message'));
                          var go2=await (APIs().read_string('price'));
                          print(go);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      deal_message(data:{'message':go,'price':go2})));
                        },
                        iconSize: 100,
                      )),
                    ],),
                    Row(children: [
                      Expanded(child: IconButton(
                        icon:
                        Image.asset('assets/images/memberlogin/bt003.png'),
                        onPressed: () async {
                          var go = await (APIs().read('how'));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => deal_how(data:{'go':go,'projectHandlerTypes':widget.data['projectHandlerTypes']})));
                        },
                        iconSize: 100,
                      )),
                    ],),
                    Row(children: [
                      Expanded(child: IconButton(
                        icon:
                        Image.asset('assets/images/memberlogin/sent.png'),
                        onPressed: () {

                          sentnew();
                        },
                        iconSize: 100,
                      )),
                    ],),
                  ],
                ))));
  }

  void showEnd(BuildContext context, var show) {
    Alert(
        title: '??????',
        context: context,
        type: AlertType.warning,
        desc: show,

    ).show();
  }

  sentnew() async {
    if(await APIs().isNetWorkAvailable()==0){
      Fluttertoast.showToast(
        msg: "?????????WIFI?????????????????????",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      if (way == null) {
        Alert(
            title: '??????',
            context: context,
            type: AlertType.warning,
            desc: "?????????????????????",
            buttons: []
        ).show();
      }
      else {
        var info = Map<String, dynamic>();
        info['projectId'] = widget.data['NO'].toString();
        info['message'] = await (APIs().read_string('message'));
        if(way!=1){way=0;}
        info['onSite'] = way.toString();
        info['onSiteAt'] = "2022-12-22 11:23";
        if (await APIs().read_string('price') == '') {
          info['price'] = '0';
        }
        else {
          info['price'] = await APIs().read_string('price');
        }
        info['images'] =await getimglist();
        info['handlerType'] = await (APIs().read('how'));
        info['handlerUserId'] = widget.data['ID'].toString();


        var file = [];
        for (var i = 0; i < deal.filelist.length; i++) {
          if ((i % 2) == 0) {
            file.add(deal.filelist[i].toString());
          };
        }
        info['files'] = file;
        print(info.toString());

        var end = json.decode(await APIs().newdeal(widget.data['tk'], info));
        if (end['code'] == 0) {
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('how');
          prefs.remove('img1');
          prefs.remove('img2');
          prefs.remove('img3');
          prefs.remove('img4');
          prefs.remove('img5');
          prefs.remove('img1_id');
          prefs.remove('img2_id');
          prefs.remove('img3_id');
          prefs.remove('img4_id');
          prefs.remove('img5_id');
          deal.filelist.clear();
          prefs.remove('message');
          prefs.remove('price');
          Alert(
              title: '??????',
              context: context,
              type: AlertType.success,
              desc: "??????",
              buttons: [
                DialogButton(onPressed: (){
                  Navigator.of(context,rootNavigator: true).pop();
                  Navigator.pop(context,'test');
                }, child: Text('??????'))
              ]
          ).show();
        } else {
          showEnd(context, end['message']);
        }
      }
    }
  }

  void getFilePath() async {
    if (await APIs().isNetWorkAvailable() == 0) {
      Fluttertoast.showToast(
        msg: "?????????WIFI?????????????????????",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );
    }
    else {
      setState(() {
        upfilegif = 'assets/images/cupertino.gif';
      });
      FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['xls', 'pdf', 'doc'],);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        if (result.names.length > 5 - ((deal.filelist.length) / 2)) {
          setState(() {
            upfilegif = 'assets/images/memberlogin/bt002.png';
          });
          Alert(
            context: context,
            type: AlertType.warning,
            title: "??????",
            desc: "????????????????????????",
            buttons: [
            ],
          ).show();
        }
        else {
          for (int i = 0; i < result.names.length; i++) {
            var name = result.paths[i].toString().split("/");
            var filename = result.names[i];
            print(filename);
            var filetype = filename.substring(
                filename.length - 3, filename.length);
              var file = File(result.paths[i].toString());
              List<int> file_64 = await file.readAsBytes();
              String base64file = base64Encode(file_64);
              if(filetype=="doc"||filetype=="xls"||filetype=="pdf"){
                var re = json.decode(
                    await APIs().uploadfile_handler(
                        widget.data['tk'], filename,filetype, base64file));
                if (re['code'] == 0) {
                  file1_id = re['handlerFileId'].toString();
                  _filepath = filename;
                  await deal.filelist.add(file1_id);
                  await deal.filelist.add(_filepath);
                  print(deal.filelist);
                  if (i == result.names.length - 1) {
                    setState(() {
                      upfilegif = 'assets/images/memberlogin/bt002.png';
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => deal_file()));
                  }
                }
                else{
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "??????",
                    desc: re['message'],
                    buttons: [
                    ],
                  ).show();
                  setState(() {
                    upfilegif = 'assets/images/memberlogin/bt002.png';
                  });
                }
              }
              else{
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "??????",
                  desc: "??????????????????pdf/doc/xls",
                  buttons: [
                  ],
                ).show();
                setState(() {
                  upfilegif = 'assets/images/memberlogin/bt002.png';
                });
              }
              //print("File path: " + filePath);

          }
        }
      }
      else {
        setState(() {
          upfilegif = 'assets/images/memberlogin/bt002.png';
        });
      }
    }
  }
  getimglist() async{
    var images=[];

    if( (await APIs().read_string('img1_id'))!="")images.add(await APIs().read_string('img1_id'));
    if( (await APIs().read_string('img2_id'))!="")images.add(await APIs().read_string('img2_id'));
    if( (await APIs().read_string('img3_id'))!="")images.add(await APIs().read_string('img3_id'));
    if( (await APIs().read_string('img4_id'))!="")images.add(await APIs().read_string('img4_id'));
    if( (await APIs().read_string('img5_id'))!="")images.add(await APIs().read_string('img5_id'));
    return images;
  }
}