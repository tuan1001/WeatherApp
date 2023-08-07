// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/widgets/loading/lazy_load.dart';

class MainSliverLayout extends StatelessWidget {
  final String title;
  final Widget? bottom;
  final Widget body;
  final bool overlayLoading;
  final Widget? flexibleSpaceBar;
  final double? expandedHeight;
  final ScrollController? controller;
  final bool? home;
  final bool? loadMore;
  final Future<void> Function() onRefresh;
  final Color? backgroundColor;
  final bool? automaticallyImplyLeading;
  const MainSliverLayout(
      {Key? key,
      required this.title,
      this.bottom,
      required this.body,
      required this.overlayLoading,
      this.flexibleSpaceBar,
      this.expandedHeight,
      this.controller,
      this.home,
      this.loadMore,
      required this.onRefresh,
      this.backgroundColor,
      this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          overlayLoading == true
              ? const ShowLoading()
              : NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverAppBar(
                          title: Text(title.toUpperCase()),
                          centerTitle: true,
                          pinned: true,
                          expandedHeight: expandedHeight ?? 120,
                          automaticallyImplyLeading: automaticallyImplyLeading ?? false,
                          forceElevated: innerBoxIsScrolled,
                          backgroundColor: backgroundColor ?? themeColor,
                          flexibleSpace: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              return flexibleSpaceBar ?? Container();
                            },
                          ),
                        ),
                      ),
                    ];
                  },
                  body: _buidBody(body),
                ),
        ],
      ),
    );
  }

  _buidBody(Widget body) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return body;
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
