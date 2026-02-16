import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rapports & Performance')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPerformanceOverview(),
            const SizedBox(height: 24),
            _buildMonthlyReports(),
            const SizedBox(height: 24),
            _buildDetailedMetrics(),
            const SizedBox(height: 24),
            _buildExportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aperçu Performance Globale',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Profit Total', '+€2,450.75', Colors.green, Icons.trending_up),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard('Trades Totaux', '1,247', Colors.blue, Icons.swap_horiz),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Win Rate', '68.5%', Colors.orange, Icons.pie_chart),
                ),
                const SizedBox(width: 16),
                  Expanded(
                  child: _buildMetricCard('Profit Factor', '1.85', Colors.purple, Icons.calculate),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Sharpe Ratio', '1.42', Colors.teal, Icons.show_chart),
                ),
                const SizedBox(width: 16),
                  Expanded(
                  child: _buildMetricCard('Max Drawdown', '8.2%', Colors.red, Icons.trending_down),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyReports() {
    final months = ['Octobre 2023', 'Septembre 2023', 'Août 2023'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rapports Mensuels',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...months.map((month) => ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(month),
              subtitle: const Text('Profit: +€850.25 • Win Rate: 71%'),
              trailing: const Icon(Icons.download),
              onTap: () {},
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Métriques Détaillées',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMetricRow('Ratio Risque/Récompense Moyen', '1:2.3'),
            _buildMetricRow('Temps Moyen en Position', '4h 32min'),
            _buildMetricRow('Trades par Jour', '12.4'),
            _buildMetricRow('Meilleure Série de Victoires', '18 trades'),
            _buildMetricRow('Plus Grande Perte', '-€125.00'),
            _buildMetricRow('Plus Grand Gain', '+€450.75'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Export & Partage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Exporter CSV'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Partager PDF'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}