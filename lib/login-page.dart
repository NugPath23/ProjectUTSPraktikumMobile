import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/homepage': (context) => const homepage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF8D0909)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          //Card transparan di tengah
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: Color(0xFF8D0909),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back,My Gym Bro!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 🧍 Username field
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      if (value.contains(' ')) {
                        return 'Username tidak boleh mengandung spasi';
                      }
                      if (value.contains(RegExp(r'[A-Z]'))) {
                        return 'Username tidak boleh huruf kapital';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  //Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 8) {
                        return 'Password minimal 8 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  //Tombol Login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Berhasil ✅')),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            '/homepage',
                            arguments: {'username': _usernameController.text},
                          );
                        }
                      },
                      icon: const Icon(Icons.login, color: Color(0xFFFFFFFF)),
                      label: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D0909),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  //Teks bawah
                  TextButton(
                    onPressed: () {
                      //aksi buat register nanti
                    },
                    child: const Text(
                      "Belum punya akun? Daftar sekarang",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _HomePageState();
}

class _HomePageState extends State<homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeMenu(),
    const ProductMenu(),
    const ProfileMenu(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Gym App',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 255, 68, 68),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final username = args?['username'] ?? "Guest";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.home,
            size: 80,
            color: Color.fromARGB(255, 255, 0, 0),
          ),
          Text("Welcome, $username", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class ProductMenu extends StatelessWidget {
  const ProductMenu({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "title": "SURPLUS",
      "image": "assets/images/surplus.png",
      "description": "Produk penambah massa otot dan nutrisi tambahan.",
      "items": [
        "Whey Protein",
        "Mass Gainer",
        "Creatine",
        "Susu Penambah Berat Badan",
      ],
    },
    {
      "title": "CARDIO",
      "image": "assets/images/cardio.png",
      "description": "Peralatan latihan jantung dan pembakaran lemak.",
      "items": [
        "Treadmill",
        "Sepeda Statis",
        "Skipping Rope",
        "Elliptical Trainer",
      ],
    },
    {
      "title": "WEIGHT LIFTING",
      "image": "assets/images/weight.png",
      "description": "Peralatan angkat beban untuk membangun kekuatan.",
      "items": ["Barbell", "Dumbbell", "Bench Press", "Kettlebell"],
    },
    {
      "title": "YOGA",
      "image": "assets/images/yoga.png",
      "description":
          "Peralatan pendukung untuk latihan yoga dan fleksibilitas.",
      "items": ["Matras Yoga", "Yoga Block", "Strap Yoga", "Bola Pilates"],
    },
    {
      "title": "MEMBER",
      "image": "assets/images/member.png",
      "description": "Keanggotaan gym dengan berbagai fasilitas eksklusif.",
      "items": ["Membership Silver", "Membership Gold", "Membership Platinum"],
    },
    {
      "title": "CALCULATING",
      "image": "assets/images/calculating.jpg",
      "description": "Alat bantu untuk menghitung kebutuhan kalori dan nutrisi.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Baris pertama - 3 foto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: products.take(3).map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: _buildProductCard(context, product),
                ),
              );
            }).toList(),
          ),
          // Baris kedua - 2 foto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: products.skip(3).take(2).map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: _buildProductCard(context, product),
                ),
              );
            }).toList(),
          ),
          // Baris ketiga - 1 foto (Calculating)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: products.skip(5).take(1).map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: _buildProductCard(context, product),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        if (product['title'] == "CALCULATING") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CalorieCalculatorPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                title: product['title']!,
                image: product['image']!,
                description: product['description'],
                items: product['items'] ?? [],
              ),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              product['image']!,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
            ),
            Text(
              product['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman Detail Produk
class ProductDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final List<String> items;

  const ProductDetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: const Color(0xFF000000),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            const Text(
              "Daftar Produk / Alat:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => ListTile(
                leading: const Icon(
                  Icons.fitness_center,
                  color: Color(0xFFFF0000),
                ),
                title: Text(item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman untuk menghitung kebutuhan kalori & protein
class CalorieCalculatorPage extends StatefulWidget {
  const CalorieCalculatorPage({super.key});

  @override
  State<CalorieCalculatorPage> createState() => _CalorieCalculatorPageState();
}

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double weight = 0, height = 0;
  int age = 0;
  String gender = 'Male';
  String activityLevel = 'Sedentary';
  double calories = 0, protein = 0, calPerMeal = 0, protPerMeal = 0;

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double bmr = (gender == 'Male')
          ? 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          : 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);

      double factor = {
        'Sedentary': 1.2,
        'Lightly active': 1.375,
        'Moderately active': 1.55,
        'Very active': 1.725,
      }[activityLevel]!;

      setState(() {
        calories = bmr * factor;
        protein = 2 * weight;
        calPerMeal = calories / 3;
        protPerMeal = protein / 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calorie & Protein Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Isi data untuk menghitung kebutuhan harian kamu:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Berat Badan (kg)",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Masukkan berat badan" : null,
                  onSaved: (v) => weight = double.parse(v!),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Tinggi Badan (cm)",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Masukkan tinggi badan" : null,
                  onSaved: (v) => height = double.parse(v!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Usia"),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? "Masukkan usia" : null,
                  onSaved: (v) => age = int.parse(v!),
                ),
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: const InputDecoration(labelText: "Jenis Kelamin"),
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Laki-laki")),
                    DropdownMenuItem(value: "Female", child: Text("Perempuan")),
                  ],
                  onChanged: (val) => setState(() => gender = val!),
                ),
                DropdownButtonFormField<String>(
                  value: activityLevel,
                  decoration: const InputDecoration(
                    labelText: "Aktivitas Harian",
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Sedentary",
                      child: Text("Jarang olahraga"),
                    ),
                    DropdownMenuItem(
                      value: "Lightly active",
                      child: Text("1-3x/minggu"),
                    ),
                    DropdownMenuItem(
                      value: "Moderately active",
                      child: Text("3-5x/minggu"),
                    ),
                    DropdownMenuItem(
                      value: "Very active",
                      child: Text("6-7x/minggu"),
                    ),
                  ],
                  onChanged: (val) => setState(() => activityLevel = val!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculate,
                  child: const Text("Hitung Sekarang"),
                ),
                const SizedBox(height: 30),
                if (calories > 0)
                  Card(
                    elevation: 4,
                    color: Colors.blue[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Kalori Harian: ${calories.toStringAsFixed(2)} kcal",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Protein Harian: ${protein.toStringAsFixed(2)} gram",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Kebutuhan Kalori 1 kali makan (jika makan 3 x Sehari): ${calPerMeal.toStringAsFixed(2)} gram",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Kebutuhan Protein 1 kali makan (jika makan 3 x Sehari): ${protPerMeal.toStringAsFixed(2)} gram",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final username = args?['username'] ?? "Guest";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Foto Profil + Nama (horizontal)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/nugi.jpg'),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Info Tambahan (vertical dengan icon)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("Alamat: Padang, Sumatera Barat"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.green),
                      SizedBox(width: 10),
                      Text("HP: 0812-3456-7890"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Jenis Kelamin: Laki-laki"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
