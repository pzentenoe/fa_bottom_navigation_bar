library fa_bottom_navigation_bar;


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fa_bottom_navigation_bar_theme.dart';
import 'fa_bottom_navigation_bar_item.dart';

export 'fa_bottom_navigation_bar_theme.dart';
export 'fa_bottom_navigation_bar_item.dart';

class FaBottomNavigationBar extends StatefulWidget {
  final Function onSelectTab;
  final List<FaBottomNavigationBarItem> items;
  final FaBottomNavigationBarTheme theme;

  final int selectedIndex;

  FaBottomNavigationBar({
    Key key,
    this.selectedIndex = 0,
    @required this.onSelectTab,
    @required this.items,
    @required this.theme,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onSelectTab != null);
  }

  @override
  _FaBottomNavigationBarState createState() =>
      _FaBottomNavigationBarState(selectedIndex: selectedIndex);
}

class _FaBottomNavigationBarState extends State<FaBottomNavigationBar> {
  int selectedIndex;
  _FaBottomNavigationBarState({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final FaBottomNavigationBarTheme theme = widget.theme;
    final bgColor =
        theme.barBackgroundColor ?? Theme.of(context).bottomAppBarColor;

    return MultiProvider(
      providers: [
        Provider<FaBottomNavigationBarTheme>.value(value: theme),
        Provider<int>.value(value: widget.selectedIndex),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: theme.barHeight,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.items.map((item) {
                var index = widget.items.indexOf(item);
                item.setIndex(index);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onSelectTab(index);
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width /
                          widget.items.length,
                      height: theme.barHeight,
                      child: item,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
