import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificaciones',
          style: subtitlesStyle!.copyWith(fontSize: 18),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Notificacion 1',
              ),
              leading: Icon(Icons.notifications),
              subtitle: Text('Alla la estan notificando'),
              trailing: Text('20/04/2024'),
              isThreeLine: false,
            ),
            Divider(),
            ListTile(
              title: Text(
                'Notificacion N°2: 20/04/2024',
              ),
              leading: Icon(Icons.notifications),
              subtitle: Text(
                  'Cupidatat quis ullamco dolore proident laboris incididunt do sunt tempor qui duis incididunt laborum aliqua.'),
              trailing: Text('20/04/2024'),
              isThreeLine: false,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
