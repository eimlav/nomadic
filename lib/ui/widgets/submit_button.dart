import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nomadic/ui/shared/styles.dart';

class SubmitButton extends StatefulWidget {
  String title;
  Function callback;
  Function errorCallback;
  Function postCallback;
  bool theme;

  SubmitButton(this.title, this.callback,
      {this.errorCallback, this.postCallback, this.theme = false});

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _busy = false;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return FlatButton(
            color: widget.theme
                ? Colors.grey[200]
                : Theme.of(context).primaryColor,
            textTheme:
                widget.theme ? ButtonTextTheme.primary : ButtonTextTheme.accent,
            splashColor: widget.theme
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.5))),
            onPressed: () async {
              setState(() => _busy = true);
              var error = await widget.callback();
              if (error != null && error == true) {
                if (widget.errorCallback != null) await widget.errorCallback();
                setState(() => _busy = false);
                return;
              }
              setState(() => _done = true);
              await Future.delayed(Duration(milliseconds: 500));
              setState(() => _busy = false);
              if (widget.postCallback != null) widget.postCallback();
            },
            child: _done
                ? Icon(
                    Icons.done,
                    color: widget.theme
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                  )
                : _busy
                    ? SpinKitPulse(size: 20.0, color: Colors.red)
                    : Text(widget.title,
                        style: widget.theme
                            ? Styles.textButtonContrast
                            : Styles.textButton));
      },
    );
  }
}
