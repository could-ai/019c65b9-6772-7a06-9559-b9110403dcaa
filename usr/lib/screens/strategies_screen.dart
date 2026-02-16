import 'package:flutter/material.dart';

class StrategiesScreen extends StatefulWidget {
  const StrategiesScreen({super.key});

  @override
  State<StrategiesScreen> createState() => _StrategiesScreenState();
}

class _StrategiesScreenState extends State<StrategiesScreen> {
  // Strategy toggles
  bool _breakoutEnabled = true;
  bool _trendFollowingEnabled = true;
  bool _orderBlockEnabled = false;
  bool _scalpingEnabled = true;
  bool _swingTradingEnabled = false;
  bool _meanReversionEnabled = false;

  // Money Management
  double _riskPercentage = 2.0;
  bool _dynamicLotSize = true;
  double _maxDrawdown = 10.0;
  double _minCapital = 1000.0;

  // Stops & Profits
  double _stopLossATR = 1.5;
  double _takeProfitRatio = 2.0;
  bool _trailingStop = true;
  String _trailingType = 'Classique';

  // News Filter
  bool _newsFilter = true;
  bool _highImpactFilter = true;
  bool _mediumImpactFilter = true;
  int _newsMinutes = 30;

  // Market Sessions
  bool _londonSession = true;
  bool _newYorkSession = true;
  bool _asiaSession = false;
  bool _customHours = false;

  // Order Management
  double _maxSlippage = 5.0;
  double _spreadFilter = 2.0;
  bool _liquidityCheck = true;
  bool _requotesHandling = true;

  // Multi-Positions
  bool _hedging = false;
  bool _gridTrading = false;
  bool _pyramiding = false;
  int _maxPositions = 5;

