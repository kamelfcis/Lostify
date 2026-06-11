import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';

Future<String> classifyImageViaApi({
  required ApiConsumer apiConsumer,
  required File selectedImage,
  String? token,
}) async {
  final multipartFile = await MultipartFile.fromFile(
    selectedImage.path,
    filename: selectedImage.path.split(RegExp(r'[/\\]')).last,
  );

  final response = await apiConsumer.post(
    EndPoints.searchByImage,
    data: {'image': multipartFile},
    isformdata: true,
    token: token,
  );

  if (response is Map<String, dynamic>) {
    final category = response['category'];
    if (category is String && category.isNotEmpty) {
      return category;
    }
    final error = response['error'] ?? response['detail'];
    if (error != null) {
      throw Exception(error.toString());
    }
  }

  throw Exception('No category returned from image search');
}
