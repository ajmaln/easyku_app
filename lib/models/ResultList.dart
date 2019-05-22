//

class ResultListWithDate {
  String date;
  ResultList rl;

  ResultListWithDate.fromJson(Map<String, dynamic> json) {
    date = json.keys.first;
    rl = ResultList.fromJson(json[date]);
  }

  @override
  String toString() {
    return ({"date": date, "results": rl.toString()}).toString();
  }
}

class ResultList {
  final List<Results> results;  

  ResultList({
    this.results
  });

  factory ResultList.fromJson(List json) {
    List<Results> results = new List<Results>();
    json.forEach((v) {
      results.add(Results.fromJson(v));
    });
    return ResultList(
      results: results
    );
  }

  @override
  String toString() {
    return results.toString();
  }
}


// class ResultList {
//   String date;
//   List<Results> results;

//   ResultList({this.date, this.results});

//   ResultList.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     if (json['results'] != null) {
//       results = new List<Results>();
//       json['results'].forEach((v) {
//         results.add(new Results.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     if (this.results != null) {
//       data['results'] = this.results.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Results {
  String title;
  String link;

  Results({this.title, this.link});

  Results.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }

  @override
  String toString() {
    return ({"title": title, "link": link}).toString();
  }
}