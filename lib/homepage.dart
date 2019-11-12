import 'package:flutter/material.dart';


import './authentication.dart';
import './mapping.dart';

class HomePage extends StatefulWidget {
 // void _logoutUser() {}

  HomePage
  ({
    this.auth,
    this.onSignedOut,
   // this.onSignedIn,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  void _logoutUser() async{
    try
    {
       await widget.auth.signOut();
       widget.onSignedOut();
    }
   
    catch(e)
    {
      print(e.toString());
    }
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Rashan App")),
        body: Container(
          child: Text('This is home page'),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepOrange,
          child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: _logoutUser,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {},
                  )
                ],
              )),
        ));
  }
}
