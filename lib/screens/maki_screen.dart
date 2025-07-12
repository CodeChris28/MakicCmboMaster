import 'package:flutter/material.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:makicombomaster/widgets/bottom_navigation_bar_widget.dart';
import 'package:makicombomaster/widgets/create_maki_card.dart';
import 'package:makicombomaster/widgets/maki_card.dart';
import 'package:provider/provider.dart';

class MakisScreen extends StatefulWidget {
  const MakisScreen({super.key});

  @override
  State<MakisScreen> createState() => _MakisScreenState();
}

class _MakisScreenState extends State<MakisScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMakis();
    });
  }

  Future<void> loadMakis() async {
    setState(() {
      _isLoading = true;
    });

    await context.read<MakiProvider>().getAllMakis();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final makis = context.watch<MakiProvider>().makis;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Makis')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadMakis,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  CreateMakiCard(
                    onTap: () {
                      Navigator.pushNamed(context, 'addMakiScreen');
                    },
                  ),
                  ...makis.map((maki) => MakiCard(maki: maki)),
                ],
              ),
            ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
