import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Licence & Abonnement')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentPlanCard(context),
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
            const SizedBox(height: 24),
            _buildSecuritySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlanCard(BuildContext context) {
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
            const Text('Expire le: 15 Octobre 2023'),
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
                      : ElevatedButton(onPressed: () {}, child: const Text('Choisir ce plan')),
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

  Widget _buildSecuritySection() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sécurité & Appareils', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.computer),
              title: Text('Windows PC - MT5'),
              subtitle: Text('Dernière connexion: Aujourd\'hui 10:30'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.laptop_mac),
              title: Text('MacBook Pro - Web'),
              subtitle: Text('Session actuelle'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
