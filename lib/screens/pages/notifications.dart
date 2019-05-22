import 'package:easyku_app/models/ResultList.dart';
import 'package:easyku_app/screens/pages/results.dart';
import 'package:easyku_app/services/fetchData.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<ResultListWithDate> resultList = new List();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications().then((results) {
      if(this.mounted)
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
