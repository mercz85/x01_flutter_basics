import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/models/task_data.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/tasks_screen.dart';

import '../../widgets/tabButton.dart';

class Page4 extends StatefulWidget {
  Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
                text: 'TO DO Provider',
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
              //TO DO Tab
              Container(
                //[provider] ChangeNotifierProvider at the top parent that shares the object TaskData between children
                child: ChangeNotifierProvider(
                  create: (BuildContext context) => TaskData(),
                  child: TasksScreen(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
