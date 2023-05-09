import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/themes/app_theme.dart';

class ResponsiveContentWeb extends StatelessWidget {
  const ResponsiveContentWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppTheme>(context).isDark();

    return Expanded(
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.pageConstrution);
                      },
                      child: Text(
                        'QUEM SOMOS',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.pageConstrution);
                      },
                      child: Text(
                        'NOSSAS CRENÇAS',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.pageConstrution);
                      },
                      child: Text(
                        'CONTATENOS',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.pageConstrution);
                      },
                      child: Text(
                        'ONDE ESTAMOS',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.pageConstrution);
                      },
                      child: Text(
                        'POR DO SOL',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.white),
                      ),
                    ),
                    if (constraints.maxWidth > 900)
                      PopupMenuButton(
                        tooltip: '',
                        child: Row(children: const [
                          SizedBox(width: 8),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.groups),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'REDES SOCIAIS',
                            style: TextStyle(fontSize: 14),
                          ),
                        ]),
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Instagram'),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text('FaceBook'),
                          ),
                          const PopupMenuItem(
                            value: 3,
                            child: Text('WhastApp'),
                          ),
                          const PopupMenuItem(
                            value: 3,
                            child: Text('Youtube'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
