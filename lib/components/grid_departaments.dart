import 'package:flutter/material.dart';
import 'package:iasd_myadmin/model/departaments/departaments_controller.dart';
import 'package:iasd_myadmin/util/app_routes.dart';
import 'package:iasd_myadmin/util/responsive.dart';
import 'package:provider/provider.dart';

class GridDepartaments extends StatelessWidget {
  const GridDepartaments({Key? key});

  @override
  Widget build(BuildContext context) {
    final departament = Provider.of<DepartamentsController>(context);
    final isDesktop = Responsive.isDesktop(context);
    print(isDesktop);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: departament.departament.length,
      itemBuilder: (context, index) {
        final listDepartament = departament.departament[index];
        return Ink(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: InkWell(
            
            splashColor: Colors.white.withOpacity(0.5),
            highlightColor: Colors.blue,
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.secretaria, (route) => false);
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
