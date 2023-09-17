import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  CustomBottomAppBar({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xffFFFAEB),
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    onTabSelected(0);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: selectedIndex == 0 ? mainColor : Colors.grey,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: selectedIndex == 0 ? mainColor : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    onTabSelected(1);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        color: selectedIndex == 1 ? mainColor : Colors.grey,
                      ),
                      Text(
                        "Message",
                        style: TextStyle(
                          color: selectedIndex == 1 ? mainColor : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    onTabSelected(2);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: selectedIndex == 2 ? mainColor : Colors.grey,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: selectedIndex == 2 ? mainColor : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    onTabSelected(3);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.more_horiz,
                        color: selectedIndex == 3 ? mainColor : Colors.grey,
                      ),
                      Text(
                        "More",
                        style: TextStyle(
                          color: selectedIndex == 3 ? mainColor : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
