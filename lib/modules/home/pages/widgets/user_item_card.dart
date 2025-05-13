import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petshopdashboard/components/widgets/modals.dart';
import 'package:petshopdashboard/components/widgets/primary_button.dart';

class UserItemCard extends StatelessWidget {
  final String name;
  final String email;
  const UserItemCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modals.openModal(
          context: context,
          builder: (_) {
            return Center(
              child: Container(
                width: 180,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        width: 160,
                        height: 30,
                        text: 'Eliminar',
                        onTap: () {},
                      ),
                      const SizedBox(height: 5.0),
                      PrimaryButton(
                        width: 160,
                        height: 30,
                        text: 'Mandar notificación',

                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
