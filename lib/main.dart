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

  final List<Map<String, String>> _storeItems = [
    {
      'title': 'موسوعة القطط - الجزء الأول',
      'type': 'كتاب إلكتروني (PDF)',
      'price': '\$9.99',
      'downloads': '42 تحميل',
    },
    {
      'title': 'حزمة تصاميم Refine Yourself',
      'type': 'ملفات جرافيك عالية الدقة',
      'price': '\$14.99',
      'downloads': '18 تحميل',
    },
    {
      'title': 'قالب إدارة العمل الحر',
      'type': 'قالب جاهز',
      'price': '\$5.00',
      'downloads': '65 تحميل',
    },
  ];

  final TextEditingController _jobDescriptionController = TextEditingController();
  String _generatedProposal = '';

  @override
  Widget build(BuildContext context) {
    String titleText = 'رادار الوظائف';
    if (_selectedIndex == 1) titleText = 'ورشة العمل والإدارة';
    if (_selectedIndex == 2) titleText = 'المتجر الرقمي';
    if (_selectedIndex == 3) titleText = 'التواصل الذكي (AI)';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
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
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'المتجر',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'مساعد AI',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildRadarTab();
      case 1:
        return _buildWorkshopTab();
      case 2:
        return _buildStoreTab();
      case 3:
        return _buildAiAssistantTab();
      default:
        return _buildRadarTab();
    }
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

  // تبويب الورشة
  Widget _buildWorkshopTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          ListTile(
            leading: const Icon(Icons.description, color: Colors.deepPurpleAccent),
            title: const Text('مولد عروض العمل (Proposal Generator)'),
            subtitle: const Text('إنشاء نماذج تقديم احترافية للعملاء'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
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

  // تبويب المتجر الرقمي
  Widget _buildStoreTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: _storeItems.length,
      itemBuilder: (context, index) {
        final item = _storeItems[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shopping_bag, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('${item['type']} • ${item['downloads']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                Text(
                  item['price']!,
                  style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // تبويب مساعد الذكاء الاصطناعي لتوليد العروض
  Widget _buildAiAssistantTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مولد العروض الذكي (AI Proposal Builder)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'أدخل تفاصيل الوظيفة أو وصف المشروع وسيتم كتابة عرض مخصص وجذاب للعميل تلقائياً:',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _jobDescriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'مثال: مطلوب مصمم لإنشاء هوية بصرية كاملة لمشروع ناشئ...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              label: const Text('توليد العرض الاحترافي', style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                if (_jobDescriptionController.text.isNotEmpty) {
                  setState(() {
                    _generatedProposal = 'مرحباً بك عزيزي العميل،\n\nقرأت تفاصيل مشروعك بخصوص (${_jobDescriptionController.text.trim()})، ويسعدني جداً العمل معكم. أملك خبرة ممتازة في هذا المجال وسأضمن لك جودة عالية وتسليماً في الوقت المحدد.\n\nيمكنك الاطلاع على أعمالي السابقة ويسعدني مناقشة التفاصيل البدائية معكم لتنفيذ الطلب بالصورة المثالية.';
                  });
                }
              },
            ),
          ),
          if (_generatedProposal.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'العرض المقترح:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.15),
                border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SelectableText(
                _generatedProposal,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

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
