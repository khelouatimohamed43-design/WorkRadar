import 'package:flutter/material.dart';

void main() {
  runApp(const WorkRadarApp());
}

class WorkRadarApp extends StatelessWidget {
  const WorkRadarApp({Key? key}) : super(key: key);

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
  const RadarHomeScreen({Key? key}) : super(key: key);

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
        title: Text(_selectedIndex == 0 ? 'رادار الوظائف' : 'ورشة العمل والإدارة'),
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
      body: _selectedIndex == 0 ? _buildRadarTab() : _buildWorkshopTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
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
            icon: Icon(Icons.build_circle_outlined),
            label: 'الورشة',
          ),
        ],
      ),
    );
  }

  // تبويب رادار الفرص
  Widget _buildRadarTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: _jobs.length,
      itemBuilder: (context, index) {
        final job = _jobs[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
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

  // تبويب الورشة ومتابعة المشاريع والمهام
  Widget _buildWorkshopTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // كارت الإحصائيات السريعة
          Card(
            color: Colors.deepPurple.withOpacity(0.2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(title: 'المشاريع النشطة', value: '3'),
                  _StatItem(title: 'عروض قيد الانتظار', value: '7'),
                  _StatItem(title: 'المكتملة هذا الشهر', value: '12'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'أدوات الورشة والإنتاجية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // أدوات العمل
          ListTile(
            leading: const Icon(Icons.description, color: Colors.deepPurpleAccent),
            title: const Text('مولد عروض العمل (Proposal Generator)'),
            subtitle: const Text('إنشاء نماذج تقديم احترافية للعملاء'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.greenAccent),
            title: const Text('حاسبة تسعير الخدمات'),
            subtitle: const Text('تقدير قيمة المشاريع والساعات'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check_box_outlined, color: Colors.orangeAccent),
            title: const Text('قائمة مهام المشاريع (To-Do List)'),
            subtitle: const Text('تنظيم وتسليم الأعمال في موعدها'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ويدجت فرعي لعرض الإحصائيات
class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
