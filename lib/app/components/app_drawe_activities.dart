import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';

class AppDrawerActivities extends StatelessWidget {
  final List<Activity> activities;
    
  const AppDrawerActivities({Key? key, required this.activities}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: Column(
        children: [
          AppBar(
            title: const Text('Seja Bem Vindo!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          customTile(context, activities ),
        ],
      ),
    );
  }
  Widget customTile(BuildContext context, List<Activity> activities) {
    return  SizedBox(
      width: 200,
      height: MediaQuery.of(context).size.height * .8 ,
      child: ListView.builder(
        itemCount: activities.length ,
        itemBuilder: (context, index){ 
          final activity = activities[index].id;
          return ListTile(
                leading: Icon(activities[index].icon),
                title:   Text(activities[index].name),
                onTap: () {
                  debugPrint('NOVA PÁGINA: ${activities[index].page}');
                  Navigator.of(context).pushNamed(activities[index].page);
                },
          );

          }, 
      ),
    );
  }
}
