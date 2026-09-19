import 'dart:io';
import 'dart:math';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class TextProcess {
  Future<String> textProcess(File imageFile) async {
    final interpreter =
        await tfl.Interpreter.fromAsset('assets/models/model.tflite');
    // Load the image using the image package
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // Resize the image to match the model's input dimensions (320x320)
    image = img.copyResizeCropSquare(image!, image.width);
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Convert the image to a tensor
    var tensorImage = TensorImage.fromImage(resizedImage);



    // Initialize output tensor with the correct shape [1, 6]
    var outputTensor = List.generate(1, (_) => List.filled(6, 0));

// print(outputTensor);

    // Run inference with the TensorFlow Lite model using the Interpreter
    try {
      interpreter.run(tensorImage.buffer, outputTensor);
    } catch (err) {
      print(err.toString());
    }
    print(outputTensor);
    String result = '';
    // Assuming the model returns a probability distribution
    // Find the index of the highest probability
    outputTensor[0][1]=outputTensor[0][1]~/100;
    print(outputTensor[0]);
    int highestProbIndex = outputTensor[0].indexOf(outputTensor[0].reduce(max));
    switch (highestProbIndex) {
      case 0:
        result = '1';
        break;
      case 1:
        result = '14';
        break;
      case 2:
        result = '4';
        break;
      case 3:
        result = "5";
        break; 
      case 4:
        result = "3";
        break;
      case 5:
        result = "1";
        break;
    }

    return result;
  }
}


