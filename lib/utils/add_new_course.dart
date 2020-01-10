import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_page_ui/ustaAPI/api.dart';
import 'package:flutter_login_page_ui/ustaAPI/model.dart';
import 'package:flutter_login_page_ui/utils/courseCredentialsValidators.dart';
import 'package:flutter_login_page_ui/utils/functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:geolocator/geolocator.dart';

class AddNewCourseWidget extends StatefulWidget {
  @override
  _AddNewCourseWidgetState createState() => _AddNewCourseWidgetState();
}

DateTime selectedDate;
TimeOfDay selectedTime;

String typeOfPrice;
List<File> courseImages = [];
LatLng courseLocation;
Map<String,dynamic> coursePayload;


class _AddNewCourseWidgetState extends State<AddNewCourseWidget> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isFree = false;

  TextEditingController durationController;
  TextEditingController addressDescriptionController;
  TextEditingController courseDescriptionController;
  TextEditingController phoneNumberController;
  TextEditingController titleController;
  TextEditingController priceController;

  @override
  void initState() {
    durationController = new TextEditingController();
    addressDescriptionController = new TextEditingController();
    courseDescriptionController = new TextEditingController();
    phoneNumberController = new TextEditingController();
    titleController = new TextEditingController();
    priceController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Form(
          key: formKey,
          child: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.title),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: "Title"),
                        validator: (title) {
                          return CourseCredentialsValidators.validateTitle(
                              title: title);
                        }),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.date_range),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                          ),
                          alignment: Alignment.center,
                          child: Text(selectedDate == null
                              ? "Starting Date"
                              : "${selectedDate.toIso8601String().substring(0, 10)}"),
                        ),
                        onTap: () async {
                          selectedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate == null
                                  ? DateTime.now()
                                  : selectedDate,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 2));
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Icon(Icons.access_time),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0)),
                          ),
                          alignment: Alignment.center,
                          child: Text(selectedTime == null
                              ? "Time"
                              : selectedTime.format(context)),
                        ),
                        onTap: () async {
                          selectedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now());
                          setState(() {});
                        },
                      )
                    ],
                  ))
                ],
              ),
            ),
            Padding(
              //width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.monetization_on),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                        enabled: !isFree,
                        controller: priceController,
                        decoration: InputDecoration(
                            labelText: isFree ?"Free Course":"Price",
                        labelStyle: TextStyle(color: isFree ? Colors.purple : Colors.black)
                        ),

                        keyboardType: TextInputType.number,
                        validator: (price) {
                          return CourseCredentialsValidators.validatePrice(
                              price: price);
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  DropdownButton(
                    value: typeOfPrice,
                    items: <DropdownMenuItem>[
                      DropdownMenuItem<String>(
                        value: "IQD",
                        child: Text("Iraqi Dinar"),
                      ),
                      DropdownMenuItem<String>(
                        value: "USD",
                        child: Text("US Dollar"),
                      ),
                      DropdownMenuItem<String>(
                        value: "FREE",
                        child: Text("Free Course",style: TextStyle(color: Colors.purple),),
                      ),
                    ],
                    onChanged: (val) {

                      setState(() {
                        if(val == "FREE")
                          isFree = true;
                        else
                           isFree = false;
                        typeOfPrice = val;
                      });
                    },
                    hint: Text("type of payment"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.av_timer),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: durationController,
                      decoration: InputDecoration(
                          labelText: "duration (number of Days)"),
                      keyboardType: TextInputType.number,
                      validator: (duration) {
                        return CourseCredentialsValidators.validateDuration(
                            duration: duration);
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addressDescriptionController,
                      decoration:
                          InputDecoration(labelText: "Address description"),
                      validator: (address) {
                        return CourseCredentialsValidators
                            .validateAddressDescription(address: address);
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                      onTap: () async {
                        List results = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ChooseLocationFromMap()));
                        if (results[0] && results[1] != null) {
                          courseLocation = results[1];
                        }
                      },
                      child: Text(
                        "Click here to choose location from map",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.description),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: courseDescriptionController,
                      decoration: InputDecoration(
                          labelText: "Course Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      validator: (description) {
                        return CourseCredentialsValidators.validateCourseDesc(
                            description: description);
                      },
                    ),
                  )
                ],
              ),
            ),
            courseImages.length == 0
                ? Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: UnconstrainedBox(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.3),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.14,
                          child: InkWell(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                ),
                                Text(
                                  "add images\n if any",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => chooseImageSource());
                            },
                          )),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: courseImages.length,
                          itemBuilder: (context, pos) {
                            return Stack(
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(courseImages[pos]),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ImageSlider(
                                                  position: pos,
                                                )));
                                  },
                                ),
                                Positioned(
                                  left: MediaQuery.of(context).size.height *
                                      0.185,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.145,
                                  child: IconButton(
                                      icon: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: Text(
                                          "X",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          courseImages.removeAt(pos);
                                        });
                                      }),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.add_a_photo,
                                size: 30.0,
                              ),
                              Text("add more photos")
                            ],
                          ),
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.04,
                              top: MediaQuery.of(context).size.height * 0.03),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => chooseImageSource());
                        },
                      )
                    ],
                  ),
            Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.phone_android),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(labelText: "Phone Number"),
                      keyboardType: TextInputType.number,
                      validator: (phone) {
                        return CourseCredentialsValidators
                            .validatePhoneNumber(phoneNumber: phone);
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.045),
              child: MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  bool res = formKey.currentState.validate();
                  String dateValidation = CourseCredentialsValidators.validateDate(date: selectedDate);
                  String timeValidation = CourseCredentialsValidators.validateTime(time: selectedTime);
                  String paymentValidation = CourseCredentialsValidators.validatePaymentType(payment: typeOfPrice);
                  String locationValidation = CourseCredentialsValidators.validateMapLocation(loc: courseLocation);

                  List<String> validationsRes = [dateValidation,timeValidation,paymentValidation,locationValidation];
                  if(res){
                    for(String i in validationsRes){
                      if(i != null){
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("$i"),
                          duration: Duration(milliseconds: 2500),
                        ));
                        break;
                      }
                      Course course = new Course(
                        title: titleController.text,
                        date: selectedDate,
                        time: selectedTime,
                        price: isFree ? "0.0" : priceController.text,
                        typeOfPayment: typeOfPrice,
                        duration: durationController.text,
                        description: courseDescriptionController.text,
                        addressDescription: addressDescriptionController.text,
                        images: courseImages.length == 0 ? null : courseImages,
                        location: courseLocation,
                        phone: phoneNumberController.text
                      );

                      API(isConnected: true).uploadNewCourse(course: course);
                    }
                  }
                },
                child: Text(
                  "Confirm and upload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.045),
              child: MaterialButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).canPop()? Navigator.of(context).pop([false]):print("Hello");
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            )
          ]),
        ));
  }

  Widget chooseImageSource() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text("Image source"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
              child: Icon(Icons.camera_alt),
              onTap: () async {
                File image = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  setState(() {
                    courseImages.add(image);
                  });
                }
                Navigator.of(context).pop();
              }),
          GestureDetector(
              child: Icon(Icons.photo_library),
              onTap: () async {
                File image =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    courseImages.add(image);
                  });
                }
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  int position;

  ImageSlider({this.position});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  PhotoViewController photoViewController;
  ScrollController controller = new ScrollController();
  PageController pageController;
  PhotoViewScaleStateController photoViewScaleStateController;

  void initState() {
    super.initState();
    photoViewController = new PhotoViewController();
    photoViewScaleStateController = new PhotoViewScaleStateController();
    pageController = new PageController(initialPage: widget.position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PhotoView(
            initialScale: PhotoViewComputedScale.contained,
            controller: photoViewController,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            imageProvider: FileImage(courseImages[widget.position], scale: 1),
            loadingChild: Center(
              child: CircularProgressIndicator(),
            ),
            onTapDown: (context, details, photoController) {
              print(photoController);
              print(details);
            },
            backgroundDecoration: BoxDecoration(color: Colors.white),
          ),
        ));
  }
}

