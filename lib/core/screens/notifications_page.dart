import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> notifications;
  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(child: Text("No new notifications"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(notifications[index]),
              ),
            ),
    );
  }
}
