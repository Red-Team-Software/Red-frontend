import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class BottomNavigationDecoration extends StatelessWidget {
  final Size size;
  final List<CustomBottomNavigationItem> items1;
  final List<CustomBottomNavigationItem> items2;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigationDecoration({
    super.key,
    required this.size,
    required this.items1,
    required this.items2,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...items1.map((item) => _CustomIconButton(
                icon: item.icon,
                activeIcon: item.activeIcon,
                index: items1.indexOf(item),
                colors: Theme.of(context).colorScheme,
                currentIndex: currentIndex,
                onItemTapped: onItemTapped,
                label: item.name,
              )),
          Container(width: size.width * 0.20), // Espacio para el icono central
          ...items2.map((item) => _CustomIconButton(
                icon: item.icon,
                activeIcon: item.activeIcon,
                index: items1.length + items2.indexOf(item),
                colors: Theme.of(context).colorScheme,
                currentIndex: currentIndex,
                onItemTapped: onItemTapped,
                label: item.name,
              )),
        ],
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final int index;
  final int currentIndex;
  final ColorScheme colors;
  final String label;
  final ValueChanged<int> onItemTapped;

  const _CustomIconButton({
    required this.icon,
    required this.activeIcon,
    required this.index,
    required this.colors,
    required this.currentIndex,
    required this.onItemTapped,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // La línea fija en la parte superior
          Container(
            width: 40, // Ajusta este ancho según sea necesario
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isSelected ? colors.primary : Colors.transparent,
                  width: 6.0, // Ancho de la barra
                ),
              ),
            ),
          ),
          // Contenido (icono y texto) con padding para separarlo de la línea
          Positioned(
            top: 10.0, // Ajusta este valor para colocar el contenido
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0), // Ajusta el espacio entre el icono y el borde
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isSelected ? activeIcon : icon,
                  const SizedBox(height: 4), // Espacio entre icono y texto
                  FittedBox(
                    fit: BoxFit.scaleDown, // Ajusta el texto si es largo
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? colors.primary : Colors.black26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
