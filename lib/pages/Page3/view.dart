import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page3/coin_ticker/price_screen.dart';
import 'package:x01_flutter_basics/widgets/TabButton.dart';

class Page3 extends StatefulWidget {
  Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int _selectedTab = 0;
  PageController? _tabController;

  void _changeTab(int pageNum) {
    setState(() {
      _selectedTab = pageNum;
      _tabController?.animateToPage(
        pageNum,
        duration: Duration(microseconds: 500),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabButton(
                text: "Coin Ticker",
                pageNumber: 0,
                selectedPage: _selectedTab,
                onPressed: () {
                  _changeTab(0);
                },
              ),
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
                color: Colors.white,
                child: PriceScreen(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
