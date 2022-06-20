import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_pinterest/src/blocs/images/images_event.dart';
import 'package:like_pinterest/src/blocs/images/images_state.dart';
import 'package:like_pinterest/src/repositories/images/images_repository.dart';
import 'package:stream_transform/stream_transform.dart';

const _perPageLimit = 25;
const _pageLimit = 6;
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesRepository imagesRepository;
  final String url;
  late int paginator;

  ImagesBloc(this.imagesRepository, this.url) : super(const ImagesState()) {
    on<LoadImages>(
      _onLoadImages,
      transformer: throttleDroppable(throttleDuration),
    );
    paginator = 1;
  }

  void _onLoadImages(
    LoadImages event,
    Emitter<ImagesState> emit,
  ) async {
    if (state.maxValue) return;
    try {
      final imagesUrl = '$url?page=$paginator&limit=$_perPageLimit';
      print('Next images loading... url: $imagesUrl');
      if (state.status == ImagesStatus.initial) {
        final images = await imagesRepository.loadImages(imagesUrl);
        paginator++;
        return emit(state.copyWith(
          status: ImagesStatus.success,
          images: images,
          maxValue: false,
        ));
      }
      final images = await imagesRepository.loadImages(imagesUrl);
      paginator++;
      emit(state.copyWith(
        status: ImagesStatus.success,
        images: List.of(state.images)..addAll(images),
        maxValue: paginator > _pageLimit,
      ));
    } catch (_) {
      emit(state.copyWith(status: ImagesStatus.failure));
    }
  }
}
