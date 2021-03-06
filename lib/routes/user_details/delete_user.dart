import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/analytics.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';



class DeleteUser extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const DeleteUser({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass ="";
  Future<void> loginFailed(String title, String message) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text("OK")),
            ],
          );
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Delete Page', 'delete_user.dart');
    setLogEvent(widget.analytics, "delete_user");
  }
  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 24, 0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png',

                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Log-in to delete account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,

                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(

                                  decoration: InputDecoration(
                                    fillColor: AppColors.backgroundColor,
                                    filled: true,
                                    hintText: 'E-mail',
                                    border: const UnderlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,

                                  validator: (value) {
                                    if (value == null) {
                                      return 'E-mail Field Cannot be Empty';
                                    }
                                    else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return 'E-mail field cannot be empty';
                                      }
                                      if (!EmailValidator.validate(
                                          trimmedValue)) {
                                        return 'Please enter a valid email';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    if (value != null) {
                                      mail = value;
                                    }
                                  },

                                ),
                              ),
                            ],

                          ),
                          const SizedBox(height: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: AppColors.backgroundColor,
                                    filled: true,
                                    hintText: 'Password',
                                    border: const UnderlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Password Field Cannot be Empty';
                                    }
                                    else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return 'Password Field Cannot be Empty';
                                      }
                                      if (trimmedValue.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    if (value != null) {
                                      pass = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple[200],
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      auth.deleteUser(user!, mail, pass);
                                      loginFailed("User deleted successfully", "Please log in to new account...");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      'Log-In',
                                      style: hintStyleLoginButton,
                                    ),
                                  ),
                                ),
                              ),
                            ],

                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: AppColors.backgroundColor,
                          ),
                          onPressed: () {
                            // to do sign in with facebook
                          },
                          child: Padding(
                            padding: Dimen.symmetricSignupInsets,
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.transparentpng.com/thumb/facebook-logo-png/facebook-logo-clipart-hd-10.png'
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: AppColors.backgroundColor,
                          ),
                          onPressed: () {
                            auth.signInWithGoogle();
                          },
                          child: Padding(
                            padding: Dimen.symmetricSignupInsets,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-dwglogo-19.png'
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        )
    );

  }
}
