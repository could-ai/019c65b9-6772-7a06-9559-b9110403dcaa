import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _eaActive = true;
  double _balance = 15750.45;
  double _equity = 15240.80;
  double _drawdown = 3.2;
  int _activeTrades = 2;
  List<Map<String, dynamic>> _activeTradesList = [
    {'symbol': 'EURUSD', 'type': 'BUY', 'lot': 0.10, 'price': 1.0850, 'profit': 25.50, 'sl': 1.0800, 'tp': 1.0920},
    {'symbol': 'GBPUSD', 'type': 'SELL', 'lot': 0.05, 'price': 1.2650, 'profit': -12.25, 'sl': 1.2700, 'tp': 1.2580},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEaStatusCard(),
            const SizedBox(height: 20),
            _buildAccountOverview(),
            const SizedBox(height: 20),
            _buildActiveTrades(),
            const SizedBox(height: 20),
            _buildQuickActions(),
            const SizedBox(height: 20),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildEaStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Statut du Robot de Trading', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _eaActive ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _eaActive ? 'ACTIF' : 'INACTIF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _eaActive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _eaActive ? 'Trading automatique en cours' : 'Robot arrêté',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Switch(
              value: _eaActive,
              onChanged: (val) {
                setState(() {
                  _eaActive = val;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(val ? 'Robot activé' : 'Robot désactivé')),
                );
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Aperçu du Compte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildAccountMetric('Solde', '€${_balance.toStringAsFixed(2)}', Colors.blue, Icons.account_balance_wallet),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAccountMetric('Equity', '€${_equity.toStringAsFixed(2)}', Colors.green, Icons.trending_up),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildAccountMetric('Drawdown', '${_drawdown.toStringAsFixed(1)}%', Colors.red, Icons.trending_down),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAccountMetric('Trades Actifs', _activeTrades.toString(), Colors.orange, Icons.swap_horiz),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountMetric(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTrades() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Trades Actifs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._activeTradesList.map((trade) => _buildTradeItem(trade)),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeItem(Map<String, dynamic> trade) {
    final isProfit = trade['profit'] > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: trade['type'] == 'BUY' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                trade['type'] == 'BUY' ? Icons.arrow_upward : Icons.arrow_downward,
                color: trade['type'] == 'BUY' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${trade['symbol']} ${trade['type']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Lot: ${trade['lot']} • Prix: ${trade['price']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isProfit ? '+' : ''}€${trade['profit'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isProfit ? Colors.green : Colors.red,
                  ),
                ),
                Text('SL: ${trade['sl']} • TP: ${trade['tp']}', style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Actions Rapides', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop All'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                    label: const Text('Close Profit'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Activité Récente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildActivityItem('BUY EURUSD exécuté', '+€25.50', Colors.green, '10:30'),
            _buildActivityItem('SELL GBPUSD clôturé', '-€12.25', Colors.red, '09:45'),
            _buildActivityItem('Signal Trend Following', 'Confirmé', Colors.blue, '09:15'),
            _buildActivityItem('Niveau de drawdown atteint', '3.2%', Colors.orange, '08:50'),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String value, Color color, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  void _refreshData() {
    // Simulate data refresh
    setState(() {
      _balance += (5 - 10 * (DateTime.now().millisecond % 2));
      _equity = _balance + (_activeTradesList.fold(0.0, (sum, trade) => sum + trade['profit']));
      _drawdown = ((_balance - _equity) / _balance * 100).abs();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Données actualisées')),
    );
  }
}