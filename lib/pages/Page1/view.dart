import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page1/dices/dices.dart';
import 'package:x01_flutter_basics/pages/Page1/my_card/my_card.dart';
import 'package:x01_flutter_basics/pages/Page1/xylophone/xylophone.dart';

import '../../widgets/tabButton.dart';

//[tabs]
class Page1 extends StatefulWidget {
  Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int _selectedTab = 0;
  PageController? _tabController;

  void _changeTab(int pageNum) {
    setState(() {
      _selectedTab = pageNum;
      _tabController?.animateToPage(
        pageNum,
        duration: const Duration(microseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _tabController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //[customTabButton]
                TabButton(
                  text: "MyCard Tab",
                  pageNumber: 0,
                  selectedPage: _selectedTab,
                  onPressed: () {
                    _changeTab(0);
                  },
                ),
                TabButton(
                  text: "Dices Tab",
                  pageNumber: 1,
                  selectedPage: _selectedTab,
                  onPressed: () {
                    _changeTab(1);
                  },
                ),
                TabButton(
                  text: "Xylophone Tab",
                  pageNumber: 2,
                  selectedPage: _selectedTab,
                  onPressed: () {
                    _changeTab(2);
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int tab) {
                setState(() {
                  //to set selectedTab
                  _selectedTab = tab;
                });
              },
              controller: _tabController,
              children: [
                Container(
                  color: Colors.yellow,
                  child: const MyCard(),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Dices(),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: const Center(
                    child: Xilophone(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
