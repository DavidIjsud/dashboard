import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/home.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:petshopdashboard/modules/login/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

import 'bootstrapper.dart';

class App extends StatefulWidget {
  App({required this.bootstrapper, Key? key}) : super(key: key);

  final Bootstrapper bootstrapper;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bootstrapper.bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InitializationStatus>(
      initialData: InitializationStatus.initializing,
      stream: widget.bootstrapper.initializationStream,
      builder: (_, snapshot) {
        Widget result;
        //log("Result of bootstraping ${snapshot.data} and loginViewModel is ${widget.bootstrapper.loginViewModel.state?.isLoadingLogin}");
        switch (snapshot.data) {
          case InitializationStatus.initialized:
            result = MultiProvider(
              providers: [
                Provider(create: (_) => widget.bootstrapper.imagesPicker),
                ChangeNotifierProvider<LoginViewModel>(
                  create: (_) => widget.bootstrapper.loginViewModel,
                ),
                ChangeNotifierProvider<HomeViewmodel>(
                  create: (_) => widget.bootstrapper.homeViewmodel,
                ),
              ],
              child: const MaterialApp(home: HomePage()),
            );
            break;
          case InitializationStatus.error:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.initializing:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.unsafeDevice:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.disposed:
            result = const SizedBox.shrink();
            break;
          case null:
            result = const SizedBox.shrink();
        }
        return result;
      },
    );
  }
}
