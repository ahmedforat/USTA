import 'dart:ui';

import 'package:flutter_login_page_ui/utils/validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CourseCredentialsValidators{

  static String validateTitle({title}){
    if(title == null || title.toString().isEmpty)
      return "title is required";
    if(title.toString().length < 3)
      return "title must not be shorter than 3 characters";
    return null;
  }

  static String validateDate({date}) => date == null ? "date of the course is required" : null;
  static String validateTime ({time}) => time == null ? "time of the course is required" : null;
  static String validatePaymentType ({payment}) => payment == null ? "type of payment is required " : null;
  static String validateAddressDescription ({address}) => address == null || address.toString().isEmpty ? "please specify a brief description for the address": null;
  static String validateMapLocation ({LatLng loc}) => loc == null ? "please specify the location on map" : null;

  // validate the course description
  static String validateCourseDesc ({description}){
    if(description.toString().isEmpty || description == null)
      return "please provide a description for the course";

    if(description.toString().length < 60)
      return "please course description must be not shorter than 100 characters";

    return null;
  }

  // validate the price of the course
  static String validatePrice ({price}) {
    if (price == null || price.toString().isEmpty)
      return "this field is required";
    try{
      int.parse(price);
    }catch(err){
      return "please provide a valid price (use numbers only)";
    }
    return null;
  }

  static String validateDuration ({duration}){
    if(duration == null || duration.toString().isEmpty)
      return "please specify the duration of the course";
    try{
      int.parse(duration);
    }catch(err){
      return "please provide a valid duration (use numbers only)";
    }

    return null;

  }

  // validate phone number

static String validatePhoneNumber({phoneNumber}){
    return Validators.validatePhoneNumber(phoneNumber: phoneNumber);
}


}