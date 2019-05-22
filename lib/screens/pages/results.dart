import 'package:easyku_app/screens/pages/widgets/cardButtons.dart';
import 'package:easyku_app/services/fetchData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../models/ResultList.dart';
import 'package:easyku_app/services/fileOp.dart';

class Result extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<ResultListWithDate> resultList = new List();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchResults().then((results) {
      if (this.mounted)
        setState(() {
          resultList = results;
          loading = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(resultList.length.toString());
    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              return ResultWithDate(
                date: resultList[index].date,
                results: resultList[index].rl,
              );
            },
          );
  }
}

class ResultWithDate extends StatelessWidget {
  final String date;
  final ResultList results;

  ResultWithDate({this.date, this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: results.results
          .asMap()
          .map((index, each) {
            if (index == 0) {
              return MapEntry(
                  index,
                  Column(children: <Widget>[
                    Center(
                      child: Text(date),
                    ),
                    ResultElement(
                      title: each.title,
                      link: each.link,
                      date: date,
                    )
                  ]));
            }
            return MapEntry(
                index,
                ResultElement(
                  title: each.title,
                  link: each.link,
                  date: date,
                ));
          })
          .values
          .toList(),
    );
  }
}

class ResultElement extends StatefulWidget {
  final String title;
  final String link;
  final String date;

  ResultElement({this.title, this.link, this.date});

  @override
  _ResultElementState createState() => _ResultElementState();
}

class _ResultElementState extends State<ResultElement>
    with TickerProviderStateMixin {
  double downloadPercentage;
  bool downloaded = false;

  void initState() {
    super.initState();
    fileExists(widget.link.substring(widget.link.lastIndexOf('/') + 1))
        .then((exists) {
      setState(() {
        downloaded = exists;
      });
    });
    downloadPercentage = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    bool showDownloadIndicator = downloadPercentage > 0.0 && !downloaded;
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Card(
            child: AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
          vsync: this,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(widget.title),
                Align(
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 10.0,
                ),
                showDownloadIndicator
                    ? LinearProgressIndicator(value: downloadPercentage)
                    : SizedBox(
                        height: 0.0,
                      ),
                showDownloadIndicator
                    ? SizedBox(
                        height: 10.0,
                      )
                    : SizedBox(
                        height: 0.0,
                      ),
                CardButtons(
                  link: widget.link,
                  onDownloadProgress: (completedPercentage) {
                    setState(() {
                      downloadPercentage = completedPercentage;
                    });
                  },
                  onDownloadComplete: (completedPercentage) {
                    setState(() {
                      downloadPercentage = completedPercentage;
                      downloaded = true;
                    });
                  },
                  onDeleteSuccess: () {
                    setState(() {
                      downloaded = false;
                      downloadPercentage = 0.0;
                    });
                  },
                  showThree: downloaded,
                )
              ],
            ),
          ),
        )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
