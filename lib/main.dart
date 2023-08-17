import 'package:flutter/material.dart';

void main() {
  runApp(Menu());
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu Demo'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Modify code here
              Example1(),
              Example2(),
              Example3(),
            ],
          ),
        ),
      ),
    );
  }
}

// Problem 1: Overflow error
class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              'Explore the restaurant\'s delicious menu items below!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Problem 2: Viewport was given unbounded height error
class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          MenuItem('🍔', 'Burger'),
          MenuItem('🌭', 'Hot Dog'),
          MenuItem('🍟', 'Fries'),
          MenuItem('🥤', 'Soda'),
          MenuItem('🍦', 'Ice Cream'),
        ],
      ),
    );
  }
}

// Problem 3: Invisible VerticalDivider
class Example3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              print('Pickup button pressed.');
            },
            child: Text(
              'Pickup',
            ),
          ),
          // This widget is not shown on screen initially.
          VerticalDivider(
            width: 20.0,
            thickness: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              print('Delivery button pressed.');
            },
            child: Text(
              'Delivery',
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
    this.icon,
    this.itemText,
  );

  final String icon;
  final String itemText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SelectableText(
        icon,
        style: TextStyle(fontSize: 30),
      ),
      title: SelectableText(itemText),
    );
  }
}
