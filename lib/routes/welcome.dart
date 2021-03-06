import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/signup.dart';
import 'package:sucial_cs310_project/services/analytics.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';


class Welcome extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const Welcome({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Init Welcome Page', 'welcome.dart');
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,

        body:
        Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              children: <Widget>[

                Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Text(
                        "Welcome to ",
                        style: gettingStartedStyleBold,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Sucial",
                        style: sucialStyleBig,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                        children: <Widget>[

                          Container(


                            width: size.width*0.6,
                            child: ClipOval(

                              //padding: EdgeInsets.symmetric(vertical: 20,horizontal:20),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20,horizontal:40),
                                child: TextButton(

                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[200],
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Login(analytics: widget.analytics,observer: widget.observer)));
                                    },
                                    child: const Text("LOGIN",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),)),
                              ),
                            ),

                          ),

                        ],

                      ),

                      Column(

                        children: <Widget>[

                          Container(

                            width: size.width*0.6,
                            child: ClipOval(


                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[200],
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Signup(analytics: widget.analytics,observer: widget.observer)));
                                    },
                                    child: const Text("SIGN UP",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),)),
                              ),
                            ),

                          ),

                        ],

                      ),

                    ]



                ),
              ],
            )
        )
    );
  }
}

