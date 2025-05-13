import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petshopdashboard/components/widgets/primary_textfield.dart';

import 'package:provider/provider.dart';

import '../viewmodels/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  late final LoginViewModel _loginViewModel;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginViewModel = context.read<LoginViewModel>();
    _loginViewModel.initViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenViewModelLogin();
    });
  }

  void _listenViewModelLogin() {
    _loginViewModel.addListener(() {
      log('Login status: ${_loginViewModel.state?.isLoggedInSucces}');
      if (_loginViewModel.state?.isLoggedInSucces == true) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Iniciar sesión', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              PrimaryTextfield(
                hintText: 'Correo',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              PrimaryTextfield(
                hintText: 'Contraseña',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
