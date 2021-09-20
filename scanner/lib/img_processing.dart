import 'dart:io' as IO;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<IO.Directory> directory = path_provider.getApplicationDocumentsDirectory();




class ImgProcessor{
  Future<IO.File> aug_black(IO.File input_file) async{
    var imageFile = input_file.readAsBytesSync();
    // decodeImage can identify the format of the image and
    // decode the image accordingly
    final image = decodeImage(imageFile)!;
    final new_pic =  brightness(image, 100)!;
    //final newpic = copyResize(image, width: 120);
    IO.Directory tempDir = await directory;
    IO.File(tempDir.path + '/kitten.jpg').writeAsBytesSync(encodePng(new_pic));
    return IO.File(tempDir.path + '/kitten.jpg');
  }

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
}