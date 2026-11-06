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

  // بيانات النظام الديناميكية المشتركة بين الفروع
  final List> inventoryList = [
    {'name': 'باراسيتامول 500ملجم', 'qty': '150 علبة', 'price': '500 ر.ي'},
    {'name': 'أموكسيسيلين 250ملجم', 'qty': '80 علبة', 'price': '1200 ر.ي'},
    {'name': 'فيتامين سي فوار', 'qty': '200 شريط', 'price': '300 ر.ي'},
  ];

  final List> salesList = [
    {'item': 'باراسيتامول 500ملجم', 'amount': '15,000 ر.ي', 'time': 'اليوم، 10:30 ص'},
    {'item': 'أموكسيسيلين 250ملجم', 'amount': '30,000 ر.ي', 'time': 'اليوم، 11:15 ص'},
  ];

  final List> activitiesList = [
    {'title': 'زيارة صيدلية الشفاء', 'details': 'تم تسليم طلبية الأدوية بنجاح', 'status': 'منجز'},
    {'title': 'مرور على صيدلية النور', 'details': 'عرض أسعار الأصناف الجديدة', 'status': 'قيد المعالجة'},
  ];

  // دالة إضافة دواء جديد للمخزون
  void addInventoryItem(String name, String qty, String price) {
    setState(() {
      inventoryList.add({'name': name, 'qty': qty, 'price': price});
    });
  }

  // دالة تسجيل عملية بيع جديدة
  void addSaleRecord(String item, String amount) {
    setState(() {
      salesList.add({'item': item, 'amount': amount, 'time': 'الآن'});
    });
  }

  // دالة إضافة نشاط ميداني جديد
  void addActivityRecord(String title, String details) {
    setState(() {
      activitiesList.add({'title': title, 'details': details, 'status': 'جديد'});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeTabScreen(
        inventoryCount: inventoryList.length.toString(),
        salesCount: salesList.length.toString(),
        activitiesCount: activitiesList.length.toString(),
        onNavigate: (index) => setState(() => _currentIndex = index),
      ),
      InventoryScreen(inventoryList: inventoryList, onAddItem: addInventoryItem),
      SalesScreen(salesList: salesList, onAddSale: addSaleRecord),
      ActivitiesScreen(activitiesList: activitiesList, onAddActivity: addActivityRecord),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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

// ================= شاشة الرئيسية =================
class HomeTabScreen extends StatelessWidget {
  final String inventoryCount;
  final String salesCount;
  final String activitiesCount;
  final Function(int) onNavigate;

  const HomeTabScreen({
    super.key,
    required this.inventoryCount,
    required this.salesCount,
    required this.activitiesCount,
    required this.onNavigate,
  });

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
                    'النظام المتكامل النشط: v5.0 (تشغيلي بالكامل)',
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
                        Text('sal (صلاحيات كاملة وموثقة)', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'أقسام نظام سلطان فارما التشغيلية:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.medical_services, color: Colors.green, size: 28),
                      title: const Text('إدارة المخزون والأدوية', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('الأصناف المسجلة: $inventoryCount أصناف'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet, color: Colors.orange, size: 28),
                      title: const Text('سجل الحسابات والمبيعات', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('الفواتير والعمليات: $salesCount عمليات'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.history, color: Colors.purple, size: 28),
                      title: const Text('تتبع الأنشطة الميدانية', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('الأنشطة والزيارات: $activitiesCount زيارات'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => onNavigate(3),
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

// ================= شاشة المخزون التفاعلية =================
class InventoryScreen extends StatelessWidget {
  final List> inventoryList;
  final Function(String, String, String) onAddItem;

  const InventoryScreen({super.key, required this.inventoryList, required this.onAddItem});

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final qtyController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة صنف دواء جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'اسم الدواء والصنف')),
            TextField(controller: qtyController, decoration: const InputDecoration(labelText: 'الكمية والعبوة')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'السعر (ر.ي)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                onAddItem(nameController.text, qtyController.text, priceController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ وإضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المخزون والأدوية'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: inventoryList.length,
        itemBuilder: (context, index) {
          final item = inventoryList[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.medication, color: Colors.green),
              title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('الكمية: ${item['qty']}'),
              trailing: Text(item['price']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ================= شاشة المبيعات والحسابات =================
class SalesScreen extends StatelessWidget {
  final List> salesList;
  final Function(String, String) onAddSale;

  const SalesScreen({super.key, required this.salesList, required this.onAddSale});

  void _showSaleDialog(BuildContext context) {
    final itemController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل عملية بيع جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: itemController, decoration: const InputDecoration(labelText: 'اسم الصنف المباع')),
            TextField(controller: amountController, decoration: const InputDecoration(labelText: 'المبلغ الإجمالي (ر.ي)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (itemController.text.isNotEmpty) {
                onAddSale(itemController.text, amountController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('تسجيل الفاتورة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الحسابات والمبيعات'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              color: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('إجمالي الحسابات المسجلة:', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text('${salesList.length} عمليات', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: salesList.length,
                itemBuilder: (context, index) {
                  const sale = salesList;
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long, color: Colors.orange),
                      title: Text(sale[index]['item']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('الوقت: ${sale[index]['time']}'),
                      trailing: Text(sale[index]['amount']!, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSaleDialog(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ================= شاشة الأنشطة الميدانية =================
class ActivitiesScreen extends StatelessWidget {
  final List> activitiesList;
  final Function(String, String) onAddActivity;

  const ActivitiesScreen({super.key, required this.activitiesList, required this.onAddActivity});

  void _showActivityDialog(BuildContext context) {
    final titleController = TextEditingController();
    final detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة نشاط ميداني جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'عنوان النشاط / الصيدلية')),
            TextField(controller: detailsController, decoration: const InputDecoration(labelText: 'التفاصيل والنتيجة')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                onAddActivity(titleController.text, detailsController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ النشاط'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الأنشطة الميدانية'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: activitiesList.length,
        itemBuilder: (context, index) {
          final act = activitiesList[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.purple),
              title: Text(act['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(act['details']!),
              trailing: Chip(
                label: Text(act['status']!, style: const TextStyle(color: Colors.white, fontSize: 11)),
                backgroundColor: Colors.purple.shade300,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActivityDialog(context),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