  // Mode
  String _tradingMode = 'Conservateur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration Stratégies')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTradingModeSelector(),
          const SizedBox(height: 20),
          _buildStrategiesSection(),
          const SizedBox(height: 20),
          _buildMoneyManagementSection(),
          const SizedBox(height: 20),
          _buildStopsProfitsSection(),
          const SizedBox(height: 20),
          _buildNewsFilterSection(),
          const SizedBox(height: 20),
          _buildMarketSessionsSection(),
          const SizedBox(height: 20),
          _buildOrderManagementSection(),
          const SizedBox(height: 20),
          _buildMultiPositionsSection(),
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

  Widget _buildTradingModeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mode de Trading', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Conservateur', label: Text('Conservateur')),
                ButtonSegment(value: 'Modéré', label: Text('Modéré')),
                ButtonSegment(value: 'Agressif', label: Text('Agressif')),
              ],
              selected: {_tradingMode},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _tradingMode = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategiesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stratégies de Trading', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildStrategyToggle('Breakout', _breakoutEnabled, (val) => setState(() => _breakoutEnabled = val)),
            _buildStrategyToggle('Trend Following', _trendFollowingEnabled, (val) => setState(() => _trendFollowingEnabled = val)),
            _buildStrategyToggle('Order Block / BOS', _orderBlockEnabled, (val) => setState(() => _orderBlockEnabled = val)),
            _buildStrategyToggle('Scalping', _scalpingEnabled, (val) => setState(() => _scalpingEnabled = val)),
            _buildStrategyToggle('Swing Trading', _swingTradingEnabled, (val) => setState(() => _swingTradingEnabled = val)),
            _buildStrategyToggle('Mean Reversion', _meanReversionEnabled, (val) => setState(() => _meanReversionEnabled = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategyToggle(String name, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(name),
      value: value,
      onChanged: onChanged,
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
            SwitchListTile(
              title: const Text('Taille de Lot Dynamique'),
              subtitle: const Text('Ajuster automatiquement la taille du lot'),
              value: _dynamicLotSize,
              onChanged: (val) => setState(() => _dynamicLotSize = val),
            ),
            TextFormField(
              initialValue: _maxDrawdown.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Drawdown Max (%)',
                suffixText: '%',
              ),
              onChanged: (val) => setState(() => _maxDrawdown = double.tryParse(val) ?? _maxDrawdown),
            ),
            TextFormField(
              initialValue: _minCapital.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Capital Minimum (€)',
                suffixText: '€',
              ),
              onChanged: (val) => setState(() => _minCapital = double.tryParse(val) ?? _minCapital),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStopsProfitsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestion des Stops & Profits', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _stopLossATR.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stop Loss ATR Multiplier',
              ),
              onChanged: (val) => setState(() => _stopLossATR = double.tryParse(val) ?? _stopLossATR),
            ),
            TextFormField(
              initialValue: _takeProfitRatio.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ratio Risque/Récompense',
              ),
              onChanged: (val) => setState(() => _takeProfitRatio = double.tryParse(val) ?? _takeProfitRatio),
            ),
            SwitchListTile(
              title: const Text('Trailing Stop'),
              value: _trailingStop,
              onChanged: (val) => setState(() => _trailingStop = val),
            ),
            if (_trailingStop)
              DropdownButtonFormField<String>(
                value: _trailingType,
                decoration: const InputDecoration(labelText: 'Type de Trailing'),
                items: ['Classique', 'Par paliers', 'Basé volatilité'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => _trailingType = val!),
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
              value: _newsFilter,
              onChanged: (val) => setState(() => _newsFilter = val),
            ),
            if (_newsFilter) ...[
              const SizedBox(height: 10),
              FilterChip(
                label: const Text('High Impact'),
                selected: _highImpactFilter,
                onSelected: (val) => setState(() => _highImpactFilter = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Medium Impact'),
                selected: _mediumImpactFilter,
                onSelected: (val) => setState(() => _mediumImpactFilter = val),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: _newsMinutes.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Minutes avant/après news',
                  suffixText: 'min',
                ),
                onChanged: (val) => setState(() => _newsMinutes = int.tryParse(val) ?? _newsMinutes),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMarketSessionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sessions de Marché', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSessionToggle('Session Londres', _londonSession, (val) => setState(() => _londonSession = val)),
            _buildSessionToggle('Session New York', _newYorkSession, (val) => setState(() => _newYorkSession = val)),
            _buildSessionToggle('Session Asie', _asiaSession, (val) => setState(() => _asiaSession = val)),
            _buildSessionToggle('Heures personnalisées', _customHours, (val) => setState(() => _customHours = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionToggle(String name, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(name),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildOrderManagementSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestion des Ordres', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _maxSlippage.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Slippage Max (Points)',
              ),
              onChanged: (val) => setState(() => _maxSlippage = double.tryParse(val) ?? _maxSlippage),
            ),
            TextFormField(
              initialValue: _spreadFilter.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Filtre Spread (Points)',
              ),
              onChanged: (val) => setState(() => _spreadFilter = double.tryParse(val) ?? _spreadFilter),
            ),
            SwitchListTile(
              title: const Text('Vérification Liquidité'),
              value: _liquidityCheck,
              onChanged: (val) => setState(() => _liquidityCheck = val),
            ),
            SwitchListTile(
              title: const Text('Gestion des Requêtes'),
              value: _requotesHandling,
              onChanged: (val) => setState(() => _requotesHandling = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiPositionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Multi-Positions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPositionToggle('Hedging', _hedging, (val) => setState(() => _hedging = val)),
            _buildPositionToggle('Grid Contrôlé', _gridTrading, (val) => setState(() => _gridTrading = val)),
            _buildPositionToggle('Pyramiding', _pyramiding, (val) => setState(() => _pyramiding = val)),
            TextFormField(
              initialValue: _maxPositions.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Limitation Positions Ouvertes',
              ),
              onChanged: (val) => setState(() => _maxPositions = int.tryParse(val) ?? _maxPositions),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionToggle(String name, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(name),
      value: value,
      onChanged: onChanged,
    );
  }
}