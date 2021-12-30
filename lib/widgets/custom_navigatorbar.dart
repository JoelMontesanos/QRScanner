import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {

    final uiprovider = Provider.of<UiProvider>(context);

    final currentIndex = uiprovider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiprovider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa,'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones,'
        ),
      ]
    );
  }
}