class ChooseLocationFromMap extends StatefulWidget {
  @override
  _ChooseLocationFromMapState createState() => _ChooseLocationFromMapState();
}

class _ChooseLocationFromMapState extends State<ChooseLocationFromMap> {
  /// selected and initial location
  LatLng selectedLocation;
  LatLng initialLocation;

  /// Map controller
  GoogleMapController googleMapController;

  static String googleMapApiKey = "AIzaSyDffXnGesbiKlJmXzvesQZVWOljqYWi4GY";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleMapApiKey);

  List<PlacesSearchResult> places = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  Set<Marker> markersList = new Set<Marker>();
  Placemark searchedPlace;

  /// method to get the data of a given coordinate
  Future<void> getLocationData({LatLng location}) async {}

  @override
  void initState() {
    super.initState();
    print("inside initState");
    scaffoldKey = new GlobalKey<ScaffoldState>();

    LocationManager.Location()
        .getLocation()
        .then((LocationManager.LocationData data) {
      setState(() {
        initialLocation = new LatLng(data.latitude, data.longitude);
      });
    });
  }

  GlobalKey pointerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: initialLocation ?? LatLng(33.327781, 44.408306),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller) async {
              scaffoldKey.currentState.showSnackBar(new SnackBar(
                content: Text(
                  "حدد الموقع عن طريق الضغط بالاصبع على المكان المناسب وسيظهر مؤشر اخضر يدل على الموقع المحدد",
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 10),
                action: SnackBarAction(
                    label: "Ok",
                    onPressed: () {
                      scaffoldKey.currentState.hideCurrentSnackBar();
                    }),
              ));
              setState(() {
                googleMapController = controller;
              });
              googleMapController
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: initialLocation ?? LatLng(33.327781, 44.408306),
                zoom: 12.0,
              )));
            },
            markers: <Marker>{
              if (initialLocation != null)
                new Marker(
                    markerId: MarkerId(
                        "${initialLocation.longitude}${initialLocation.latitude}"),
                    position: initialLocation,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    infoWindow: InfoWindow(title: "موقعك الحالي")),
              Marker(
                  markerId: MarkerId("selected"),
                  position: LatLng(33.43020963299009, 44.43556431680918),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange)),
              ...?markersList
            },
          ),
          Positioned(
            top: 10.0,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.07,
                  left: MediaQuery.of(context).size.width * 0.045),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  toolbarOptions: ToolbarOptions(
                      selectAll: true, copy: true, paste: true, cut: false),
                  onSubmitted: (input) async {
//                    Geolocator().placemarkFromAddress(input).then((places){
//                      var p = places[0];
//                      _places.searchNearbyWithRadius(Location(p.position.latitude,p.position.longitude), 2500)
//                      .then((PlacesSearchResponse res){
//                        if(res.isOkay){
//                          for(int i = 0; i < res.results.length;i++){
//                            markersList.add(new Marker(
//                              markerId: MarkerId("${res.results[i].id}"),
//                              position: LatLng(res.results[i].geometry.location.lat,res.results[i].geometry.location.lng),
//                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
//                            ));
//                            setState(() {
//                              googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//                                target: LatLng(res.results[0].geometry.location.lat,res.results[0].geometry.location.lng),
//                                zoom: 10.0
//                              )));
//                            });
//                          }
//                        }else{
//                          print(res.errorMessage);
//                          print("something went wrong");
//                        }
//                      });
//                    });
                    /// get the PlaceMark from the address searched for inside the TextField
                    Geolocator().placemarkFromAddress("$input").then((val) {
                      if (val[0].country != "العراق" ||
                          val[0].country.toLowerCase() != "iraq") {
                        throw new Error();
                      }
                      _animateTo(LatLng(
                          val[0].position.latitude, val[0].position.longitude));
                    }).catchError((err) {
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("no matching results"),
                        duration: Duration(seconds: 3),
                      ));
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "search for Places",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.47,
            child: IconButton(
              key: pointerKey,
              icon: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black),
              ),
              iconSize: 30.0,
              color: Colors.green,
              onPressed: () {
                googleMapController
                    .getLatLng(
                  ScreenCoordinate(
                      x: UstaFunctions.parseIntFrom(MediaQuery.of(context).size.width * 0.5),
                      y: UstaFunctions.parseIntFrom(
                          MediaQuery.of(context).size.width * 0.47)),
                )
                    .then((loc) {
                  print(loc);
                });
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.87,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                      child: Text("Confirm location"),
                      onPressed: () async {
                        googleMapController
                            .getScreenCoordinate(initialLocation)
                            .then((val) {
                          print(val);
                          print("this is the initial screen coordinates");
                        });
                        googleMapController
                            .getScreenCoordinate(
                                LatLng(33.43020963299009, 44.43556431680918))
                            .then((val) {
                          print(val);
                          print("***********************");
                        });
                        print((MediaQuery.of(context).size.width * 0.47)
                                .toString() +
                            " width");
                        print((MediaQuery.of(context).size.height * 0.5)
                                .toString() +
                            " height");
                        print(UstaFunctions.parseIntFrom(
                                    MediaQuery.of(context).size.width * 0.47)
                                .toString() +
                            "int width");
                        print(UstaFunctions.parseIntFrom(
                                    MediaQuery.of(context).size.height * 0.5)
                                .toString() +
                            "int height");

                        print(MediaQuery.of(context).size.width);
                        print(MediaQuery.of(context).size.height);
                        print("***************** above are the mediaQueries");
                        selectedLocation = await googleMapController.getLatLng(
                            ScreenCoordinate(
                                x: UstaFunctions.parseIntFrom(
                                    MediaQuery.of(context).size.width *
                                        0.47 *
                                        3.42),
                                y: UstaFunctions.parseIntFrom(
                                    MediaQuery.of(context).size.height *
                                        0.5 *
                                        3.215)));
                        googleMapController
                            .getScreenCoordinate(selectedLocation)
                            .then((value) {
                          print(
                              "this is the screen coordinates from the selected location");
                          print(value);
                        });
                        print(selectedLocation);
                        Navigator.of(context).pop([true, selectedLocation]);
                      },
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: Colors.blueAccent,
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop([false]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _animateTo(LatLng location) {
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: location,
      zoom: 10.0,
    )));
  }


}
