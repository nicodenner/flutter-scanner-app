import 'dart:io' as IO;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:scanner/image_loader.dart' as img_loader;






class ImgProcessor{
  static int counter = 0; // counter to prevent overwrite.
  // image_loader.loadAllImagesFromDirectory() doesn't reload pics with same name even though content changed

  Future<void> augBlue(IO.File input_file) async{
    var imageFile = input_file.readAsBytesSync();
    // decodeImage can identify the format of the image and
    // decode the image accordingly
    final image = decodeImage(imageFile)!;
    final new_pic =  brightness(image, 100)!;
    IO.Directory temp_dir = await img_loader.directory;
    String filename = input_file.path.split('/').last;
    filename = filename.split('.').first;
    //final newpic = copyResize(image, width: 120);
    IO.File(temp_dir.path +'/' + filename + '_${counter.toString()}_Edit.jpg').writeAsBytesSync(encodeJpg(new_pic));
    counter = counter + 1;
    //await img_loader.saveImageToDisk(temp_dir.path, 'edited_' + filename);
  }
/*
  Future<IO.File> aug_red(IO.File input_file) async{
    var imageFile = input_file.readAsBytesSync();
    // decodeImage can identify the format of the image and
    // decode the image accordingly
    final loadedImage = decodeImage(imageFile)!;
    var image = loadedImage.clone();
    for (var x; x < image.width; ++x){
      for (var y; y < image.height; ++y){
        var pxl = image.getPixel(x, y);

      }
    }
    final new_pic =  brightness(image, 100)!;
    //final newpic = copyResize(image, width: 120);
    IO.Directory tempDir = await directory;
    IO.File(tempDir.path + '/kitten.jpg').writeAsBytesSync(encodePng(new_pic));
    return IO.File(tempDir.path + '/kitten.jpg');
  }
  */
}