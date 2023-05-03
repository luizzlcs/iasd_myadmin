import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:iasd_myadmin/app/themes/app_theme.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:iasd_myadmin/app/util/constants.dart';
import 'package:iasd_myadmin/app/util/responsive.dart';
import 'package:provider/provider.dart';

class GridDepartaments extends StatelessWidget {
  const GridDepartaments({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    final departament = Provider.of<DepartamentsController>(context);

    final isDesktop = Responsive.isDesktop(context);

    return LayoutBuilder(builder: (context, constraints) {
      double scaleFactor = constraints.maxWidth / 100.0;
      return GridView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: departament.departament.length,
        itemBuilder: (context, index) {
          Departaments depart = departament.departament[index];
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: scaleFactor * 18,
                  height: scaleFactor * 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(depart.imageUrl)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 32, top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [],
                  ),
                ),
              ),
              Positioned(
                top: scaleFactor * 8,
                left: scaleFactor * 1,
                child: Container(
                  width: scaleFactor * 16,
                  height: scaleFactor * 5,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [],
                  ),
                ),
              ),
            ],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 5 : 3,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 30,
        ),
      );
    });
  }
}
