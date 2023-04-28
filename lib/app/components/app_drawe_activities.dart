import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:provider/provider.dart';

import '../themes/app_theme.dart';

class AppDrawerActivities extends StatelessWidget {
  final List<Activity> activities;

  const AppDrawerActivities({Key? key, required this.activities})
      : super(key: key);
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
          customTile(context, activities),
        ],
      ),
    );
  }

  Widget customTile(BuildContext context, List<Activity> activities) {
    final isDark = Provider.of<AppTheme>(context).isDark();

    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: isDark ? Colors.yellow : Colors.purple,
                  borderRadius: BorderRadius.circular(200)),
              child: Icon(activities[index].icon, color: isDark ? Colors.red : Colors.white,),
            ),
            title: Text(activities[index].name),
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
