import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_pinterest/src/blocs/images/images_bloc.dart';
import 'package:like_pinterest/src/blocs/images/images_event.dart';
import 'package:like_pinterest/src/blocs/images/images_state.dart';
import 'package:like_pinterest/src/widgets/custom_bottom_navigation_bar.dart';
import 'package:like_pinterest/src/widgets/custom_header_button.dart';
import 'package:like_pinterest/src/widgets/image_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeaderButton(),
          Expanded(
            child: BlocBuilder<ImagesBloc, ImagesState>(
              builder: (context, state) {
                switch (state.status) {
                  case ImagesStatus.failure:
                    return const Center(child: Text('Loading images fail'));
                  case ImagesStatus.success:
                    if (state.images.isEmpty) {
                      return const Center(child: Text('No images'));
                    }
                    return StaggeredGridView.count(
                      controller: _scrollController,
                      crossAxisCount: 2,
                      staggeredTiles: List.generate(
                        state.images.length,
                        (int index) {
                          return const StaggeredTile.fit(1);
                        },
                      ),
                      children: List.generate(
                        state.images.length,
                        (int index) {
                          final image = state.images[index];
                          return ImageItem(image: image);
                        },
                      ),
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ImagesBloc>().add(LoadImages());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll && !_scrollController.position.outOfRange;
  }
}
