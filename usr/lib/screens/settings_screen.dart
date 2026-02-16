import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _telegramNotifications = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;
  bool _autoUpdates = true;
  bool _drawdownAlerts = true;
  String _selectedLanguage = 'Français';
  String _selectedTimezone = 'Europe/Paris';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationsSection(),
          const SizedBox(height: 24),
          _buildUpdatesSection(),
          const SizedBox(height: 24),
          _buildGeneralSection(),
          const SizedBox(height: 24),
          _buildSecuritySection(),
          const SizedBox(height: 24),
          _buildLegalSection(),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notifications & Alertes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Notifications Telegram'),
              subtitle: const Text('Recevoir les alertes sur Telegram'),
              value: _telegramNotifications,
              onChanged: (val) => setState(() => _telegramNotifications = val),
            ),
            SwitchListTile(
              title: const Text('Notifications Email'),
              subtitle: const Text('Recevoir les rapports par email'),
              value: _emailNotifications,
              onChanged: (val) => setState(() => _emailNotifications = val),
            ),
            SwitchListTile(
              title: const Text('Notifications Push'),
              subtitle: const Text('Alertes push sur mobile'),
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),
            SwitchListTile(
              title: const Text('Alertes Drawdown'),
              subtitle: const Text('Notifier en cas de drawdown élevé'),
              value: _drawdownAlerts,
              onChanged: (val) => setState(() => _drawdownAlerts = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mises à Jour & Maintenance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Mises à jour automatiques'),
              subtitle: const Text('Installer automatiquement les nouvelles versions'),
              value: _autoUpdates,
              onChanged: (val) => setState(() => _autoUpdates = val),
            ),
            ListTile(
              title: const Text('Vérifier les mises à jour'),
              subtitle: const Text('Version actuelle: 2.1.4'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Patchs de sécurité'),
              subtitle: const Text('Dernière vérification: Aujourd\'hui'),
              trailing: const Icon(Icons.security),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Général', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Langue'),
              subtitle: Text(_selectedLanguage),
              trailing: const Icon(Icons.language),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Sélectionner la langue'),
                    children: ['Français', 'English', 'Español'].map((lang) => 
                      SimpleDialogOption(
                        onPressed: () {
                          setState(() => _selectedLanguage = lang);
                          Navigator.pop(context);
                        },
                        child: Text(lang),
                      )
                    ).toList(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Fuseau horaire'),
              subtitle: Text(_selectedTimezone),
              trailing: const Icon(Icons.schedule),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Sélectionner le fuseau horaire'),
                    children: ['Europe/Paris', 'America/New_York', 'Asia/Tokyo', 'UTC'].map((tz) => 
                      SimpleDialogOption(
                        onPressed: () {
                          setState(() => _selectedTimezone = tz);
                          Navigator.pop(context);
                        },
                        child: Text(tz),
                      )
                    ).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sécurité & Licence', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Clé de licence'),
              subtitle: const Text('••••••••••••••••••••'),
              trailing: const Icon(Icons.key),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Comptes liés MT4/MT5'),
              subtitle: const Text('3 comptes connectés'),
              trailing: const Icon(Icons.link),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Limite d\'installations'),
              subtitle: const Text('2/5 installations utilisées'),
              trailing: const Icon(Icons.devices),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Conformité & Légal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Disclaimer Trading'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Conditions d\'utilisation'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Politique de risque'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('RGPD & Confidentialité'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}