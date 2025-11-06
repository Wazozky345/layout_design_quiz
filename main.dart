import 'package:flutter/material.dart';
import 'dart:math'; 

const String creatorName = "Muhammad Yusman Bayuga";
const String creatorNIM ="232101145";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi UI Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const HomeScreen(),
    );
  }
}

// --------------------------------------------------------------------------
// --- HOME SCREEN INTERAKTIF (STATEFUL) ---
// --------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- STATE UNTUK KATEGORI DAN EMOJI ---
  String selectedCategory = 'Featured';
  String userStatus = 'Happy';
  // ignore: unused_field
  final Random _random = Random(); 

  // --- LOGIKA NAVIGASI (Hanya Home yang berfungsi) ---
  int _selectedIndex = 0; 
  late final List<Widget> _widgetOptions;
  
  // Path Aset Gambar Jaringan
  static const String _networkImagePath = 'https://i.pravatar.cc/150?img=68'; 

  @override
  void initState() {
    super.initState();
    // Inisialisasi widgetOptions (diperlukan untuk navigasi yang lengkap)
    _widgetOptions = <Widget>[
      SingleChildScrollView( 
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: _buildHomeContent(), 
      ),
      const Center(child: Text('📅 Kalender/Riwayat (Placeholder)', style: TextStyle(fontSize: 20, color: Colors.grey))), 
      const Center(child: Text('💬 Konsultasi Chat (Placeholder)', style: TextStyle(fontSize: 20, color: Colors.grey))), 
      const Center(child: Text('👤 Profil (Placeholder)', style: TextStyle(fontSize: 20, color: Colors.grey))),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- LOGIC EMOJI ---
  String _getStatusEmoji(String status) {
    switch (status) {
      case 'Happy':
        return '😊'; 
      case 'Stressed':
        return '😩'; 
      case 'Calm':
        return '😌'; 
      default:
        return '❓';
    }
  }

  // --- LOGIC PERUBAHAN EMOJI SAAT DIKLIK ---
  void _changeUserStatus() {
    setState(() {
      if (userStatus == 'Happy') {
        userStatus = 'Stressed';
      } else if (userStatus == 'Stressed') {
        userStatus = 'Calm';
      } else {
        userStatus = 'Happy';
      }
    });
  }
  
  // --- WIDGET CONTAINER UNTUK KONTEN HOME (INDEX 0) ---
  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 25),
        _buildSearchBar(),
        const SizedBox(height: 25),
        _buildCategoryChips(),
        const SizedBox(height: 25),
        _buildQuickFeatures(),
        const SizedBox(height: 25),
        _buildContentCards(),
        const SizedBox(height: 30),
        _buildGoalTracker(),
        const SizedBox(height: 20),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // --- WIDGET BUILD UTAMA (MENGGUNAKAN SELECTED INDEX) ---
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          // 1. Konten Utama (Berubah sesuai index, menggunakan SafeArea untuk menghindari notch)
          Expanded(
            child: SafeArea( // Menggunakan SafeArea di sini
              child: _widgetOptions.elementAt(_selectedIndex), 
            ),
          ),
          // 2. Navigasi Bawah
          _buildBottomNavBar(),
          // 3. Label Kredit (PENAMBAHAN BARU)
          _buildCreatorCredit(), 
        ],
      ),
    );
  }


  // --------------------------------------------------------------------------
  // --- PENAMBAHAN BARU: WIDGET KREDIT ---
  // --------------------------------------------------------------------------
  Widget _buildCreatorCredit() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      color: Colors.white, // Sesuaikan dengan warna Bottom NavBar
      child: Center(
        child: Text(
          '$creatorName ($creatorNIM)',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // --- WIDGET 1: HEADER (Gambar Profil + Emoji Interaktif) ---
  // --------------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Avatar dengan GAMBAR JARINGAN
        CircleAvatar(
          radius: 28,
          backgroundImage: const NetworkImage(_networkImagePath), // Network Image
          backgroundColor: const Color(0xFFFFC000), 
        ),
        const SizedBox(width: 15),

        // 2. Teks Sapaan dan Nama
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Selamat Siang', style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500)),
              Text(
                'Muhammad Yusman Bayuga',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1D2939)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),

        // 3. Ikon Emoji Interaktif
        GestureDetector(
          onTap: _changeUserStatus, 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Padding dikurangi untuk menghindari overflow
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Text(
                  _getStatusEmoji(userStatus), // Emoji dinamis
                  style: const TextStyle(fontSize: 24),
                ),
                const Icon(Icons.menu_rounded, size: 28, color: Color(0xFF1D2939)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // --- WIDGET 3: CHIP KATEGORI (Interaktif/Dapat Diklik) ---
  // --------------------------------------------------------------------------
  Widget _buildCategoryChips() {
    final List<String> categories = ['Featured', 'Relationship', 'Parenting', 'Career', 'Sleep'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category; // Mengubah state saat diklik
                });
              },
              child: Chip(
                label: Text(category),
                // Warna background dan border berubah saat terpilih
                backgroundColor: isSelected ? const Color(0xFF98A2B3) : Colors.white, 
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF475467),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: isSelected ? BorderSide.none : const BorderSide(color: Color(0xFFE4E7EC)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- WIDGET LAINNYA (TIDAK DIUBAH) ---

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildQuickFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFeatureBox(icon: Icons.star_border_rounded, text: 'Daily Positivity Boost', color: Colors.white),
        _buildFeatureBox(icon: Icons.home_outlined, text: 'Morning Routine Planner', color: Colors.white),
      ],
    );
  }

  Widget _buildFeatureBox({required IconData icon, required String text, required Color color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF101828), size: 28),
            const SizedBox(height: 12),
            Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF101828))),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContentCard(title: 'Mastering Focus Techniques', subtitle: 'Deep work strategies', backgroundColor: const Color(0xFF104646)),
        _buildContentCard(title: 'Unlocking Creative Flow', subtitle: 'Brainstorming methods', backgroundColor: const Color(0xFF155E75)),
      ],
    );
  }

  Widget _buildContentCard({required String title, required String subtitle, required Color backgroundColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 200,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: backgroundColor.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Daily Goals 🎯', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1D2939))),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildGoalCard(title: 'Meditasi 15 Mnt', progress: 0.6, icon: Icons.self_improvement, color: const Color(0xFF66C6A0)),
              const SizedBox(width: 15),
              _buildGoalCard(title: 'Tulis Jurnal', progress: 0.25, icon: Icons.edit_note, color: const Color(0xFFFD6B6B)),
              const SizedBox(width: 15),
              _buildGoalCard(title: 'Baca Buku', progress: 0.8, icon: Icons.menu_book, color: const Color(0xFF5B7FFF)),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard({required String title, required double progress, required IconData icon, required Color color}) {
    final percent = (progress * 100).toInt();
    return Container(
      width: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF101828)), overflow: TextOverflow.ellipsis)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$percent% Done', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 2, offset: const Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_filled, index: 0),
          _navItem(Icons.calendar_today_outlined, index: 1),
          _navItem(Icons.chat_bubble_outline, index: 2),
          _navItem(Icons.person_outline, index: 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, {required int index}) {
    final isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: isSelected ? const Color(0xFF101828) : const Color(0xFF98A2B3)),
          if (isSelected) Container(margin: const EdgeInsets.only(top: 4), height: 4, width: 4, decoration: BoxDecoration(color: const Color(0xFF101828), borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }
}