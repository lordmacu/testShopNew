import 'package:flutter/material.dart';

class ButtonW extends StatelessWidget {
  const ButtonW(
      {Key key, this.label, this.colorText, this.colorBackground, this.onTab});

  final String label;
  final Color colorBackground;
  final Color colorText;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: colorBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: onTab,
      child: Text(
        "${label}",
        style: TextStyle(color: colorText),
      ),
    );
  }
}
