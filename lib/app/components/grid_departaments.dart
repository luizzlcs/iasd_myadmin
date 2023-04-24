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

    return GridView.builder(
      padding: const EdgeInsets.all(defaultPadding),
      itemCount: departament.departament.length,
      itemBuilder: (context, index) {
        Departaments depart = departament.departament[index];
        return Ink(
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context).isDark()
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.5),
            borderRadius:  BorderRadius.only(
              topRight: Radius.circular(dimension.height * .3),
              topLeft: Radius.circular(dimension.height * .3),
              bottomLeft: Radius.circular(dimension.height * .01),
              bottomRight: Radius.circular(dimension.height * .3),
            ),
          ),
          child: InkWell(
            focusColor: Colors.purple,
            splashColor: Colors.pink.withOpacity(0.5),
            highlightColor: Colors.blue,
            borderRadius: BorderRadius.circular(200),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.secretaria, arguments: depart);
            },
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      child: CircleAvatar(
                        radius: isDesktop ? dimension.height *.17 : 50,
                        backgroundImage: ResizeImage(
                          NetworkImage(depart.imageUrl),
                          width: (dimension.width * 0.60).toInt() ,
                          height: (dimension.width * 0.60).toInt() ,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: isDesktop ? 220 : 82),
                      child: Container(
                        height: isDesktop ?  40 : 40,
                        width: isDesktop ? 180 : 90,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            depart.name,
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: isDesktop ? 220 : 82),
                      child: Container(
                        height: isDesktop ? 40 : 40,
                        width: isDesktop ? 50 : 30,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: IconButton(
                          alignment: Alignment.topCenter,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_note_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
