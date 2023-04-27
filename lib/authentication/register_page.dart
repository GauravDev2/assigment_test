import 'package:assigment_test/authentication/Login_page.dart';
import 'package:assigment_test/home_screen/home_page.dart';
import 'package:assigment_test/utility/common_widget.dart';
import 'package:assigment_test/utility/prefrences.dart';
import 'package:flutter/material.dart';



class RegisterScreen extends StatefulWidget{
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

var email;
var password;
Preferences preferences = Preferences();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final formGlobalKey = GlobalKey<FormState>();

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }
}

class _RegisterScreenState extends State<RegisterScreen> with InputValidationMixin{


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('Register Screen', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
      ),
      body:
      Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (email) {
                    if (isEmailValid(email ?? '')) return null;
                    else
                      return 'Enter a valid email address';
                  },
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (val)async {
                    setState(() {
                      email = val;
                    });

                  },
                ),
                TextFormField(
                  validator: (password) {
                    if (isPasswordValid(password ?? '')) return null;
                    else
                      return 'Enter a valid password';
                  },
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (val) async{
                    setState(() {
                      password = val;
                    });
                    await preferences.setPassword(val);

                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async{
                      registerWithEmailAndPassword();
                      },
                    child: Text('Register')),

                SizedBox(height: 10,),
                InkWell(
                  child: Text('For Login click here',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.blue,
                            offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration:
                      TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 4,

                    ),),
                  onTap: ()async{
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future registerWithEmailAndPassword()async {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      // use the email provided here
      if(emailController.text != '' && passwordController.text != '') {
        await preferences.setEmail(email);
        await preferences.setPassword(password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    }else{
      ToastMessage.showToastMessage('Kindly Fill Data',);
    }
  }
}
