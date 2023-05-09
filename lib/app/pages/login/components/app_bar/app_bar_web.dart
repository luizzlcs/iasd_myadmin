import 'package:flutter/material.dart';

import 'responsive_content_web.dart';

class AppBarWeb extends StatelessWidget {
  const AppBarWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: const[

          const ResponsiveContentWeb(),
          
        ],
      ),
    );
  }
}
