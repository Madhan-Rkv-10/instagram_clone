import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/utils/src/extensions/get_image_with_aspect_ratio.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../utils/src/extensions/file_type.dart';
import '../exception/thumbnail_exception.dart';
import '../models/image_with_aspect_ratio.dart';
import '../models/thumbnail_request.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, requestValue) async {
  final Image image;
  switch (requestValue.fileType) {
    case FileType.image:
      image = Image.file(
        requestValue.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: requestValue.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thumb,
        fit: BoxFit.fitHeight,
      );

      break;
  }
  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
});
