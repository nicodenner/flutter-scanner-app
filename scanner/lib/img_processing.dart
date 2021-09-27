import 'package:image/image.dart';

enum AugColor {red, green, blue, white, black}

/// Returns a function that receives the values for r, g, b and evaluates if
/// color augmentation for [color] is needed.
///
/// Returns a function so other implementations of the Threshold evaluation are easily
/// integrable.
Function evalThresh (AugColor color){
  int threshRed = 0;
  int threshGreen = 0;
  int threshBlue = 0;

  switch (color){
    case AugColor.red:
      threshRed = 125;
      threshGreen = 95;
      threshBlue = 95;
      return (int red, int green, int blue) {
        return (red > threshRed && green < threshGreen && blue < threshBlue);
      };
    case AugColor.green:
      threshRed = 45;
      threshGreen = 60;
      threshBlue = 45;
      return (int red, int green, int blue) {
        return (red < threshRed && green > threshGreen && blue < threshBlue);
      };
    case AugColor.blue:
      threshRed = 50;
      threshGreen = 50;
      threshBlue = 75;
      return (int red, int green, int blue) {
        return (red < threshRed && green < threshGreen && blue > threshBlue);
      };
    case AugColor.white:
      threshRed = 135;
      threshGreen = 135;
      threshBlue = 135;
      return (int red, int green, int blue) {
        return (red > threshRed && green > threshGreen && blue > threshBlue);
      };
    case AugColor.black:
      threshRed = 75;
      threshGreen = 75;
      threshBlue = 75;
      return (int red, int green, int blue) {
        return (red < threshRed && green < threshGreen && blue < threshBlue);
      };
  }
}

Function mainColorSetter (Image img, AugColor mainColor){
  switch (mainColor){
    case AugColor.red:
      return (int x, int y) => img.setPixelRgba(x, y, 255, 0, 0);
    case AugColor.green:
      return (int x, int y) => img.setPixelRgba(x, y, 0, 255, 0);
    case AugColor.blue:
      return (int x, int y) => img.setPixelRgba(x, y, 0, 0, 255);
    case AugColor.white:
      return (int x, int y) => img.setPixelRgba(x, y, 255, 255, 255);
    case AugColor.black:
      return (int x, int y) => img.setPixelRgba(x, y, 0, 0, 0);
  }
}

Image fAugColor(Image inImg, AugColor color){
  Image editImg = Image.from(inImg);       //make editable copy of img
  Function setMainColor = mainColorSetter(editImg, color);
  Function evalColor = evalThresh(color);

  // goes through each pixel in every row and every column
  for (var x = 0; x < inImg.width; ++x) {
    for (var y = 0; y < inImg.height; ++y) {
      var pxl = inImg.getPixel(x, y);
      int red = getRed(pxl);
      int green = getGreen(pxl);
      int blue = getBlue(pxl);

      if (evalColor(red, green, blue)) {
        //check if the red channel is above a certain threshold and blue and green
        // below a threshold. If so set the pixel to maximum red and other channels to 0.
        setMainColor(x,y);
      }
    }
  }
  return editImg;
}