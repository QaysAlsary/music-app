import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message , ToastStates state){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      webBgColor: chooseWebToastColor(state),
      webPosition: 'center',
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {
  Success,
  Error,
  Warning
}

String chooseWebToastColor(ToastStates state){
  switch(state){
    case ToastStates.Success :
      return 'green';
    case ToastStates.Warning :
      return 'yellow';
    case ToastStates.Error :
      return 'red';
  }
}
Color chooseToastColor(ToastStates state){
  switch(state){
    case ToastStates.Success :
      return Colors.green;
    case ToastStates.Warning :
      return Colors.yellow;
    case ToastStates.Error :
      return Colors.red;
  }
}