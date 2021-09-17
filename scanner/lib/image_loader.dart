import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<Directory> directory = getApplicationDocumentsDirectory();

Future<File> saveImageToDisk(String path, String name) async {
  try {
    Directory dir = await directory;
    File tempFile = File(path);
    Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
    String imgType = path.split('.').last;
    String mPath = '${dir.path.toString()}/$name.$imgType';
    File dFile = File(mPath);
    if (imgType == '.jpg' || imgType == '.jpeg'){
      dFile.writeAsBytesSync(Img.encodeJpg(image!));
    }
    else{
      dFile.writeAsBytesSync(Img.encodePng(image!));
    }
    return dFile;
  }catch(e){
    return File("");
  }
}

Future<File> loadImageFromSource(ImageSource imageSource) async {
  ImagePicker _imagePicker = ImagePicker();
  PickedFile? file = await _imagePicker.getImage(source: imageSource);
  if (file != null) {
    return File(file.path);
  }
  else {
    return File("");
  }
}

Future<List<File>> loadAllImagesFromDirectory() async {
  Directory dir = await directory;
  List<File> images = [];
  await for (var entity in dir.list()) {
    if (entity.path.endsWith(".jpg")) {
    images.add(File(entity.path));
    };
  }
  return images;
}

void deleteImage(String path) {
  final dir = Directory(path);
  dir.deleteSync(recursive: true);
}

void renameImage(String path, String newFileName) {
  String dir = Path.dirname(path);
  String newPath = Path.join(dir, "$newFileName.jpg");
  File file = File(path);
  file.renameSync(newPath);
}
