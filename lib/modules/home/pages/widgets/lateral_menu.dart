import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.topRight, child: IconButton(onPressed: () {}, icon: Icon(Icons.close))),
          ListTile(
            title: Text('Products', textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
            onTap: () {
              // Navigate to products page
              context.read<HomeViewmodel>().setCurrentPage(HomeViewPages.products);
            },
          ),
          ListTile(
            title: Text('Orders', style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            onTap: () {
              // Navigate to orders page
              context.read<HomeViewmodel>().setCurrentPage(HomeViewPages.orders);
            },
          ),
          ListTile(
            title: Text('Users', style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            onTap: () {
              // Navigate to users page
              context.read<HomeViewmodel>().setCurrentPage(HomeViewPages.users);
            },
          ),
        ],
      ),
    );
  }
}
