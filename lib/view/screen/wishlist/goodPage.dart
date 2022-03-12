import 'package:flutter/material.dart';
import 'package:user_app/view/screen/wishlist/good.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();
  final lat = TextEditingController();
  final long = TextEditingController();
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  //MARK:API Call
  callLoginApi() {
    final service = ApiServices();

    service.apiCallLogin(
      {
        "f_name": firstName.text,
        "l_name": lastName.text,
        "email": emailText.text,
        "phone": phoneNo.text,
        "lt": lat.text,
        "lg": long.text,
        "password": passwordText.text,
      },
    ).then((value) {
      if (value.error != null) {
        print("get data >>>>>> " + value.error);
      } else {
        print(value.token);
        //push
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: firstName,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            controller: lastName,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            controller: phoneNo,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            controller: lat,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            controller: long,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            controller: emailText,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Email/Phone',
              hintText: 'Enter Your Register Email',
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordText,
            decoration: InputDecoration(
              labelText: 'password',
              hintText: 'Enter Your Password',
            ),
          ),
          TextButton(
            onPressed: () {
              callLoginApi();
            },
            child: Text(
              'Submit',
            ),
          ),
        ],
      ),
    );
  }
}
