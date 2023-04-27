import 'package:assigment_test/home_screen/home_page.dart';
import 'package:assigment_test/utility/common_widget.dart';
import 'package:assigment_test/utility/prefrences.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Preferences preferences = Preferences();

bool isLogged = false;
Preferences pref = Preferences();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


 Future<void> validateData(BuildContext context)async{
  String email = await pref.getEmail();
  String password = await pref.getPassword();
  if(emailController.text == email && passwordController.text == password){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
  }else{
    ToastMessage.showToastMessage('Kindly register email Id');
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }
}

final formGlobalKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
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

                ),
                TextFormField(
                  validator: (password) {
                    if (isPasswordValid(password ?? '')) return null;
                    else
                      return 'Enter a valid password';
                  },
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: ()async {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        // use the email provided here
                        if(emailController.text != '' && passwordController.text != '') {
                          validateData(context);
                        }
                      }else{
                        ToastMessage.showToastMessage('Kindly Fill Data',);
                      }
                    },
                    child: Text('Login')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
