// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/widgets/loading/lazy_load.dart';

class TabbarSliverLayout extends StatefulWidget {
  final String title;
  final TabController tabController;
  final List<Widget> tabs;
  final List<Widget> body;
  final bool overlayLoading;
  final Widget? flexibleSpaceBar;
  final double? expandedHeight;
  final bool? automaticallyImplyLeading;
  final Future<void> Function() onRefresh;
  final ScrollController? scrollController;
  const TabbarSliverLayout(
      {Key? key,
      required this.tabController,
      required this.title,
      required this.body,
      required this.overlayLoading,
      required this.tabs,
      this.flexibleSpaceBar,
      this.expandedHeight,
      this.automaticallyImplyLeading,
      required this.onRefresh,
      this.scrollController});

  @override
  State<TabbarSliverLayout> createState() => _TabbarSliverLayoutState();
}

class _TabbarSliverLayoutState extends State<TabbarSliverLayout> {
  TabBar get _tabBar => TabBar(
      labelPadding: EdgeInsets.symmetric(horizontal: 7),
      controller: widget.tabController,
      isScrollable: true,
      indicatorColor: transparentColor,
      labelColor: transparentColor,
      unselectedLabelColor: Colors.grey,
      tabs: widget.tabs);
  @override
  Widget build(BuildContext context) {
    return (widget.overlayLoading == true)
        ? const Center(child: ShowLoading())
        : DefaultTabController(
            length: widget.tabController.length, // This is the number of tabs.
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      title: Text(widget.title.toUpperCase()),
                      pinned: true,
                      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
                      centerTitle: true,
                      expandedHeight: widget.expandedHeight ?? 0,
                      forceElevated: innerBoxIsScrolled,
                      backgroundColor: themeColor,
                      flexibleSpace: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return widget.flexibleSpaceBar ?? Container();
                        },
                      ),
                      bottom: PreferredSize(
                        preferredSize: _tabBar.preferredSize,
                        child: Material(
                          color: themeColor,
                          //borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          child: _tabBar,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(controller: widget.tabController, children: [for (var items in widget.body) _buidBody(items)]),
            ),
          );
  }

  _buidBody(Widget body) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: widget.onRefresh,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return body;
                      },
                      childCount: 1,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
