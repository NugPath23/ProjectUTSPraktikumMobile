import 'package:flutter/material.dart'; 
void main() { 
  runApp(const MyStateless()); 
} 
class MyStateless extends StatelessWidget { 
  const MyStateless({super.key}); 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: Scaffold( 
        appBar: AppBar( 
          title: const Text("Stateless Widget"), 
        ), 
        body: const Center( 
          child: Text("ini body"), 
        ), 
      ), 
    ); 
  } 
}