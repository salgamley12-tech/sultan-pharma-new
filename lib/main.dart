import 'package:flutter/material.dart';

void main() {
  runApp(const SultanPharmaApp());
}

class SultanPharmaApp extends StatelessWidget {
  const SultanPharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'شركة الأدوية - العين الساهرة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainDashboardScreen(),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  // دالة عامة لتمكين التنقل البرمجي بين الأقسام من أي مكان
  void navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _screens = [
    HomeTabScreen(onNavigate: navigateToTab),
    const InventoryTabScreen(),
    const SalesTabScreen(),
    const ActivitiesTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: navigateToTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 26), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services, size: 26), label: 'المخزون'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet, size: 26), label: 'المبيعات'),
          BottomNavigationBarItem(icon: Icon(Icons.history, size: 26), label: 'الأنشطة'),
        ],
      ),
    );
  }
}

class HomeTabScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeTabScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شركة الأدوية - العين الساهرة'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'الإصدار المحدث: v4.0 (مستودع نظيف نشط)',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.blue, size: 30),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('المعرف الرئيسي للنظام', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 2),
                        Text('sal (نشط وموثق)', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'أقسام نظام سلطان فارما:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  // بطاقة إدارة المخزون التفاعلية
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.medical_services, color: Colors.green, size: 28),
                      title: const Text('إدارة المخزون والأدوية', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('متابعة الأصناف والأرصدة'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(1), // الانتقال لتبويب المخزون
                    ),
                  ),
                  const SizedBox(height: 8),
                  // بطاقة سجل الحسابات والمبيعات التفاعلية
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet, color: Colors.orange, size: 28),
                      title: const Text('سجل الحسابات والمبيعات', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('العمليات والفواتير المالية'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(2), // الانتقال لتبويب المبيعات
                    ),
                  ),
                  const SizedBox(height: 8),
                  // بطاقة تتبع الأنشطة الميدانية التفاعلية
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.history, color: Colors.purple, size: 28),
                      title: const Text('تتبع الأنشطة الميدانية', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('متابعة زيارات الصيدليات والمناديب'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(3), // الانتقال لتبويب الأنشطة
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryTabScreen extends StatelessWidget {
  const InventoryTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المخزون والأدوية'), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.medication, color: Colors.green), title: Text('باراسيتامول 500ملجم'), subtitle: Text('الكمية: 150 علبة'), trailing: Text('500 ر.ي'))),
          Card(child: ListTile(leading: Icon(Icons.medication, color: Colors.green), title: Text('أموكسيسيلين 250ملجم'), subtitle: Text('الكمية: 80 علبة'), trailing: Text('1200 ر.ي'))),
        ],
      ),
    );
  }
}

class SalesTabScreen extends StatelessWidget {
  const SalesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الحسابات والمبيعات'), backgroundColor: Colors.orange, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(color: Colors.orangeAccent, child: Padding(padding: const EdgeInsets.all(14), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('مبيعات اليوم:', style: TextStyle(color: Colors.white, fontSize: 16)), Text('45,000 ر.ي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))]))),
          ],
        ),
      ),
    );
  }
}

class ActivitiesTabScreen extends StatelessWidget {
  const ActivitiesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الأنشطة الميدانية'), backgroundColor: Colors.purple, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.location_on, color: Colors.purple), title: Text('زيارة صيدلية الشفاء'), subtitle: Text('تم تسليم الطلبية بنجاح'))),
        ],
      ),
    );
  }
}
