import 'package:flutter/material.dart';

class StrategiesScreen extends StatefulWidget {
  const StrategiesScreen({super.key});

  @override
  State<StrategiesScreen> createState() => _StrategiesScreenState();
}

class _StrategiesScreenState extends State<StrategiesScreen> {
  double _riskPercentage = 2.0;
  bool _trailingStop = true;
  bool _newsFilter = true;
  String _selectedStrategy = 'Scalping Aggressif';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration Stratégies')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStrategySelector(),
          const SizedBox(height: 20),
          _buildMoneyManagementSection(),
          const SizedBox(height: 20),
          _buildRiskManagementSection(),
          const SizedBox(height: 20),
          _buildNewsFilterSection(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuration sauvegardée avec succès')),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('SAUVEGARDER LA CONFIGURATION'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategySelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stratégie Active', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedStrategy,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.psychology),
              ),
              items: ['Scalping Aggressif', 'Swing Trading', 'Day Trading Safe', 'Gold Specialist']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() => _selectedStrategy = val!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneyManagementSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Money Management', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Risque par Trade (%)'),
                Text('${_riskPercentage.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            Slider(
              value: _riskPercentage,
              min: 0.5,
              max: 10.0,
              divisions: 19,
              label: '${_riskPercentage.toStringAsFixed(1)}%',
              onChanged: (val) => setState(() => _riskPercentage = val),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: '1.5',
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ratio Risque/Récompense (R:R)',
                prefixIcon: Icon(Icons.balance),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskManagementSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestion des Risques', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Trailing Stop'),
              subtitle: const Text('Sécurise les profits automatiquement'),
              value: _trailingStop,
              onChanged: (val) => setState(() => _trailingStop = val),
            ),
            if (_trailingStop)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  initialValue: '20',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Distance (Points)',
                    suffixText: 'pts',
                  ),
                ),
              ),
            const Divider(),
            TextFormField(
              initialValue: '50',
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stop Loss Max (Points)',
                prefixIcon: Icon(Icons.vertical_align_bottom),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsFilterSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filtre Actualités (News Filter)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Activer le Filtre News'),
              subtitle: const Text('Ne pas trader pendant les annonces économiques'),
              value: _newsFilter,
              onChanged: (val) => setState(() => _newsFilter = val),
            ),
            if (_newsFilter) ...[
              const SizedBox(height: 10),
              const Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('High Impact'), backgroundColor: Colors.red, labelStyle: TextStyle(color: Colors.white)),
                  Chip(label: Text('Medium Impact'), backgroundColor: Colors.orange, labelStyle: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: '30',
                decoration: const InputDecoration(
                  labelText: 'Minutes avant/après news',
                  suffixText: 'min',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
