import 'package:flutter/material.dart';
import 'package:flutterproject/ui/auth/phone%20auth/change_password.dart';
import 'package:flutterproject/ui/auth/phone auth/login_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}
Widget buildHeader(BuildContext context) =>

    Material(
      color: Colors.blue.shade700,
      child: Container(
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Syed Arsalan",
              style: TextStyle(fontSize: 28, color: Colors.white70),
            ),
            Text(
              "Phone Number",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),

          ],
        ),
      ),
    );

Widget buildMenuItems(BuildContext context) =>
    Column(
      children:[
        ListTile(
          leading: const Icon(Icons.verified_user),
          title: const Text('Profile'),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title:  Text('Phone Number'),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.password),
          title:  Text('Change Password'),
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
            =>  ChangePassword()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title:  const Text('Logout'),
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen()));
          },
        ),
      ],
    );
