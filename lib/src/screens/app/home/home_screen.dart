import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tezda_shop/theme/theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30),
              child:  Text('Discover', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Text('All', style: context.textTheme.headlineLarge),
                ],) 
                ),
            ),
            const SizedBox(height: 30),
            const Expanded(
              child: FlutterLogo(),),
          ],
        ),
      ),
    );
  }
}