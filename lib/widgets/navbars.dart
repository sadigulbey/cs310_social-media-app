
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/messaging/all_messages.dart';
import 'package:sucial_cs310_project/routes/messaging/new_message.dart';
import 'package:sucial_cs310_project/routes/posting/add_post.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';



AppBar appBarDefault(BuildContext context){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        icon: const Icon(Icons.add),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => AllMessages())),
          icon: const Icon(Icons.send)
      )
    ],
    title: Text(
      'Sucial',
      style: sucialStylemMed,
    ),
    centerTitle: true,
    backgroundColor: AppColors.moreDarkerBackground,
  );
}
AppBar appBarSignOut(BuildContext context){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        icon: const Icon(Icons.add),
      ),
    ),
    actions: [
      IconButton(
          onPressed: (){
            AuthService _auth = AuthService();
            _auth.signOut();
            Navigator.pushNamed(context, '/login');
          },
          icon: const Icon(Icons.logout)
      )
    ],
    title: Text(
      'Sucial',
      style: sucialStylemMed,
    ),
    centerTitle: true,
    backgroundColor: AppColors.moreDarkerBackground,
  );
}
AppBar appBarBack(BuildContext context, String appBarTitle){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    ),
    title: Text(
      appBarTitle,
      style: sucialStylemMed,
    ),
    centerTitle: true,
    backgroundColor: AppColors.moreDarkerBackground,
  );
}
AppBar appBarNewMessage(BuildContext context){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    ),
    title: Text(
      "Messages",
      style: sucialStylemMed,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: ()
            => Navigator.push(context,
              MaterialPageRoute(builder:
              (context) => NewMessage()
              )
            ),
            icon: const Icon(Icons.add)),
      )
    ],
    centerTitle: true,
    backgroundColor: AppColors.moreDarkerBackground,
  );
}

BottomNavigationBar bottomNavBar(BuildContext context)
{
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: IconButton(

                onPressed: (){
                  Navigator.pushNamed(context, '/feed');
                },
                icon: const Icon(Icons.home),
            ),
          label: '',

        ),
        BottomNavigationBarItem(
          icon: IconButton(

            onPressed: (){
              Navigator.pushNamed(context, '/search_page');
            },
            icon: const Icon(Icons.search),
          ),
          label: '',

        ),

        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/topics');
            },
            icon: const Icon(Icons.tag),
          ),
          label: '',

        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Icon(Icons.notifications),
          ),
          label: '',

        ),


        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
            ),
          label: '',
        ),
    ]
  );
}