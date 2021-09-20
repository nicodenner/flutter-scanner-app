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
    IO.File(temp_dir.path +'/' + filename + '_${counter.toString()}_Edit.jpg').writeAsBytesSync(encodeJpg(new_pic));
    counter = counter + 1;
  }

  Future<void> augRed(IO.File input_file) async{
    var imageFile = input_file.readAsBytesSync();
    // decodeImage can identify the format of the image and
    // decode the image accordingly
    final image = decodeImage(imageFile)!;
    Image edit_img = Image.from(image);       //make editable copy of img
    for (var x = 0; x < image.width; ++x){
      for (var y = 0; y < image.height; ++y){
        var pxl = image.getPixel(x, y);
        var red  = getRed(pxl);
        var green = getGreen(pxl);
        var blue  = getBlue(pxl);
        if (red > 140 && blue < 120 && green < 120){
          //check if the red channel is above a certain threshold and blue and green
          // below a threshold. If so set the pixel to maximum red and other channels to 0.
          edit_img.setPixelRgba(x, y, 255, 0, 0);
        }
      }
    }

    //final new_pic =  brightness(image, 100)!;
    IO.Directory temp_dir = await img_loader.directory;
    String filename = input_file.path.split('/').last;
    filename = filename.split('.').first;
    IO.File(temp_dir.path +'/' + filename + '_${counter.toString()}_Edit.jpg').writeAsBytesSync(encodeJpg(edit_img));
    counter = counter + 1;
  }

  Future<void> augWhite(IO.File input_file) async{
    var imageFile = input_file.readAsBytesSync();
    // decodeImage can identify the format of the image and
    // decode the image accordingly
    final image = decodeImage(imageFile)!;
    Image edit_img = Image.from(image);       //make editable copy of img
    for (var x = 0; x < image.width; ++x){
      for (var y = 0; y < image.height; ++y){
        var pxl = image.getPixel(x, y);
        var red  = getRed(pxl);
        var green = getGreen(pxl);
        var blue  = getBlue(pxl);
        if (red > 160 && blue > 160 && green > 150){
          //check if the red channel is above a certain threshold and blue and green
          // below a threshold. If so set the pixel to maximum red and other channels to 0.
          edit_img.setPixelRgba(x, y, 255, 255, 255);
        }
      }
    }

    //final new_pic =  brightness(image, 100)!;
    IO.Directory temp_dir = await img_loader.directory;
    String filename = input_file.path.split('/').last;
    filename = filename.split('.').first;
    IO.File(temp_dir.path +'/' + filename + '_${counter.toString()}_Edit.jpg').writeAsBytesSync(encodeJpg(edit_img));
    counter = counter + 1;
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