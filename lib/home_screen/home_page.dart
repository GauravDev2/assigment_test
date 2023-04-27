import 'package:assigment_test/Model/student_response_model.dart';
import 'package:assigment_test/converter_screen/converter_screen.dart';
import 'package:assigment_test/friend_screen/friend_app_screen.dart';
import 'package:assigment_test/profile.dart';
import 'package:assigment_test/student_screen/student_bloc.dart';
import 'package:assigment_test/utility/common_widget.dart';
import 'package:flutter/material.dart';

import '../student_screen/student_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  int _pageIndex = 0;
List<Widget> _widgetOptions = [
  HomePage(),
  FriendScreen(),
    ProfileScreen()
     ];


  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      this._pageIndex = index;
    });
    // this._pageController!.jumpToPage(index);
  }
  TabController? _tabController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _tabController = TabController(length: 2,vsync: this);
    _tabController?.addListener(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap:_onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_sharp,color: Colors.black,),
              label: 'Add Friends',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black,),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          iconSize: 40,
          elevation: 5
      ),
      // Scaffold(
      //   key: scaffoldKey,
      //   body: _widgetOptions[_pageIndex],
      //
      // ),
      body: _widgetOptions[_pageIndex],
    );
  }
}



