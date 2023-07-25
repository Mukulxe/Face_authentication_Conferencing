import 'dart:ui';
import 'package:projectapp/ML/Recognition.dart';
import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';

import 'package:projectapp/RegistrationScreen.dart';
import 'package:projectapp/RecognitionScreen.dart';

class Recognition {
  String name;
  Rect location;
  List<double> embeddings;
  double distance;
  /// Constructs a Category.
  Recognition(this.name, this.location,this.embeddings,this.distance);

}
