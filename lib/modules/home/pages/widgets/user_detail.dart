import 'package:flutter/material.dart';

class UserDetailWidget extends StatelessWidget {
  final String? name;
  final String? lastName;
  final String? email;
  final VoidCallback? onDelete;
  final VoidCallback? onSendNotification;

  const UserDetailWidget({super.key, this.name, this.lastName, this.email, this.onDelete, this.onSendNotification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (name != null)
              Row(
                children: [
                  const Text('Nombre:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(name!),
                ],
              ),
            if (lastName != null)
              Row(
                children: [
                  const Text('Apellido:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(lastName!),
                ],
              ),
            if (email != null)
              Row(
                children: [
                  const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(email!),
                ],
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Eliminar'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onSendNotification,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Enviar notificacion'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
