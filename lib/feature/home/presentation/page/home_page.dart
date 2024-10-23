import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/app/router/routes.dart';
import 'package:socially/data/repository.dart';
import 'package:socially/feature/home/bloc/posts/posts_bloc.dart';
import 'package:socially/feature/home/bloc/stories/stories_bloc.dart';
import 'package:socially/gen/assets.gen.dart';

import '../widget/home_bottom_navigation.dart';
import 'home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static final route = GoRoute(
    path: AppRoute.home,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PostsBloc(context.read())..add(PostsGetDataEvent()),
          ),
          BlocProvider(
            create: (_) => StoriesBloc(context.read()),
          ),
        ],
        child: HomePage(
          key: state.pageKey,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 76,
        title: Assets.svg.logo.svg(
          height: 24,
        ),
        leading: IconButton(
          onPressed: () {
            context.read<Repository>().fillDummyStories();
            // context.read<Repository>().fillDummyData();
          },
          splashRadius: 24,
          icon: Assets.svg.bell.svg(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        bloc: context.read(),
        builder: (context, state) {
          if (state is PostsSuccessState) {
            return HomePageContent(
              posts: state.data,
            );
          }

          if (state is PostsErrorState) {
            return Text(state.error.message ?? state.error.toString());
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: 0,
        onTap: (value) {
          // setState(() {
          //   bottomNavigationIndex = value;
          // });
        },
      ),
    );
  }
}
