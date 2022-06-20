import 'package:like_pinterest/src/models/picsum_image.dart';

abstract class ImagesRepository {
  Future<List<PicsumImage>> loadImages(String url);
}
