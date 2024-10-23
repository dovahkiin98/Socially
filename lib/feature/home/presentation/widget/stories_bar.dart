import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/app/router/routes.dart';
import 'package:socially/app/theme/colors.dart';
import 'package:socially/feature/home/bloc/stories/stories_bloc.dart';

import 'story_item.dart';

/// A Horizontal [ListView] that contains avatars of viewable stories
class StoriesBar extends StatefulWidget {
  const StoriesBar({
    super.key,
  });

  @override
  State<StoriesBar> createState() => _StoriesBarState();
}

class _StoriesBarState extends State<StoriesBar> {
  @override
  void initState() {
    super.initState();

    context.read<StoriesBloc>().add(StoriesGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(
      bloc: context.read<StoriesBloc>(),
      builder: (context, state) {
        if (state is StoriesSuccessState) {
          final stories = state.data;

          if (stories.isEmpty) {
            return SizedBox.shrink();
          }

          return SizedBox(
            height: 76,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(48)),
                ),
                clipBehavior: Clip.hardEdge,
                color: AppColors.primaryContainer,
                child: ListView.builder(
                  itemCount: stories.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(2),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    final story = stories[i];
                    return StoryItem(
                      story: story,
                      onTap: () {
                        context.push(
                          AppRoute.stories,
                          extra: StoriesArgs(
                            startIndex: i,
                            story: story,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }

        if (state is StoriesErrorState) {
          return const SizedBox.shrink();
        }

        return const Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
