import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de Bord')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 20),
            const Text(
              'Performance du Jour',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Profit', '+\$124.50', Colors.green)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard(context, 'Trades', '12', Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Win Rate', '68%', Colors.orange)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard(context, 'Drawdown', '2.1%', Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Dernières Activités',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Statut du Robot', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ACTIF',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
            Switch(value: true, onChanged: (val) {}, activeColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (ctx, i) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final isBuy = i % 2 == 0;
          return ListTile(
            leading: Icon(
              isBuy ? Icons.arrow_upward : Icons.arrow_downward,
              color: isBuy ? Colors.green : Colors.red,
            ),
            title: Text(isBuy ? 'BUY EURUSD' : 'SELL GBPUSD'),
            subtitle: Text('Lot: 0.10 • ${DateTime.now().subtract(Duration(minutes: i * 15)).toString().substring(11, 16)}'),
            trailing: Text(
              isBuy ? '+\$12.50' : '-\$4.20',
              style: TextStyle(
                color: isBuy ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
