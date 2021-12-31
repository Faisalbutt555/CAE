import 'package:cae/Constants/Constants.dart';
import 'package:cae/Constants/Styles.dart';
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Screens/AddCompetation.dart';
import 'package:cae/Screens/compare_at.dart';
import 'package:cae/Screens/competation_types.dart';
import 'package:cae/Screens/own_and_other_competation.dart';
import 'package:cae/Screens/profile_screen.dart';
import 'package:cae/Screens/select_sompetation_type.dart';
import 'package:cae/Screens/select_competation_type.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    // Future.delayed(Duration(milliseconds: 100),(){
    //   var formProvider = Provider.of<FormProvider>(context, listen: false);
    //   _pageController = PageController(initialPage: formProvider.selectedIndex);
    // });
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  changePage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    var appConstants = Provider.of<AppConstants>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGoundColor,
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: appConstants.selectedIndexDashBoard,
        showElevation: true,
        backgroundColor: backGoundColor,
        onItemSelected: (index) {
          appConstants.updatedSelectedIndexDashBoard(index);
          //  appConstants.changeBootmNavIndex(0);
          changePage(appConstants.selectedIndexDashBoard);
        },
        items: [
          FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: primaryColor,
              inactiveColor: greyColor),
          FlashyTabBarItem(
              icon: const Icon(Icons.add),
              title: const Text('Add Comp'),
              activeColor: primaryColor,
              inactiveColor: greyColor),
          FlashyTabBarItem(
              icon: const Icon(Icons.card_giftcard),
              title: const Text('Competitions'),
              activeColor: primaryColor,
              inactiveColor: greyColor),
          FlashyTabBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: primaryColor,
              inactiveColor: greyColor),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          const CompateAt(),
          const CompetitionTypes(), //add competition class
          // const OwnAndOtherCompetations(),
          const OwnAndOtherCompetations(),
          // const AddCompetator(),
          const ProfileScreen(),
          Container(),
        ],
      ),
    );
  }
}
