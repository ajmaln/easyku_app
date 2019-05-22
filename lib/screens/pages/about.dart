import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        SizedBox(
            height: mediaQuery.size.height * 0.25,
            child: Column(
              children: <Widget>[
                Center(
                  child:Text(
                  'easyKU',
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                )),
                Center(
                  child:Text('Get your results on time!'),
                )
              ],
            )),

        SizedBox(
          height: mediaQuery.size.height * 0.1,
        ),
        Center(
          child: Text('Developed by'),
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.05,
        ),
        Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'https://ajmaln.github.io/static/media/ajmal.5bf55c6f.jpeg',
                  width: 75.0,
                ))),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Ajmal Noushad",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text("Follow me on Github"),
        Text(
          "@ajmaln",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
        //Image(image: ImageProvider(''),),)
      ],
    );
  }
}
