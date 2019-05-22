import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_extend/share_extend.dart';

downloadFile(String url, {String filename, onProgress, onDone}) async {
  if (!(await fileExists(filename))) {
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    List<List<int>> chunks = new List();
    int sum = 0;
    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        chunks.add(chunk);
        sum += chunk.length;
        onProgress(sum / r.contentLength);
      }, onDone: () async {
        onDone(sum / r.contentLength);
        saveAndOpen(filename, chunks, r.contentLength);
      });
    });
    // var request = await httpClient.getUrl(Uri.parse(url));
    // var response = await request.close();
    // var bytes = await consolidateHttpClientResponseBytes(response);
    // File file = new File('$dir/$filename');
    // await file.writeAsBytes(bytes);
  }
  justOpen(filename);
}

Future<bool> pathExists(String path) async {
  return FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;
}

Future<bool> fileExists(String filename) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  return pathExists('$dir/$filename');
}

void shareFile(String filename) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File("$dir/$filename");
  if (await file.exists()) {
    ShareExtend.share(file.path, "file"); 
  }
}

justOpen(String filename) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  OpenFile.open('$dir/$filename');
}

saveAndOpen(String filename, List<List<int>> chunks, int contentLength) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  final Uint8List bytes = Uint8List(contentLength);
  int offset = 0;
  for (List<int> chunk in chunks) {
    bytes.setRange(offset, offset + chunk.length, chunk);
    offset += chunk.length;
  }
  await file.writeAsBytes(bytes);
  OpenFile.open('$dir/$filename');
}

deleteFile(String filename, Function onSuccess) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  file.exists().then((exists) {
    if(exists) {
      file.delete().then((FileSystemEntity f) {
        onSuccess();
      });
    }
  });
}
