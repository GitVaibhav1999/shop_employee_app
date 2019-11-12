import 'package:flutter/material.dart';
import 'package:rashan_app/authentication.dart';

class LoginRegisterPage extends StatefulWidget {


  LoginRegisterPage({
    this.auth,
    this.onSignedIn,

  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }

}

enum FormType {
  login,
  register,
}

class _LoginRegisterState extends State<LoginRegisterPage> {
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

//methods
  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try{
        if(_formType == FormType.login)
        {
          String userId = await widget.auth.signIn(_email, _password);
          print('user id = ' + userId);
        }
        else
        {
          String userId = await widget.auth.signUp(_email, _password);
          print('user id = ' + userId);
        }
        widget.onSignedIn();

      } catch(e){
          print(e);
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return new Container(
        width: 10.0,
        height: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/logo.jpg')),
          //borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.redAccent,
        ),
      );
    }

    List<Widget> createButtons() {
      if (_formType == FormType.login) {
        return [
          RaisedButton(
            child: Text('Login'),
            textColor: Colors.white,
            color: Colors.deepOrange,
            onPressed: () {
              validateAndSubmit();
            },
          ),
          FlatButton(
            child: Text('Register'),
            textColor: Colors.deepOrange,
            onPressed: moveToRegister,
          ),
        ];
      } else {
        return [
          RaisedButton(
            child: Text('Create Account'),
            textColor: Colors.white,
            color: Colors.deepOrange,
            onPressed: () {
              validateAndSubmit();
            },
          ),
          FlatButton(
            child: Text('Login'),
            onPressed: moveToLogin,
          ),
        ];
      }
    }

    List<Widget> createInputs() {
      return [
        SizedBox(
          height: 10,
        ),
        logo(),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              return value.isEmpty ? 'Email required' : null;
            },
            onSaved: (value) {
              return _email = value;
            }),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              return value.isEmpty ? 'Password required' : null;
            },
            onSaved: (value) {
              return _password = value;
            })
      ];
    }

    return new Scaffold(
      appBar: new AppBar(title: Text("Rashan App")),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createInputs() + createButtons(),
              )),
        ),
      ),
    );
  }
}
