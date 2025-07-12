// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:makicombomaster/widgets/bottom_navigation_bar_widget.dart';
import 'package:makicombomaster/widgets/combo_card.dart';
import 'package:makicombomaster/widgets/create_combo_card.dart'; // Importa el nuevo widget
import 'package:provider/provider.dart';
import '../providers/combo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCombos();
    });
  }

  Future<void> loadCombos() async {
  if (!mounted) return;
  setState(() {
    _isLoading = true;
  });

  await context.read<ComboProvider>().getAllCombos();

  if (!mounted) return;
  setState(() {
    _isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    final combos = context.watch<ComboProvider>().combos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Combos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadCombos,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [

                  CreateComboCard(
                    onTap: () {

                      Navigator.pushNamed(context, 'addComboScreen'); 
                    },
                  ),
                  const SizedBox(height: 10), 

                  if (combos.isEmpty)
                    const Center(child: Text("Aún no tienes combos favoritos"))
                  else
                    ...combos.map((combo) => ComboCard(combo: combo)).toList(),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}