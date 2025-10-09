import 'package:flutter/material.dart';

void main() => runApp(const mengirim());

class mengirim extends StatelessWidget {
  const mengirim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/product_detail': (context) =>  const MyProduct(),
      },
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol ke Product
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  '/Product',
                  arguments: {'id': 101, 'name': 'Laptop'},
                );
              },
              child: const Text("Go to Product"),
            ),

            const SizedBox(height: 20),

            // Tombol ke Profile (dengan data ID & Name)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MyProfile(id: 1, name: 'Nunug'),
                  ),
                );
              },
              child: const Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}


class MyProfile extends StatelessWidget {
  final int id;
  final String name;

  const MyProfile({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile")
      ),
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
             Text('ID: $id'), 
            Text('Name: $name'), 
          ], 
        ),
      ),
    );
  }
}

class MyProduct extends StatelessWidget {
  const MyProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final args = 
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?; 
    final int id = args?['id'] ?? 0; 
    final String name = args?['name'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(title: const Text("Product Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            Text('Product ID: $id'), 
            Text('Product Name: $name'), 
          ],
        ),
      ),
    );
  }
}