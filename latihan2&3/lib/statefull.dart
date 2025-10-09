import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() { 
  runApp(const MyStatefull()); 
} 
  
class MyStatefull extends StatefulWidget { 
  const MyStatefull({super.key}); 
  
  @override 
  State<MyStatefull> createState() => _MyStatefullState(); 
} 
  
class _MyStatefullState extends State<MyStatefull> { 
  int _kelipatan = 0; 
  void _kelipatanDua() { 
    setState(() { 
      _kelipatan += 2; 
    }); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: Scaffold( 
        appBar: AppBar( 
          title: const Text("Statefull Widget"), 
        ), 
        body: Center( 
          child: Container( 
            width: 100, 
            height: 100, 
            // color: Colors.amber, 
            child: Column( 
              children: [
                const SizedBox(height: 20), // jarak biar gak dempet
                ElevatedButton(
                  onPressed: () {
                    print("tombol ditekan");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Elevated Button"),
                ),
                Image.network( 
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Logo_Unand.svg/600px Logo_Unand.svg.png", 
                  width: 100, 
                  height: 150, 
                ), 
              ], 
            ), 
          ), 
        ), 
        floatingActionButton: FloatingActionButton( 
          onPressed: _kelipatanDua, 
          tooltip: "Kelipatan 2", 
          child: const Icon(Icons.add), 
        ),
      ), 
    ); 
  } 
}