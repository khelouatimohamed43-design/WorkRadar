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

class RadarHomeScreen extends StatefulWidget {
  const RadarHomeScreen({super.key});

  @override
  State<RadarHomeScreen> createState() => _RadarHomeScreenState();
}

class _RadarHomeScreenState extends State<RadarHomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _jobs = [
    {
      'title': 'مصمم جرافيك وفوتوشوب',
      'platform': 'خمسات',
      'price': '\$25 - \$50',
      'time': 'منذ 10 دقائق'
    },
    {
      'title': 'مطور تطبيقات Flutter',
      'platform': 'مستقل',
      'price': '\$100 - \$250',
      'time': 'منذ 25 دقيقة'
    },
    {
      'title': 'كاتب مقالات ومحتوى',
      'platform': 'OneForma',
      'price': '\$15 / ساعة',
      'time': 'منذ ساعة'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رادار الوظائف - WorkRadar'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('لا توجد إشعارات جديدة حالياً')),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildRadarTab() : _buildJobsTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.radar),
            label: 'الرادار',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'الفرص المكتشفة',
          ),
        ],
      ),
    );
  }

  Widget _buildRadarTab() {
    return Padding(
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
            '🚀 رادار البحث الآلي شغال',
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('جاري فحص المنصات ورصد أحدث الوظائف... 🔍'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text('بدء المسح الآن'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _jobs.length,
      itemBuilder: (context, index) {
        final job = _jobs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(job['platform']![0]),
            ),
            title: Text(job['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${job['platform']} • ${job['time']}'),
            trailing: Text(
              job['price']!,
              style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم فتح تفاصيل: ${job['title']}')),
              );
            },
          ),
        );
      },
    );
  }
}
