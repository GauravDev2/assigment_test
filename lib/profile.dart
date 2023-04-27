import 'package:assigment_test/utility/prefrences.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {

  String email = '';
  String password = '';
  Preferences pref = Preferences();
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData()async{
    email = await pref.getEmail();
    password = await pref.getPassword();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

            children:[
              Text('Email :  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('$email',style: TextStyle(fontSize: 20))
            ]
          ),
          SizedBox(height: 10,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text('Password :  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('$password',style: TextStyle(fontSize: 20))
              ]
          )
        ]
      ),
    );

  }
}
