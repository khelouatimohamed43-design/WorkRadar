import 'package:flutter/material.dart';

void main() {
  runApp(const WorkRadarApp());
}

class WorkRadarApp extends StatelessWidget {
  const WorkRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkRadar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const RadarHomeScreen(),
    );
  }
}

class RadarHomeScreen extends StatelessWidget {
  const RadarHomeScreen({super.key});

  @override
  Widget build(BuildContext5 context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkRadar - رادار الوظائف'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.radar,
              size: 100,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'رادار البحث الآلي شغال 🚀',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'تطبيقك الذكي لرصد فرص العمل الحر وإنشاء المحتوى تلقائياً.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('بدء المسح الآن'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
