import 'package:equatable/equatable.dart';
import 'package:like_pinterest/src/models/picsum_image.dart';

enum ImagesStatus { initial, success, failure }

class ImagesState extends Equatable {
  const ImagesState({
    this.status = ImagesStatus.initial,
    this.images = const <PicsumImage>[],
    this.maxValue = false,
  });

  final ImagesStatus status;
  final List<PicsumImage> images;
  final bool maxValue;

  ImagesState copyWith({
    ImagesStatus? status,
    List<PicsumImage>? images,
    bool? maxValue,
  }) {
    return ImagesState(
      status: status ?? this.status,
      images: images ?? this.images,
      maxValue: maxValue ?? this.maxValue,
    );
  }

  @override
  String toString() {
    return '''ImagesState { status: $status, maxValue: $maxValue, posts: ${images.length} }''';
  }

  @override
  List<Object> get props => [status, images, maxValue];
}
