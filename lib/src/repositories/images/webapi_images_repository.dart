import 'package:dio/dio.dart';
import 'package:like_pinterest/src/models/picsum_image.dart';
import 'package:like_pinterest/src/repositories/images/images_repository.dart';

class WebApiImagesRepository implements ImagesRepository {
  final Dio _dio = Dio();

  @override
  Future<List<PicsumImage>> loadImages(String url) async {
    final response = await _dio.get(url);
    return response.data
        .map<PicsumImage>((image) => PicsumImage.fromJson(image))
        .toList();
  }
}
