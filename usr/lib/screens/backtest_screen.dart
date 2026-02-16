import 'package:flutter/material.dart';

class BacktestScreen extends StatefulWidget {
  const BacktestScreen({super.key});

  @override
  State<BacktestScreen> createState() => _BacktestScreenState();
}

class _BacktestScreenState extends State<BacktestScreen> {
  String _selectedAsset = 'EURUSD';
  String _selectedTimeframe = 'H1';
  DateTime _startDate = DateTime(2023, 1, 1);
  DateTime _endDate = DateTime(2023, 12, 31);
  bool _tickByTick = true;
  bool _walkForwardAnalysis = false;
  bool _monteCarlo = false;
  bool _isRunning = false;
  Map<String, dynamic>? _results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backtesting & Optimisation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConfigCard(),
            const SizedBox(height: 20),
            _buildOptimizationOptions(),
            const SizedBox(height: 20),
            if (_results != null) _buildResultsCard() else _buildPlaceholder(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isRunning ? null : _runBacktest,
                icon: _isRunning ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.play_arrow),
                label: Text(_isRunning ? 'BACKTEST EN COURS...' : 'LANCER LE BACKTEST'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedAsset,
                    decoration: const InputDecoration(labelText: 'Paire/Actif'),
                    items: ['EURUSD', 'GBPUSD', 'XAUUSD', 'US30', 'BTCUSD'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (val) => setState(() => _selectedAsset = val!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedTimeframe,
                    decoration: const InputDecoration(labelText: 'Timeframe'),
                    items: ['M15', 'H1', 'H4', 'D1', 'W1'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (val) => setState(() => _selectedTimeframe = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}',
                    decoration: const InputDecoration(
                      labelText: 'Date Début',
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) setState(() => _startDate = date);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: '${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}',
                    decoration: const InputDecoration(
                      labelText: 'Date Fin',
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) setState(() => _endDate = date);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizationOptions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Options d\'Optimisation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Tick by Tick'),
              subtitle: const Text('Backtest haute précision'),
              value: _tickByTick,
              onChanged: (val) => setState(() => _tickByTick = val),
            ),
            SwitchListTile(
              title: const Text('Walk Forward Analysis'),
              subtitle: const Text('Validation hors-échantillon'),
              value: _walkForwardAnalysis,
              onChanged: (val) => setState(() => _walkForwardAnalysis = val),
            ),
            SwitchListTile(
              title: const Text('Monte Carlo Simulation'),
              subtitle: const Text('Test de robustesse'),
              value: _monteCarlo,
              onChanged: (val) => setState(() => _monteCarlo = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Expanded(
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Aucun résultat de backtest',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Configurez les paramètres et lancez le test pour voir les performances.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Résultats du Backtest', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildResultMetric('Profit Net', '+€1,247.85', Colors.green)),
                  Expanded(child: _buildResultMetric('Trades Total', '247', Colors.blue)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildResultMetric('Win Rate', '68.4%', Colors.orange)),
                  Expanded(child: _buildResultMetric('Profit Factor', '1.87', Colors.purple)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildResultMetric('Max Drawdown', '12.3%', Colors.red)),
                  Expanded(child: _buildResultMetric('Sharpe Ratio', '1.45', Colors.teal)),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Graphique des Profits', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Graphique simulé - Profits cumulés', style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Exporter'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      label: const Text('Partager'),
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

  Widget _buildResultMetric(String label, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  void _runBacktest() {
    setState(() {
      _isRunning = true;
    });

    // Simulate backtest running
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isRunning = false;
        _results = {
          'profit': 1247.85,
          'trades': 247,
          'winRate': 68.4,
          'profitFactor': 1.87,
          'maxDrawdown': 12.3,
          'sharpeRatio': 1.45,
        };
      });
    });
  }
}