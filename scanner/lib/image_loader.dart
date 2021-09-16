import 'dart:io';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveImageToDisk(Map arguments) async {
  try {
    String path = arguments["path"];
    Directory directory = arguments["directory"];
    File tempFile = File(path);
    Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
    String imgType = path.split('.').last;
    String mPath = '${directory.path.toString()}/${DateTime.now()}.$imgType';
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

Future<File> loadImage(ImageSource imageSource) async {
  ImagePicker _imagePicker = ImagePicker();
  PickedFile? file = await _imagePicker.getImage(source: imageSource);
  File mFile = File('');
  if (file != null) {
    Directory directory = await getApplicationDocumentsDirectory();
    Map arguments = Map();
    arguments["path"] = file.path;
    arguments["directory"] = directory;
    mFile = await saveImageToDisk(arguments);
  }
  return mFile;
}