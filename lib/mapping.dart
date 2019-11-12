import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './LoginRegisterPage.dart';

import './authentication.dart';
import './homepage.dart';

class MappingPage extends StatefulWidget
{
  final AuthImplementation auth;

  MappingPage({
    this.auth 
  });

  State<StatefulWidget> createState()
  {
    return _MappingPageState();
  }
}

enum AuthStatus
{
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage>
{
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState()
  {
    super.initState();
    widget.auth.getCurrentUser().then((FirebaseUserId)
    {
      setState((){
        authStatus = FirebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn()
  {
    setState((){
      authStatus = AuthStatus.notSignedIn;
    });
  }
  
  @override
  Widget build(BuildContext context)
  {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
        return LoginRegisterPage
        (
          auth: widget.auth,
          onSignedIn: _signedIn
        );
        case AuthStatus.signedIn:
        return LoginRegisterPage
        (
          auth: widget.auth,
          //onSignedOut: _signedOut,
        );
    }

    return null;
  }
}