import 'package:easyku_app/services/fileOp.dart';
import 'package:flutter/material.dart';

class CardButtons extends StatefulWidget {
  final bool showThree;
  final String link;

  CardButtons(
      {this.link,
      this.showThree,
      this.onDownloadPress,
      this.onViewPress,
      this.onDownloadProgress,
      this.onDownloadComplete,
      this.onDeleteSuccess});

  final VoidCallback onDownloadPress;
  final VoidCallback onViewPress;
  final Function onDownloadProgress;
  final Function onDownloadComplete;
  final Function onDeleteSuccess;

  @override
  _CardButtonsState createState() => _CardButtonsState();
}

class _CardButtonsState extends State<CardButtons>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          animatedGradientButton(
            that: this,
            text: widget.showThree ? "View" : "Download",
            width: widget.showThree
                ? mediaQueryData.size.width * 0.25
                : mediaQueryData.size.width * 0.9,
            onPressed: () {
              downloadFile(
                widget.link,
                filename:
                    widget.link.substring(widget.link.lastIndexOf('/') + 1),
                onProgress: widget.onDownloadProgress,
                onDone: widget.onDownloadComplete,
              );
            },
            gradient: LinearGradient(
              colors: [Color(0xffb92b27), Color(0xff1565c0)],
            ),
          ),
          animatedGradientButton(
              that: this,
              text: "Share",
              width: widget.showThree ? mediaQueryData.size.width * 0.25 : 0,
              onPressed: () {
                shareFile(widget.link.substring(widget.link.lastIndexOf('/') + 1));
              },
              gradient: LinearGradient(
                colors: [Colors.green, Colors.yellow],
              )),
          animatedGradientButton(
              that: this,
              text: "Delete",
              width: widget.showThree ? mediaQueryData.size.width * 0.25 : 0,
              onPressed: () {
                String filename = widget.link.substring(widget.link.lastIndexOf('/') + 1);
                deleteFile(filename, widget.onDeleteSuccess);
              },
              gradient: LinearGradient(
                colors: [Colors.red, Colors.red[200]],
              ))
        ],
      ),
    );
  }
}

Widget animatedGradientButton(
    {onPressed, text, Gradient gradient, double width, that}) {
  return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
      vsync: that,
      child: gradientButton(
          text: text, onPressed: onPressed, width: width, gradient: gradient));
}

Widget gradientButton({onPressed, text, Gradient gradient, double width}) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: width),
    child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(0.0),
        textColor: Colors.white,
        child: Container(
          width: width,
          decoration: BoxDecoration(
              gradient: gradient, borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Center(child: Text(text)),
        ),
        onPressed: onPressed),
  );
}
