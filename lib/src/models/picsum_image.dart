import 'package:equatable/equatable.dart';

class PicsumImage extends Equatable {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  const PicsumImage(
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  );

  @override
  List<Object> get props => [id, author, width, height, url, downloadUrl];

  @override
  String toString() {
    return 'PicsumImage { downloadUrl: $downloadUrl, url: $url, height: $height, width: $width, author: $author, id: $id }';
  }

  PicsumImage copyWith({
    String? id,
    String? author,
    int? width,
    int? height,
    String? url,
    String? downloadUrl,
  }) {
    return PicsumImage(
      id ?? this.id,
      author ?? this.author,
      width ?? this.width,
      height ?? this.height,
      url ?? this.url,
      downloadUrl ?? this.downloadUrl,
    );
  }

  PicsumImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        width = json['width'],
        height = json['height'],
        url = json['url'],
        downloadUrl = json['download_url'];
}
