import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedPlan = 'Professionnel';
  bool _autoRenewal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Licence & Abonnement')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentPlanCard(),
            const SizedBox(height: 24),
            const Text(
              'Plans Disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              context,
              title: 'Débutant',
              price: '29€ / mois',
              features: ['1 Compte MT4/MT5', 'Stratégies de base', 'Support Email'],
              isCurrent: false,
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              context,
              title: 'Professionnel',
              price: '59€ / mois',
              features: ['3 Comptes MT4/MT5', 'Toutes les stratégies', 'News Filter', 'Support Prioritaire'],
              isCurrent: true,
              isPopular: true,
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              context,
              title: 'Entreprise',
              price: '199€ / mois',
              features: ['Comptes Illimités', 'Stratégies Custom', 'API Access', 'Manager Dédié'],
              isCurrent: false,
            ),
            const SizedBox(height: 16),
            _buildLifetimePlanCard(),
            const SizedBox(height: 24),
            _buildAutoRenewalSection(),
            const SizedBox(height: 24),
            _buildSecuritySection(),
            const SizedBox(height: 24),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlanCard() {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Votre Plan Actuel', style: TextStyle(fontSize: 16)),
                Chip(
                  label: Text('ACTIF', style: TextStyle(fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Professionnel',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Expire le: 15 Octobre 2024'),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey.shade800,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            const Text('20 jours restants', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, {
    required String title,
    required String price,
    required List<String> features,
    bool isCurrent = false,
    bool isPopular = false,
  }) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(price, style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
                  ],
                ),
                const Divider(height: 30),
                ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 18, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(f),
                    ],
                  ),
                )),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: isCurrent
                      ? OutlinedButton(onPressed: () {}, child: const Text('Gérer'))
                      : ElevatedButton(onPressed: () => _changePlan(title), child: const Text('Choisir ce plan')),
                ),
              ],
            ),
          ),
        ),
        if (isPopular)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Text(
                'POPULAIRE',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLifetimePlanCard() {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade100, Colors.amber.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Licence à Vie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('499€ une fois', style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(height: 30),
              _buildLifetimeFeature('Accès perpétuel'),
              _buildLifetimeFeature('Mises à jour gratuites à vie'),
              _buildLifetimeFeature('Support prioritaire permanent'),
              _buildLifetimeFeature('Toutes les stratégies futures'),
              _buildLifetimeFeature('Économie de 60% vs abonnement annuel'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _changePlan('Licence à Vie'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Obtenir la Licence à Vie'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLifetimeFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.star, size: 18, color: Colors.amber),
          const SizedBox(width: 10),
          Text(feature),
        ],
      ),
    );
  }

  Widget _buildAutoRenewalSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Renouvellement Automatique', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Renouveler automatiquement'),
              subtitle: const Text('Éviter les interruptions de service'),
              value: _autoRenewal,
              onChanged: (val) => setState(() => _autoRenewal = val),
            ),
            const Text(
              'Votre carte de crédit sera débitée automatiquement à la date d\'expiration.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sécurité & Appareils', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Windows PC - MT5'),
              subtitle: const Text('Dernière connexion: Aujourd\'hui 10:30 • IP: 192.168.1.100'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.laptop_mac),
              title: const Text('MacBook Pro - Web'),
              subtitle: const Text('Session actuelle • IP: 192.168.1.101'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: const Text('iPhone 13 - Mobile'),
              subtitle: const Text('Dernière connexion: Hier 18:45'),
              trailing: const Icon(Icons.check_circle, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Déconnecter tous les appareils'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Support & Ressources', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Guide Utilisateur'),
              subtitle: const Text('Documentation complète'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Tutoriels Vidéo'),
              subtitle: const Text('Vidéos d\'installation et configuration'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('FAQ'),
              subtitle: const Text('Questions fréquemment posées'),
              trailing: const Icon(Icons.help),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Support Ticket'),
              subtitle: const Text('Créer un ticket de support'),
              trailing: const Icon(Icons.add),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _changePlan(String planName) {
    setState(() {
      _selectedPlan = planName;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Changement vers le plan $planName initié')),
    );
  }
}