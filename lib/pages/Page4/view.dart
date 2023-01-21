import 'package:flutter/material.dart';

import '../../widgets/TabButton.dart';

class Page4 extends StatefulWidget {
  Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page3State();
}

class _Page3State extends State<Page4> {
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
                text: 'Login BLoC',
                pageNumber: 0,
                selectedPage: _selectedTab,
                onPressed: () {
                  _changeTab(0);
                },
              ),
              // TabButton(
              //   text: "Tab2",
              //   pageNumber: 1,
              //   selectedPage: _selectedTab,
              //   onPressed: () {
              //     _changeTab(1);
              //   },
              // ),
              // TabButton(
              //   text: "Tab3",
              //   pageNumber: 2,
              //   selectedPage: _selectedTab,
              //   onPressed: () {
              //     _changeTab(2);
              //   },
              // ),
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
                child: BlankScreen(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BlankScreen extends StatelessWidget {
  BlankScreen({Key? key}) : super(key: key);

  static const String id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Center(
              child: Text(
                'EVA',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
