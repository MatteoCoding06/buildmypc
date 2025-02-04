import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Explore"),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const SizedBox(height: 20),
        //           const Text(
        //             "Benvenuto in PC Builder!",
        //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(height: 10),
        //           const Text(
        //             "Inizia a creare la tua configurazione personalizzata.",
        //             style: TextStyle(fontSize: 16, color: Colors.grey),
        //           ),
        //           const SizedBox(height: 20),
        //           Expanded(
        //             child: GridView.count(
        //               crossAxisCount: 2,
        //               crossAxisSpacing: 10,
        //               mainAxisSpacing: 10,
        //               children: [
        //                 _buildCard(
        //                   icon: Icons.build,
        //                   title: "Configura PC",
        //                   onTap: () {
        //                     // Navigazione alla configurazione PC
        //                   },
        //                 ),
        //                 _buildCard(
        //                   icon: Icons.shopping_cart,
        //                   title: "Componenti",
        //                   onTap: () {
        //                     // Navigazione ai componenti disponibili
        //                   },
        //                 ),
        //                 _buildCard(
        //                   icon: Icons.trending_up,
        //                   title: "Trend",
        //                   onTap: () {
        //                     // Navigazione alle build più popolari
        //                   },
        //                 ),
        //                 _buildCard(
        //                   icon: Icons.info,
        //                   title: "Consigli",
        //                   onTap: () {
        //                     // Navigazione alla sezione consigli
        //                   },
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   );
        // }

        // Widget _buildCard(
        //     {required IconData icon,
        //     required String title,
        //     required VoidCallback onTap}) {
        //   return GestureDetector(
        //     onTap: onTap,
        //     child: Card(
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        //       elevation: 4,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(icon, size: 50, color: Colors.blueAccent),
        //           const SizedBox(height: 10),
        //           Text(
        //             title,
        //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //           ),
        //         ],
        //       ),
      ),
    );
  }
}
