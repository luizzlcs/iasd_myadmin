import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:iasd_myadmin/app/data/dummy_data.dart';
import 'package:iasd_myadmin/app/themes/app_theme.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:iasd_myadmin/app/util/responsive.dart';
import 'package:provider/provider.dart';

class GridDepartaments extends StatelessWidget {
  
  const GridDepartaments({super.key});

  @override
  Widget build(BuildContext context) {
    final departament = Provider.of<DepartamentsController>(context);
    final  departamento2 = Departaments;
    
    
    final isDesktop = Responsive.isDesktop(context);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: departament.departament.length,
      itemBuilder: (context, index) {
        final listDepartament = departament.departament[index];
        return Ink(
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context).isDark()
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(200),
              topLeft: Radius.circular(200),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(200),
            ),
          ),
          child: InkWell(
            focusColor: Colors.purple,
            splashColor: Colors.pink.withOpacity(0.5),
            highlightColor: Colors.blue,
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.of(context).pushNamed(
                  AppRoutes.secretaria, arguments: departament);                 
            },
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      child: CircleAvatar(
                        radius: isDesktop ? 120 : 50,
                        backgroundImage: ResizeImage(
                          NetworkImage(listDepartament.imageUrl),
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: isDesktop ? 220 : 82),
                  child: Container(
                    height: isDesktop ? 40 : 40,
                    width: isDesktop ? 180 : 90,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        listDepartament.name,
                        style: Provider.of<AppTheme>(context, listen: false)
                                .isDark()
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
        // const DepartamentList()
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 5 : 3,
        childAspectRatio: 4 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 30,
      ),
    );
  }
}
