import 'package:flutter/material.dart';
import 'package:grafpix/icons.dart';
import 'package:photo_view/photo_view.dart';
import '../homepage.dart' as homepage;

class TutorProfile extends StatefulWidget {
  @override
  _TutorProfileState createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile> {

  void updateState() => setState(() {});
  double width;
  double height;

  GlobalKey key = new GlobalKey();
  ScrollController controller;

  double caluculateOpacity(ScrollController controller) {
    if (controller.offset > 190)
      return 1.0;
    else if (controller.offset >= 150) {
      double offsetIncr = 40 - (190.0 - controller.offset);
      return offsetIncr * 0.1 / 4;
    } else
      return 0.0;
  }

  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Hello after the end");
      controller.addListener(() {
        setState(() {
          opacity = caluculateOpacity(controller);
        });
      });
    });
    super.initState();
  }

  Color color = Colors.blueAccent;
  double opacity = 0.0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin:
            EdgeInsets.only(top: opacity == 1 ? height * 0.015 : height * 0.05),
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              title: Opacity(
                  opacity: opacity,
                  child: Row(
                    children: <Widget>[
                      smallProfilePicture(),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Text(
                        "Mohammed Essa",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  )),
              automaticallyImplyLeading: true,
              expandedHeight: height * 0.39,
              backgroundColor: Colors.white,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.fadeTitle],
                background: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(flex: 2, child: _profilePicture()),
                      Expanded(
                        child: _profileName(),
                      ),
                      Expanded(
                        child: _tutorInfo(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(width * 0.06),
                child: Text("Courses"),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, pos) {
                  return Container(
                    width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: homepage.courseWidget(
                              context: context, callback: updateState,tutorProfile: true),
                          fit: FlexFit.loose,
                        ),
                        Container(
                          width: width,
                          height: height * 0.01,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  );
                },
                childCount: 20,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(" width = $width ,\nheight = $height");
          print(controller.offset);
          RenderBox renderBox = key.currentContext.findRenderObject();
          Offset offset = renderBox.globalToLocal(Offset.zero);
          print(offset);
          print(renderBox.size);
        },
      ),
    );
  }

  Widget smallProfilePicture() {
    return GestureDetector(
      key: key,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageViewer(
                  image: "assets/karrar.jpg",
                )));
      },
      child: Container(
        width: width * 0.08,
        height: width * 0.08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.04),
            image: DecorationImage(
                image: AssetImage("assets/karrar.jpg"), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _profilePicture() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageViewer(image: "assets/karrar.jpg")));
      },
      child: Container(
        margin: EdgeInsets.only(top: height * 0.03),
        width: width * 0.3, // width * 0.3
        height: width * 0.3, // width * 0.3
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.15),
            color: Colors.blueAccent,
            image: DecorationImage(
                image: AssetImage("assets/karrar.jpg"), fit: BoxFit.fill)),
      ),
    );
  }

  Widget _profileName() {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.04),
      child: Text(
        "Ammar abdul Kareem Qasim",
        style: TextStyle(fontSize: width * 0.07, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _tutorInfo() {
    return Container(
      padding: EdgeInsets.all(width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(width * 0.01)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Courses",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "13",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(width * 0.01)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "number of attendance",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "1000000",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(width * 0.01)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Score",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "10000",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget courses() {
    return Container(
      height: height,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, pos) => Container(
          height: MediaQuery.of(context).size.width * 0.013,
          width: MediaQuery.of(context).size.width,
          color: Colors.black26,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return homepage.courseWidget(context: context, callback: updateState);
        },
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String image;

  ImageViewer({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PhotoView(
      imageProvider: AssetImage(image),
      minScale: PhotoViewComputedScale.covered * 0.8,
      maxScale: PhotoViewComputedScale.contained * 4,
    ));
  }
}
