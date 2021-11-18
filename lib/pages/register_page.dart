import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_api/api_manager/user_helper.dart';
import 'package:flutter_todo_api/model/todo_model.dart';
import 'package:flutter_todo_api/pages/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      controller: _name,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: _email,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      controller: _username,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'password',
                      ),
                      obscureText: true,
                      controller: _password,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              submit();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false);
  }

  submit() async {
    final user = User(
        name: _name.text,
        email: _email.text,
        username: _username.text,
        password: _password.text);
    String res = await UserManager().register(user);
    if (res == '1') {
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => HomePage(
            isNew: true,
          ),
        ),
        ModalRoute.withName('/'),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res == 0 ? 'Error occured' : res)),
      );
    }
  }
}
