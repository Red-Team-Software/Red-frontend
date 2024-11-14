import 'package:GoDeli/presentation/core/drawer/drawer_items.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [buildDrawerItems(context)],);
  }


  Widget buildDrawerItems(BuildContext context)=>
    Column(
      children: DrawerItems.all
        .map(
          (item) => ListTile(
            leading: Icon(item.icon, color: Colors.white,),
            title: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 14,),),
            onTap: (){},
          )).toList()
    ,);
  
}