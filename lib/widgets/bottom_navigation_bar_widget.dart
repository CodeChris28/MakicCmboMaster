import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();

    return BottomNavigationBar(
      onTap: (value) {
        context.read<NavigationProvider>().setCurrentIndex(value);

        switch (value) {
          case 0:
            Navigator.pushReplacementNamed(context, 'homeScreen');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, 'addMakiScreen');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, 'addComboScreen'); 
            break;
        }
      },
      currentIndex: navProvider.currentIndex,
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.deepPurple,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: "Operaciones",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: "Crear Bono",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Perfil",
        ),
      ],
    );
  }
}
