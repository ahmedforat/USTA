import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_page_ui/ustaAPI/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

enum answers { Yes, No }

answers graduationState = answers.No;
answers isAcademicStudent = answers.No;

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isDone = false;

  /// [posts login survey credentials]
  answers isGraduated = answers.No;
  String university;
  String college;
  answers academicStudent = answers.No;

  Map<String,dynamic> postSignUpData = <String,dynamic>{};
  List<String> _universities = [
    'جامعة بغداد',
    'الجامعة المستنصرية',
    'جامعة النهرين',
    'الجامعة العراقية ',
    'جامعة ابن سينا',
    'الجامعة التكنلوجية',
    'جامعة بابل',
    'جامعة كربلاء',
    'جامعة البصرة',
  ];

  List<String> _colleges = [
    'كلية الطب',
    'كلية طب الاسنان',
    'كلية الصيدلة',
    'كلية الهندسة',
    'كلية العلوم',
    'كلية الاداب',
    'كلية التربية',
    'كلية الاعلام',
  ];

  String _universitySelected;
  String _collegeselected;

  Animation animation;
  AnimationController controller;
  int indicator;
  @override
  void initState() {
    super.initState();
    indicator = 0;
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 700));
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
         // padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0000001),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform(
                  transform: Matrix4.translationValues(
                      indicator == 0 || indicator == 2 || indicator == 4
                          ? animation.value * MediaQuery.of(context).size.width
                          : 0,
                      indicator == 1 || indicator == 3
                          ? animation.value * MediaQuery.of(context).size.height
                          : 0,
                      0),
                  child: _handleSurveyWidgetsDisplay()),  ///[ this function handles the switching of questions]
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                child: RaisedButton(
                  color: Colors.blueAccent,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        isDone?"حفظ":"التالي",
                        style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.3*0.13),
                      ),
                      isDone? SizedBox():Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed: !isSelectionVisible()
                  ?()async {
                    try {
                      controller.reverse().then((d) async {
                        if (!isDone) {
                          setState(() {
                            indicator += 1;
                            controller.forward();
                          });
                        } else {
                          postSignUpData["isGraduated"] = isGraduated == answers.Yes;
                          postSignUpData["college"] = college.toString();
                          postSignUpData["university"] = university.toString();
                          postSignUpData["academicStudnet"] = academicStudent == answers.Yes;

                          ConventionResponse res;

                          res = await API(isConnected: true).savePostSignUpData(data: postSignUpData);
                          if(res.status != 200)
                          {
                            scaffoldKey.currentState.showSnackBar(getSnackBar(content: res.payload));
                          }
                          else{
                            Navigator.of(context).pushNamedAndRemoveUntil("/home-page", ModalRoute.withName(null));
                          }

                          scaffoldKey.currentState.showSnackBar(getSnackBar(content: "error inside catch line 133"));


                          print(postSignUpData);
                        }
                      });
                    } catch (err) {
                      print(err.toString());
                    }
                  }
                  :null,
                ),
              ),
             
             _handleBackButtonDisplay()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInitialSurveyQuestion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.27),
          child: Text(
            "Are you graduated  هل انت خريج جامعي",
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        RadioListTile(
          title: Text("Yes"),
          groupValue: graduationState,
          value: answers.Yes,
          selected: false,
          onChanged: (res) {
            setState(() {
              graduationState = res;
              isGraduated = res;
              //print(graduationState);
              //print("value of isGraduated : "+isGraduated.toString());
            });
          },
        ),
        RadioListTile(
          selected: false,
          title: Text("No"),
          groupValue: graduationState,
          value: answers.No,
          onChanged: (res) {
            setState(() {
              graduationState = res;
              isGraduated = res;
              // print(graduationState);
              // print(isGraduated);
            });
          },
        ),
      ],
    );
  }

  Widget specifyYourUniversityAndCollege() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.19),
          child: Text(
            "choose your university and college \n حدد الكلية والجامعة التي درست بها ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
        ),
        getDropDownButtonUniversity(),
        getDropDownButtonCollege()
      ],
    );
  }

  Widget areYouAcademicStudent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 210.0),
          child: Text(
            "Are you academic student\n هل انت طالب جامعي",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),
          ),
        ),
        RadioListTile(
          title: Text("Yes",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),
          groupValue: isAcademicStudent,
          value: answers.Yes,
          selected: false,
          onChanged: (res) {
            setState(() {
              isAcademicStudent = res;
              academicStudent = isAcademicStudent;
            });
          },
        ),
        RadioListTile(
          selected: false,
          title: Text("No",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045)),
          groupValue: isAcademicStudent,
          value: answers.No,
          onChanged: (res) {
            setState(() {
              isAcademicStudent = res;
              academicStudent = isAcademicStudent;
            });
          },
        ),
      ],
    );
  }

  Widget getDropDownButtonUniversity() {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0, top: 10.0),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButton<String>(
          items: _universities
              .map<DropdownMenuItem<String>>(
                  (String item) => new DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item.toString()),
                      ))
              .toList(),
          onChanged: (String val) {
            setState(() {
              _universitySelected = val;
              university = _universitySelected;
            });
          },
          value: _universitySelected,
          hint: Text("اختر الجامعة")),
    );
  }

  Widget getDropDownButtonCollege() {
    return DropdownButton<String>(
        items: _colleges
            .map<DropdownMenuItem<String>>(
                (String item) => new DropdownMenuItem<String>(
                      value: item.toString(),
                      child: Text(item.toString()),
                    ))
            .toList(),
        onChanged: (String val) {
          setState(() {
            _collegeselected = val;
            college = _collegeselected;
          });
        },
        value: _collegeselected,
        hint: Text("اختر الكلية"));
  }

  Widget _handleSurveyWidgetsDisplay() {
    
    if (indicator == 1) {
      return isGraduated == answers.No
          ? areYouAcademicStudent()
          : specifyYourUniversityAndCollege();
    }
    if (indicator == 2) {
      if (isGraduated == answers.Yes) {
        isDone = true;
        return getInterestList();
      }
      if( academicStudent == answers.Yes)
          return specifyYourUniversityAndCollege();
          else {
            isDone = true;
            return getInterestList();
            }
    }
    if (indicator == 3) {
        isDone = true;
        return getInterestList();
      }
    return _getInitialSurveyQuestion();
  }

  Widget getInterestList() {
    return Container(
      child: Center(
        child: Text("Interests List"),
      ),
    );
  }

  Widget finish() {
    return Container(
      margin: EdgeInsets.only(top: 240.0),
      child: Center(
        child: Text("done",style: TextStyle(fontSize: 30.0),),
      ),
    );
  }


  Widget _handleBackButtonDisplay(){
    return indicator >= 4 || indicator == 0
      ? SizedBox()
      : GestureDetector(
      onTap: (){
        controller.reverse().then((f){
          setState(() {
            if(isDone)
              isDone = false;
         indicator -= 1; 
         controller.forward();
        });
        });
      },
         
      child: Container(
                  margin: EdgeInsets.only(top: 100,),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 30.0,),
                      Icon(Icons.arrow_back,color: Colors.blueAccent,),
                      SizedBox(width: 10.0,),
                       Text("السابق",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                    ],
                  )
                )
     
    );
  }

  Widget getSnackBar({String content}){
    return SnackBar(
      content: Text(content),
    );
  }

  bool isSelectionVisible(){
    return (academicStudent == answers.Yes && indicator == 2) || (indicator == 1 && isGraduated == answers.Yes);
  }
  bool handleDisability(){
        return isSelectionVisible() && (_universitySelected != null && _collegeselected != null);
  }
}
