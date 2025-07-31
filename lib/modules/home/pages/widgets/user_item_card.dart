import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/user_detail.dart';

class UserItemCard extends StatelessWidget {
  final String? name;
  final String? lastName;
  final String? email;
  const UserItemCard({super.key, this.name, this.lastName, this.email});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => Dialog(
                child: SizedBox(
                  width: 400,
                  child: UserDetailWidget(
                    name: name,
                    lastName: lastName,
                    email: email,
                    onDelete: () {
                      // TODO: Implement delete logic
                      Navigator.of(context).pop();
                    },
                    onSendNotification: () {
                      // TODO: Implement send notification logic
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (name != null || lastName != null)
                          Text(
                            '${name ?? ''}${lastName != null ? ' $lastName' : ''}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (email != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            email!,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
