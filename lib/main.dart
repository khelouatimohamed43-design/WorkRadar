import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        scaffoldBackgroundColor: const Color(0xFF121212),
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

  // 1. الوظائف الحية التفاعلية
  final List<Map<String, String>> _allJobs = [
    {
      'title': 'مصمم جرافيك وفوتوشوب',
      'platform': 'خمسات',
      'price': '\$25 - \$50',
      'time': 'منذ 10 دقائق',
      'desc': 'مطلوب تصميم 5 بنرات تسويقية لمتاجر إلكترونية بدقة عالية مع الملفات المصدرية.'
    },
    {
      'title': 'مطور تطبيقات Flutter',
      'platform': 'مستقل',
      'price': '\$100 - \$250',
      'time': 'منذ 25 دقيقة',
      'desc': 'تعديل وتطوير ميزات جديدة في تطبيق متجر إلكتروني قائم وإصلاح بعض الأخطاء.'
    },
    {
      'title': 'كاتب مقالات ومحتوى',
      'platform': 'OneForma',
      'price': '\$15 / ساعة',
      'time': 'منذ ساعة',
      'desc': 'كتابة مقالات حصريّة ومقالات SEO في مجال التقنية والتصميم وتطبيقات الموبايل.'
    },
  ];

  // 2. قائمة المهام الحية في الورشة
  final List<Map<String, dynamic>> _todoList = [
    {'title': 'مراجعة مسودة كتاب موسوعة القطط', 'isDone': true},
    {'title': 'تصميم نموذج Refine Yourself الجديد', 'isDone': false},
  ];
  final TextEditingController _todoController = TextEditingController();

  // 3. حاسبة التسعير التفاعلية
  double _hours = 8;
  double _ratePerHour = 20;
  double _profitMargin = 15;

  // 4. محرك الذكاء الاصطناعي التفاعلي
  final TextEditingController _jobDescController = TextEditingController();
  String _generatedProposal = '';
  bool _isGenerating = false;

  // 5. محادثات سحابية حية
  final List<Map<String, String>> _chatMessages = [
    {'sender': 'النظام', 'text': 'مرحباً بك في مساحة العمل السحابية لـ WorkRadar.'},
    {'sender': 'مساعد AI', 'text': 'التطبيق متصل ومستعد لتوليد العروض وإدارة أفكارك مباشرة.'}
  ];
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String titleText = 'رادار الوظائف';
    if (_selectedIndex == 1) titleText = 'ورشة العمل والإدارة';
    if (_selectedIndex == 2) titleText = 'المتجر الرقمي';
    if (_selectedIndex == 3) titleText = 'مساعد العروض (AI)';
    if (_selectedIndex == 4) titleText = 'المحادثات السحابية';
    if (_selectedIndex == 5) titleText = 'الملف الشخصي';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.amberAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جميع المحركات التفاعلية تعمل بنجاح!')),
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
          BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'الرادار'),
          BottomNavigationBarItem(icon: Icon(Icons.build_circle_outlined), label: 'الورشة'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI العروض'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'الدردشة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
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
        return _buildAiProposalTab();
      case 4:
        return _buildChatTab();
      case 5:
        return _buildProfileTab();
      default:
        return _buildRadarTab();
    }
  }

  // --- 1. تبويب الرادار ---
  Widget _buildRadarTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: _allJobs.length,
      itemBuilder: (context, index) {
        final job = _allJobs[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(job['platform']![0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: Text(job['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${job['platform']} • ${job['time']}'),
            trailing: Text(
              job['price']!,
              style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job['desc']!, style: const TextStyle(color: Colors.grey, height: 1.3)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                        icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                        label: const Text('تحويل الوظيفة لمولد العروض AI', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            _jobDescController.text = job['title']! + ': ' + job['desc']!;
                            _selectedIndex = 3;
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // --- 2. تبويب الورشة (حاسبة أرباح حية + إدارة المهام) ---
  Widget _buildWorkshopTab() {
    double totalCost = _hours * _ratePerHour;
    double profitAmount = totalCost * (_profitMargin / 100);
    double finalPrice = totalCost + profitAmount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🧮 حاسبة أرباح وتسعير المشاريع الحية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
          const SizedBox(height: 10),
          Card(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ساعات العمل المتوقعة: ${_hours.toInt()} ساعة'),
                    Text('\$${(_hours * _ratePerHour).toInt()}', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Slider(
                  value: _hours,
                  min: 1,
                  max: 50,
                  divisions: 49,
                  activeColor: Colors.deepPurpleAccent,
                  onChanged: (v) => setState(() => _hours = v),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('سعر ساعتك: \$${_ratePerHour.toInt()} /ساعة'),
                  ],
                ),
                Slider(
                  value: _ratePerHour,
                  min: 5,
                  max: 100,
                  divisions: 19,
                  activeColor: Colors.greenAccent,
                  onChanged: (v) => setState(() => _ratePerHour = v),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('هامش الربح الإضافي: ${_profitMargin.toInt()}%'),
                    Text('+\$${profitAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.greenAccent)),
                  ],
                ),
                Slider(
                  value: _profitMargin,
                  min: 0,
                  max: 50,
                  divisions: 10,
                  activeColor: Colors.amberAccent,
                  onChanged: (v) => setState(() => _profitMargin = v),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('المبلغ الإجمالي المقترح للعميل:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${finalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('📋 إدارة قائمة المهام المباشرة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(
                    hintText: 'اكتب مهمة جديدة للحفظ...',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.deepPurpleAccent, size: 36),
                onPressed: () {
                  if (_todoController.text.trim().isNotEmpty) {
                    setState(() {
                      _todoList.add({'title': _todoController.text.trim(), 'isDone': false});
                      _todoController.clear();
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _todoList.length,
            itemBuilder: (context, i) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CheckboxListTile(
                  title: Text(
                    _todoList[i]['title'],
                    style: TextStyle(
                      decoration: _todoList[i]['isDone'] ? TextDecoration.lineThrough : TextDecoration.none,
                      color: _todoList[i]['isDone'] ? Colors.grey : Colors.white,
                    ),
                  ),
                  value: _todoList[i]['isDone'],
                  activeColor: Colors.deepPurpleAccent,
                  onChanged: (val) {
                    setState(() {
                      _todoList[i]['isDone'] = val;
                    });
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // --- 3. تبويب المتجر الرقمي ---
  Widget _buildStoreTab() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.deepPurple.shade700, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.menu_book, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('موسوعة القطط - الجزء الأول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('كتاب إلكتروني تعليمي (PDF)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم فتح رابط المعاينة والتحميل بنجاح!')),
                          );
                        },
                        child: const Text('تحميل العينة (\$9.99)', style: TextStyle(color: Colors.white, fontSize: 12)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 4. مولد العروض التفاعلي بذكاء تحليلي ---
  Widget _buildAiProposalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✨ مولد العروض الذكي (AI Engine)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('ضع تفاصيل أية وظيفة وسيتم تحليلها وتوليد عرض مخصص فوراً:', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          TextField(
            controller: _jobDescController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'مثال: مطلوب مصمم لإنشاء هوية بصرية وشعار لمشروع جديد...',
              border: OutlineInputBorder(),
              filled: true,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, padding: const EdgeInsets.all(14)),
              icon: _isGenerating
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.auto_awesome, color: Colors.white),
              label: Text(_isGenerating ? 'جاري التحليل والتوليد...' : 'توليد العرض الاحترافي الان', style: const TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: _isGenerating ? null : _generateSmartProposal,
            ),
          ),
          if (_generatedProposal.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              color: Colors.deepPurple.shade900.withOpacity(0.4),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('العرض المولد الذكي:', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SelectableText(_generatedProposal, style: const TextStyle(height: 1.4, fontSize: 14)),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                        icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                        label: const Text('نسخ العرض مباشرة', style: TextStyle(color: Colors.white, fontSize: 13)),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _generatedProposal));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم نسخ العرض بالحافظة بنجاح!')),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }

  void _generateSmartProposal() async {
    if (_jobDescController.text.trim().isEmpty) return;

    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(milliseconds: 800)); // محاكاة معالجة سرعة السيرفر

    String text = _jobDescController.text.trim();
    String generated = 'مرحباً عزيزي العميل،\n\n'
        'لقد اطلعت بعناية على تفاصيل مشروعك بخصوص ($text).\n\n'
        'بصفتي مستقلاً متأكداً من متطلبات هذا العمل، أضمن لك تنفيذ المخرجات بأعلى معايير الدقة الاحترافية وبأنسب جدول زمني ممكن.\n\n'
        'خطوات العمل المقترحة:\n'
        '1. تحليلي الشامل للمتطلبات وتنفيذ عينة مبدئية للمعاينة.\n'
        '2. إجراء التعديلات بناءً على ملاحظاتكم حتى نصل للنتيجة المثالية.\n'
        '3. تسليم كافة الملفات النهائية والمصدرية.\n\n'
        'أنا جاهز للبدء فوراً ومناقشة أية تفاصيل إضافية معكم!';

    setState(() {
      _generatedProposal = generated;
      _isGenerating = false;
    });
  }

  // --- 5. الدردشة والتفاعل الحي ---
  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _chatMessages.length,
            itemBuilder: (context, i) {
              bool isMe = _chatMessages[i]['sender'] == 'أنت';
              return Align(
                alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.deepPurpleAccent : Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_chatMessages[i]['sender']!, style: const TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(_chatMessages[i]['text']!, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _chatController,
                  decoration: const InputDecoration(hintText: 'ارسل رسالة سحابية حية...', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.deepPurpleAccent, size: 28),
                onPressed: () {
                  if (_chatController.text.trim().isNotEmpty) {
                    setState(() {
                      _chatMessages.add({'sender': 'أنت', 'text': _chatController.text.trim()});
                      _chatController.clear();
                    });
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  // --- 6. الملف الشخصي ---
  Widget _buildProfileTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 42, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, size: 45, color: Colors.white)),
          SizedBox(height: 12),
          Text('Mohamed - WorkRadar Freelancer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('مستقل ومصمم رقمي محترف', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
