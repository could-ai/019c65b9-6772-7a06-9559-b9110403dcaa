import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  String _selectedFilter = 'Tous';
  final List<Map<String, dynamic>> _logs = [
    {'type': 'Execution', 'message': 'Ordre BUY EURUSD exécuté - Lot: 0.10', 'timestamp': '2023-10-15 10:30:45', 'level': 'Info'},
    {'type': 'Erreur', 'message': 'Échec de connexion au broker - Timeout', 'timestamp': '2023-10-15 10:25:12', 'level': 'Error'},
    {'type': 'IA', 'message': 'Décision IA: Signal Trend Following confirmé', 'timestamp': '2023-10-15 10:20:33', 'level': 'Info'},
    {'type': 'Execution', 'message': 'Ordre SELL GBPUSD clôturé - Profit: +25.50', 'timestamp': '2023-10-15 09:45:22', 'level': 'Info'},
    {'type': 'Erreur', 'message': 'Slippage dépassé limite configurée', 'timestamp': '2023-10-15 09:30:15', 'level': 'Warning'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journalisation'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Tous', child: Text('Tous')),
              const PopupMenuItem(value: 'Execution', child: Text('Exécutions')),
              const PopupMenuItem(value: 'Erreur', child: Text('Erreurs')),
              const PopupMenuItem(value: 'IA', child: Text('Décisions IA')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Filtre: $_selectedFilter',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _logs.where((log) => _selectedFilter == 'Tous' || log['type'] == _selectedFilter).length,
              itemBuilder: (context, index) {
                final filteredLogs = _logs.where((log) => _selectedFilter == 'Tous' || log['type'] == _selectedFilter).toList();
                final log = filteredLogs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Icon(
                      log['type'] == 'Execution' ? Icons.play_arrow :
                      log['type'] == 'Erreur' ? Icons.error :
                      Icons.psychology,
                      color: log['level'] == 'Error' ? Colors.red :
                             log['level'] == 'Warning' ? Colors.orange : Colors.green,
                    ),
                    title: Text(log['message']),
                    subtitle: Text('${log['timestamp']} • ${log['level']}'),
                    trailing: Text(log['type']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _logs.insert(0, {
              'type': 'Execution',
              'message': 'Test log ajouté manuellement',
              'timestamp': DateTime.now().toString(),
              'level': 'Info',
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}