import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page2/bmi_calculator/bmi_calculator.dart';
import 'package:x01_flutter_basics/pages/Page2/clima/loading_screen.dart';
import 'package:x01_flutter_basics/pages/Page2/quiz/quiz.dart';

import '../../widgets/tabButton.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
                text: "Quiz",
                pageNumber: 0,
                selectedPage: _selectedTab,
                onPressed: () {
                  _changeTab(0);
                },
              ),
              TabButton(
                text: "BMI Calculator",
                pageNumber: 1,
                selectedPage: _selectedTab,
                onPressed: () {
                  _changeTab(1);
                },
              ),
              TabButton(
                text: "Clima",
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
                color: Colors.black,
                child: QuizPage(),
              ),
              Container(
                child: BMICalculatorPage(),
              ),
              Container(
                child: LoadingScreen(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
