import 'package:flutter/material.dart';
import 'package:makicombomaster/widgets/bottom_navigation_bar_widget.dart';
import 'package:makicombomaster/widgets/combo_card.dart';
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
    setState(() {
      _isLoading = true;
    });

    await context.read<ComboProvider>().getAllCombos(); 
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: combos.isEmpty
                    ? const Center(child: Text("Aún no tienes combos favoritos"))
                    : ListView.builder(
                        itemCount: combos.length,
                        itemBuilder: (context, index) {
                          return ComboCard(combo: combos[index]);
                        },
                      ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
