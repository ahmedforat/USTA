import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _password;
  String _gender;
  bool _isEmployed;
  String _dateOfRegistration;

  User(
      {String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String gender,
      bool isEmployed = false}) {
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._password = password;
    this._gender = gender;
    this._isEmployed = isEmployed;
    this._dateOfRegistration = DateTime.now().toIso8601String();
  }

  String get firstName => this._firstName;

  String get lastName => this._lastName;

  String get email => this._email;

  String get phoneNumber => this._phoneNumber;

  String get password => this._password;

  String get gender => this._gender;

  bool get isEmployed => this._isEmployed;
}

class RegisteredUser {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  bool isEmployed;
  bool graduated;
  bool isTutor;
  String gender;
  String college;
  String university;

  RegisteredUser(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.isEmployed,
      this.graduated,
      this.isTutor,
      this.gender,
      this.college,
      this.university});

  factory RegisteredUser.fromJson(Map<String, dynamic> parsedJson) {
    return RegisteredUser(
        firstName: parsedJson["firstName"],
        lastName: parsedJson["lastName"],
        email: parsedJson["email"],
        phoneNumber: parsedJson["phoneNumber"],
        isEmployed: parsedJson["isEmployed"],
        isTutor: parsedJson["isTutor"],
        graduated: parsedJson["graduated"],
        university: parsedJson["university"],
        college: parsedJson["college"],
        gender: parsedJson["gender"]);
  }
}

//coursePayload = {
//"title":titleController.text,
//"date":selectedDate,
//"time":selectedTime,
//"price":isFree ? "0.0" : priceController.text,
//"typeOfPayment":typeOfPrice,
//"duration":durationController.text,
//"addressDescription":addressDescriptionController.text,
//"location":courseLocation,
//"description":courseDescriptionController.text,
//"phone":phoneNumberController.text,
//"thumbnail":courseImages.length == 0 ? null :courseImages
//};



class Course {
  final String title, price, duration, addressDescription, description, phone,typeOfPayment;
  final DateTime date;
  final TimeOfDay time;
  LatLng location;
  List<File> images;

  Course(
      {this.title,
      this.date,
      this.time,
      this.price,
      this.typeOfPayment,
      this.duration,
      this.description,
      this.location,
      this.addressDescription,
      this.images,
      this.phone}
      );
}


class Feed{
  final String name;
  final List<String> sub;

  Feed({this.name,this.sub});

  factory  Feed.fromJson({Map<String,dynamic> json}){
    return Feed(
      name:json["name"],
      sub: List.from(json["sub"])
    );
  }
}