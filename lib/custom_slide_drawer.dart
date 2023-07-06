import 'package:flutter/material.dart';

class CustomSlideDrawer extends StatelessWidget {
  const CustomSlideDrawer({
    super.key,
    required this.children,
    required this.titles,
    this.sizeWidth = 220,
    required this.indexPage,
    required this.changePage,
    required this.stateDrawer,
    required this.openDrawer,
    this.colorSelected,
  });

  final List<Widget> children;
  final List<String> titles;
  final double? sizeWidth;
  final int indexPage;
  final Function(int index) changePage;
  final bool stateDrawer;
  final Function(bool value) openDrawer;
  final Color? colorSelected;

  List<Widget> get childrenReverse => children.reversed.toList();
  final Duration duration = const Duration(milliseconds: 600);
  Widget get child => children[indexPage];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: sizeWidth,
          height: size.height,
          child: ListView.builder(
            itemCount: titles.length,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15 + 30 + 20,
              bottom: 20,
              right: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  changePage(index);
                  openDrawer(!stateDrawer);
                },
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(7),
                ),
                child: SizedBox(
                  height: 60,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      AnimatedContainer(
                        width: index == indexPage ? sizeWidth : 0,
                        height: double.infinity,
                        duration: duration,
                        decoration: BoxDecoration(
                          color: colorSelected ?? Colors.amberAccent[200],
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          titles[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Stack(
          clipBehavior: Clip.antiAlias,
          children: List.generate(
            childrenReverse.length,
            (index) {
              final width = size.width;
              final height = size.height;

              final spaceWidth = (index) * -(width * 0.05);
              final spaceHeight = (index) * (height * 0.03);

              return AnimatedContainer(
                width: width,
                height: height,
                duration: duration,
                transform: Matrix4.translationValues(
                  stateDrawer ? sizeWidth! - spaceWidth : 0,
                  stateDrawer ? (height * 0.3) - spaceHeight : 0,
                  0,
                )..scale(stateDrawer ? 0.5 : 1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(stateDrawer ? 30 : 0),
                ),
                clipBehavior: Clip.antiAlias,
                child: stateDrawer
                    ? childrenReverse[index]
                    : index == (children.length - 1)
                        ? childrenReverse[(children.length - 1) - indexPage]
                        : childrenReverse[index],
              );
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 15,
          left: 15,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            switchInCurve: Curves.decelerate,
            child: stateDrawer
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      openDrawer(!stateDrawer);
                    },
                    icon: const Icon(
                      Icons.menu,
                    ),
                  ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 15,
          left: sizeWidth! + 15,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            switchInCurve: Curves.decelerate,
            child: stateDrawer
                ? IconButton(
                    onPressed: () {
                      openDrawer(!stateDrawer);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
