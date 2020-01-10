import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grafpix/icons.dart';
import 'package:http/http.dart' as http;


class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {

  bool isLoading = true;
  List data;
  Set<String> dataSet = new Set<String>();
  bool done = false;
  @override
  void initState() {
    http.get(Uri.encodeFull("http://192.168.0.106:12000/get-uni"),headers: {"Accept":"application/json"}).then((http.Response res){
      setState(() {
        data = json.decode(res.body);
        print(data);
        isLoading = false;
//
      });
    });
    super.initState();
  }
  
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.check_circle,color: done ?Colors.green:Colors.red,),
        title: Text(done ? "Done" : "not yet") ,
        actions: <Widget>[
          LimitedBox(
            maxWidth: 70,
            maxHeight: 120,
            child: RaisedButton(
              child: Icon(Icons.refresh,color: Colors.white,),
              color: Colors.blueAccent,
              onPressed: (){
                setState(() {
                  isLoading = false;
                });
                http.get(Uri.encodeFull("http://192.168.0.106:12000/get-uni"),headers: {"Accept":"application/json"}).then((http.Response res){
                  setState(() {
                    data = json.decode(res.body);
                    print(data);
                    isLoading = false;
//
                  });
                });
              },
            ),
          )
        ],
      ),
      body: isLoading
      ?Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ):PageView.builder(
        controller: controller,
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
          itemBuilder: (context,i){
            return Container(
              child: ListView.separated(
                separatorBuilder: (context,pos){
                  return Divider();
                },
                  itemCount: data[i]["sub"].length,
                  itemBuilder: (context,pos){
                    return ListTile(
                      title: Text(data[i]["name"].toString().trim(),style: TextStyle(fontSize: 30.0),),
                      subtitle: Text(
                          data[i]["sub"][pos].toString()[0] == '/'
                              ?data[i]["sub"][pos].toString().substring(1)
                              :data[i]["sub"][pos].toString(),
                          style: TextStyle(fontSize: 25.0),),
                    );
                  },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.airplanemode_active),

        onPressed: (){
           controller.animateToPage(data.length -1,duration: Duration(milliseconds: 1),curve: Curves.linear);
        },
      ),
    );
  }
}



Dialog debugMessageDialog({BuildContext context,String error}){

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
    ),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.25,
        minWidth: MediaQuery.of(context).size.width * 0.75,
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: Container(
//        width:MediaQuery.of(context).size.width * 0.75,
//        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.all(13.0),
        child: SizedBox(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Unhandled Error",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width * 0.045),),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(error??"an error occured but no message was recieved",textAlign: TextAlign.start,),
                )
              ],
            )
            ,
          )          ,
        )
      ),
    ),
  );
}