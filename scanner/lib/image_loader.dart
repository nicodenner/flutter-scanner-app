import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:path_provider/path_provider.dart' as path_provider;

/// Current working directory of the app
Future<Directory> directory = path_provider.getApplicationDocumentsDirectory();

/// Saves file, located at [path], at the current working directory.
///
/// Uses [name] to name the new file.
/// File gets saved under '$directory/$name.jpg'.
Future<File> saveImageToDisk(String path, String name) async {
  try {
    Directory dir = await directory;
    File tempFile = File(path);
    Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
    String imgType = path.split('.').last;
    String mPath = '${dir.path.toString()}/$name.$imgType';
    File dFile = File(mPath);
    dFile.writeAsBytesSync(Img.encodeJpg(image!));
    return dFile;
  }catch(e){
    return File("");
  }
}

/// Loads image from [imageSource].
///
/// Use 'image_picker.ImageSource.camera' for loading image from camera.
/// Use 'image_picker.ImageSource.gallery' for loading image from gallery.
Future<File> loadImageFromSource(image_picker.ImageSource imageSource) async {
  image_picker.ImagePicker _imagePicker = image_picker.ImagePicker();
  image_picker.PickedFile? file = await _imagePicker.getImage(source: imageSource);
  if (file != null) {
    //todo remove following line if saving should happen after editing and not after picking image
    String imageName = DateTime.now().toString();
    File dFile = await saveImageToDisk(file.path, imageName.substring(0, imageName.indexOf(".")));
    return File(dFile.path);
  }
  else {
    return File("");
  }
}

/// Loads all the '.jpg' files from the current working directory.
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

/// Deletes Image from working directory.
void deleteImage(String path) {
  final dir = Directory(path);
  dir.deleteSync(recursive: true);
}

/// Renames Image at [path] with [newFileName].
///
/// Assumes file at [path] is from type '.jpg'.
/// Saves renamed file at the exact same directory location.
void renameImage(String path, String newFileName) {
  String dir = Path.dirname(path);
  String newPath = Path.join(dir, "$newFileName.jpg");
  File file = File(path);
  file.renameSync(newPath);
}
