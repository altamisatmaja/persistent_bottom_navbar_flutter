part of persistent_bottom_nav_bar;

class _BottomNavStyle3 extends StatelessWidget {
  const _BottomNavStyle3({
    required this.navBarEssentials,
    final Key? key,
    this.navBarDecoration  = const NavBarDecoration(),
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;
  final NavBarDecoration? navBarDecoration;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 100,
              height: height! / 1.0,
              duration: navBarEssentials.itemAnimationProperties.duration,
              curve: navBarEssentials.itemAnimationProperties.curve,
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                alignment: Alignment.center,
                height: height / 1.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: IconTheme(
                        data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary ??
                                    item.activeColorPrimary)
                                : item.inactiveColorPrimary ??
                                    item.activeColorPrimary),
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Material(
                          type: MaterialType.transparency,
                          child: DefaultTextStyle.merge(
                            style: TextStyle(
                                color: item.textStyle != null
                                    ? item.textStyle!.apply(
                                            color: isSelected
                                                ? (item.activeColorSecondary ??
                                                    item.activeColorPrimary)
                                                : item.inactiveColorPrimary)
                                        as Color?
                                    : isSelected
                                        ? (item.activeColorSecondary ??
                                            item.activeColorPrimary)
                                        : item.inactiveColorPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            child: FittedBox(child: Text(item.title!)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );

  Widget _buildMiddleItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(
                  top: navBarEssentials.padding.top,
                  bottom: navBarEssentials.padding.bottom),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: const Offset(0, -23),
                    child: Center(
                      child: Container(
                        width: 150,
                        height: height,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.activeColorPrimary,
                          border:
                              Border.all(color: Colors.transparent, width: 5),
                          boxShadow: navBarDecoration!.boxShadow,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: height,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: IconTheme(
                                      data: IconThemeData(
                                          size: item.iconSize,
                                          color: item.activeColorSecondary ??
                                              item.activeColorPrimary),
                                      child: isSelected
                                          ? item.icon
                                          : item.inactiveIcon ?? item.icon,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (item.title == null)
                    const SizedBox.shrink()
                  else
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        type: MaterialType.transparency,
                        child: FittedBox(
                            child: Text(
                          item.title!,
                          style: item.textStyle != null
                              ? (item.textStyle!.apply(
                                  color: isSelected
                                      ? (item.activeColorSecondary ??
                                          item.activeColorPrimary)
                                      : item.inactiveColorPrimary))
                              : TextStyle(
                                  color: isSelected
                                      ? (item.activeColorPrimary)
                                      : item.inactiveColorPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                        )),
                      ),
                    )
                ],
              ),
            );

  @override
  Widget build(final BuildContext context) {
    final midIndex = (navBarEssentials.items.length / 2).floor();
    final Color selectedItemActiveColor = navBarEssentials
        .items[navBarEssentials.selectedIndex].activeColorPrimary;
    final double itemWidth = (MediaQuery.of(context).size.width -
            ((navBarEssentials.padding.left + navBarEssentials.padding.right) +
                (navBarEssentials.margin.left +
                    navBarEssentials.margin.right))) /
        navBarEssentials.items.length;
    return Container(
      width: double.infinity,
      height: navBarEssentials.navBarHeight,
      padding: navBarEssentials.padding,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: navBarEssentials.itemAnimationProperties.duration,
                curve: navBarEssentials.itemAnimationProperties.curve,
                color: Colors.transparent,
                width: navBarEssentials.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * navBarEssentials.selectedIndex,
                height: 4,
              ),
              Flexible(
                child: AnimatedContainer(
                  duration: navBarEssentials.itemAnimationProperties.duration,
                  curve: navBarEssentials.itemAnimationProperties.curve,
                  width: itemWidth,
                  height: 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedItemActiveColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
                children: navBarEssentials.items.map((final item) {
                  final int index = navBarEssentials.items.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (index != navBarEssentials.selectedIndex) {
                          navBarEssentials.items[index].iconAnimationController
                              ?.forward();
                          navBarEssentials.items[navBarEssentials.selectedIndex]
                              .iconAnimationController
                              ?.reverse();
                        }
                        if (navBarEssentials.items[index].onPressed != null) {
                          navBarEssentials.items[index].onPressed!(
                              navBarEssentials.selectedScreenBuildContext);
                        } else {
                          navBarEssentials.onItemSelected?.call(index);
                        }
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: _buildMiddleItem(
                              navBarEssentials.items[midIndex],
                              navBarEssentials.selectedIndex == midIndex,
                              navBarEssentials.navBarHeight)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
