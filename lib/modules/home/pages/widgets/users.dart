import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/user_item_card.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.getAllUsers();
    return Consumer<HomeViewmodel>(
      builder: (_, homeViewModel, Widget? w) {
        return homeViewmodel.state?.isLoadingUsers == true
            ? Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Usuarios',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar usuario.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: GridView.builder(
                      itemCount: homeViewModel.state?.users.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        childAspectRatio: 2.3,
                      ),
                      itemBuilder: (_, index) {
                        final user = homeViewModel.state?.users[index];
                        return UserItemCard(name: user?.name ?? '', email: user?.email ?? '');
                      },
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
