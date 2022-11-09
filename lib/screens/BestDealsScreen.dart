import 'package:flutter/material.dart';

class BestDealsScreen extends StatefulWidget {
  @override
  _BestDealsScreenState createState() => _BestDealsScreenState();
}

class _BestDealsScreenState extends State<BestDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: const Center(
        child: Text('Best Deals Page'),
      ),
    );
  }
}
