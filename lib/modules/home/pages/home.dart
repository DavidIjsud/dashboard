import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/lateral_menu.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/orders.dart' show OrdersWidget;
import 'package:petshopdashboard/modules/home/pages/widgets/products.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/users.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LateralMenu(),
          Expanded(
            child: Consumer<HomeViewmodel>(
              builder: (_, homeViewModel, w) {
                return switch (homeViewModel.state?.currentPage) {
                  HomeViewPages.users => const UsersWidget(),
                  HomeViewPages.orders => const OrdersWidget(),
                  HomeViewPages.products => const ProductsWidget(),
                  _ => const Center(child: Text('Page not found')),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
