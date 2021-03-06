import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/user_details/delete_user.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/alert.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class EditProfile extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UserProfile userProfile;
  const EditProfile({Key? key, required this.analytics, required this.observer, required this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final UsersService _usersService = UsersService();
  String? fullName;
  String? biography;
  File? image;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController pass = TextEditingController();
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      // TO DO
    }
  }
  bool isPrivate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldPassword.text = "";
    isPrivate = widget.userProfile.isPrivate;

  }
  Widget buildSwitch() => Switch.adaptive(value: isPrivate, onChanged: (value) => setState(() => isPrivate = value));
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null)
      {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appBarDefault(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                         _usersService.disableUser(widget.userProfile.userId);
                        _auth.signOut();
                      },
                      child: const Text("Disable Account")
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeleteUser(analytics: widget.analytics,observer: widget.observer,)
                            )
                        );
                      },
                      child: const Text("Delete User")
                  ),
                  const Icon(Icons.lock_open),

                  buildSwitch(),
                  const Icon(Icons.lock),


                ]
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 100,
                        onPressed: () =>  pickImage(),
                        icon: CircleAvatar(
                            radius: 100,
                            child: ClipOval(
                              child: image != null ? Image.file(
                                image!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ): Image.network(
                                  widget.userProfile.profilepicture,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                              ),
                            )
                        )
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Name Surname ",
                          style: hintStyleLoginButton,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(

                              decoration: InputDecoration(
                                fillColor: AppColors.backgroundColor,
                                filled: true,
                                hintText: widget.userProfile.fullName,
                              ),
                              onSaved: (value) {
                                if (value != null) {
                                  fullName = value;
                                }
                                else{
                                  fullName = widget.userProfile.fullName;
                                }
                              },

                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Text(
                          "Biography",
                          style: hintStyleLoginButton,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(

                              decoration: InputDecoration(
                                fillColor: AppColors.backgroundColor,
                                filled: true,
                                hintText: widget.userProfile.biography,
                              ),

                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  biography = value;
                                }
                                else{
                                  biography = widget.userProfile.biography;
                                }
                              },

                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),

                      Text(
                          "Change Password",
                          style: hintStyleLoginButton,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(

                              decoration: InputDecoration(
                                fillColor: AppColors.backgroundColor,
                                filled: true,
                                hintText: "Old Password",

                              ),
                              controller: oldPassword,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(

                              decoration: InputDecoration(
                                fillColor: AppColors.backgroundColor,
                                filled: true,
                                hintText: "New Password",

                              ),
                              controller: pass,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if(oldPassword.text != "")
                                {
                                  if (value == null) {
                                    return 'Password field cannot be empty';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Password field cannot be empty';
                                    }
                                    if (trimmedValue.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple[200],
                              ),
                              onPressed: () async {
                                bool tryAgain = false;
                                if (oldPassword.text != "")  {
                                  if(_formKey.currentState!.validate()) {
                                    bool isSuccess = await _auth.changePassword(
                                        oldPassword.text, pass.text);
                                    if (!isSuccess) {
                                      tryAgain = true;
                                      showAlertScreen(
                                          context, "Old password is wrong",
                                          "Try again");
                                    }
                                  }
                                }
                                _formKey.currentState!.save();

                                if(biography != null && biography != "") {
                                  await _usersService.setBiography(
                                      biography!, widget.userProfile.userId);
                                }
                                if(fullName !=  null && fullName != "")
                                {
                                  await _usersService.setFullName(
                                      fullName!, widget.userProfile.userId);
                                }
                                _usersService.updatePrivacy(widget.userProfile.userId, isPrivate);
                                if(!tryAgain) {
                                  Navigator.pushNamed(context, '/profile');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0),
                                child: Text(
                                  'Save Changes',
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
              )
            ],
          ),
        )
      );
    }
    return Login(analytics: widget.analytics,observer: widget.observer,);
  }
}
