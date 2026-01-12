import 'package:flutter/material.dart';


void showDefaultError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(errorMessage),
    ),
  );
}

void showDefaultSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
    ),
  );
}

void showDefaultSuccessShowFile (BuildContext context, String message, Function action){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Buka',
        onPressed: () {
          action();
        },
      ),
    ),
  );
}
