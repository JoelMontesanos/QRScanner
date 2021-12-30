import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/direcciones_page.dart';
import 'package:qrscanner/pages/mapas_page.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/widgets/custom_navigatorbar.dart';
import 'package:qrscanner/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('QRAccess Scanner',),
        actions:[
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.delete_forever)
            )
        ]
      ),
      body: _HomePageBody(),
      bottomNavigationBar:CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    //get selectedMenuOpt
    final uiprovider = Provider.of<UiProvider>(context);
    final currentIndex= uiprovider.selectedMenuOpt;
    

    switch(currentIndex){
      case 0: 
      return MapasPage();
      case 1:
      return DireccionesPage();
      default:
      return MapasPage();
    }
  }
}