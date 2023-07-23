import 'package:flutter/material.dart';
import 'package:mvvm/utils/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  // Text('Login'),
                  TextFormField(
                    focusNode: emailFocusNode,
                    validator: (value) {
                      // contains = [];
                      if (value!.contains('@')) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      helperText: 'emailId@email.com',
                    ),
                    onFieldSubmitted: (value) {
                      Utils.changeFieldFocus(
                          context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _obscurePassword,
                    builder: (BuildContext context, value, child) {
                      return TextFormField(
                        focusNode: passwordFocusNode,
                        keyboardType: TextInputType.text,
                        obscureText: value,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value!.length < 6) {
                            Utils.flushBarErrorMessage(
                                'Please enter min 6 digit password',
                                context,
                                Colors.red);
                            return 'Password should be min 6 ';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.lock_open_outlined),
                          hintText: 'Your Password',
                          helperText: 'Password@123',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _obscurePassword.value = !_obscurePassword.value;
                            },
                            child: _obscurePassword.value
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.remove_red_eye_rounded),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          // Utils.changeFieldFocus(context, emailFocusNode, nextFocus)
                        },
                      );
                    },
                  ),
                ]),
              ),
              // ButtonBar(),
              // provider.Loading
              //     ? const CircularProgressIndicator()
              //     :
              RoundButton(
                isLoading: authViewModel.loading,
                onTap: () {
                  if (emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter email', context, Colors.red);
                  } else if (passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter password', context, Colors.red);
                  } else if (_formKey.currentState!.validate()) {
                    Map body = {
                      "email": emailController.text.toString(),
                      "password": passwordController.text.toString(),
                    };
                    authViewModel.loginApi(
                        //   loginUrl: 'https://reqres.in/api/login',
                        //   context: context,
                        body,
                        context);
                  } else {
                    return;
                  }
                },
                text: 'Login',
                height: 0.055,
                width: 0.25,
                color: Colors.deepPurpleAccent,
                radius: 15,
                buttonStyle: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.signUp);
                      },
                      child: const Text("SignUp"))
                ],
              )
            ],
          ),
        ));
  }
}
