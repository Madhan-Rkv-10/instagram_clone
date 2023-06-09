import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' as material show Image;
import 'package:my_instagram/src/utils/src/extensions/get_image_with_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  ///get the File Size
  Future<double> getAspectRatio() {
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}
