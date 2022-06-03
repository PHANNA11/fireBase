import 'package:firebase1/main.dart';
import 'package:firebase1/res/firebase_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final _formKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Regiter Account"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: user_email,
              decoration: InputDecoration(
                // hintText: "Email",
                label: const Text('Enter E-mail'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (context) {
                if (context == null || context.isEmpty) {
                  return "Please Input Your E-mail Address";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: user_password,
              decoration: InputDecoration(
                  // hintText: "Email",
                  label: const Text('Enter Password'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
              validator: (context) {
                if (context == null || context.isEmpty) {
                  return "Please Enter your  Password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: CupertinoButton(
                    color: Colors.blue,
                    child: const Text('Create'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          context
                              .read<AuthenticationService>()
                              .Register(user_email.text.trim(),
                                  user_password.text.trim())
                              .whenComplete(() => Navigator.pop(context));
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Pressed button Login'),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
