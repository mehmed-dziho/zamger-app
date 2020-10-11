import 'package:zamger/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncButton extends FlatButton {
  const AsyncButton({
    this.onPressed,
    this.child,
    this.async,
  });

  final VoidCallback onPressed;
  final Widget child;
  final bool async;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: WHITE_BORDER, width: 1),
      onPressed: () {
        if (!async) {
          onPressed();
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (async)
            Container(
              width: 16.0,
              height: 16.0,
              margin: EdgeInsets.only(right: 12.0),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          else
            Container(),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: async ? 0.5 : 1.0,
            child: child,
          ),
        ],
      ),
    );
  }
}
