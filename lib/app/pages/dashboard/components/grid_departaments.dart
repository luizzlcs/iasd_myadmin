import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';
import 'package:iasd_myadmin/app/core/util/responsive.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GridDepartaments extends StatefulWidget {
  const GridDepartaments({super.key});

  @override
  State<GridDepartaments> createState() => _GridDepartamentsState();
}

class _GridDepartamentsState extends State<GridDepartaments> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Departaments> departaments = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() async {
    List<Departaments> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('departaments').get();

    for (var doc in snapshot.docs) {
      temp.add(Departaments.fromMap(doc.data()));
    }
    setState(() {
      departaments = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size.width;
    final double scaleFactor = dimension / 100;
    // final departament = Provider.of<DepartamentsController>(context);

    final isDesktop = Responsive.isDesktop(context);
    final isDark = Provider.of<AppTheme>(context).isDark();
    return (departaments.isEmpty)
        ? Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white.withOpacity(0.5),
              size: 150,
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(defaultPadding),
            itemCount: departaments.length,
            itemBuilder: (context, index) {
              Departaments depart = departaments[index];
              final bool isUrlNull = depart.imageUrl.isEmpty;
              return Ink(
                decoration: BoxDecoration(
                  color: Provider.of<AppTheme>(context).isDark()
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                        isDesktop ? scaleFactor * 10 : scaleFactor * 14),
                    topLeft: Radius.circular(
                        isDesktop ? scaleFactor * 10 : scaleFactor * 14),
                    bottomLeft: Radius.circular(scaleFactor * 0.5),
                    bottomRight: Radius.circular(
                        isDesktop ? scaleFactor * 10 : scaleFactor * 14),
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
                            child: isUrlNull
                                ? CircleAvatar(
                                    backgroundColor: isDark
                                        ? Colors.black54
                                        : const Color.fromARGB(
                                            255, 247, 245, 248),
                                    radius: isDesktop
                                        ? scaleFactor * 8.5
                                        : scaleFactor * 12.5,
                                    child: Text(
                                      'MyAdmin7',
                                      style: TextStyle(
                                        fontSize: isDesktop
                                            ? scaleFactor * 2
                                            : scaleFactor * 5,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: isDesktop
                                        ? scaleFactor * 8.5
                                        : scaleFactor * 12.5,
                                    backgroundImage: ResizeImage(
                                      NetworkImage(depart.imageUrl),
                                      width: (scaleFactor * 0.60).toInt(),
                                      height: (scaleFactor * 0.60).toInt(),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: isDesktop
                                  ? scaleFactor * 13
                                  : scaleFactor * 17.7,
                              right: isDesktop
                                  ? scaleFactor * 15
                                  : scaleFactor * 19,
                            ),
                            child: Container(
                              height: isDesktop
                                  ? scaleFactor * 2
                                  : scaleFactor * 4.9,
                              width: isDesktop
                                  ? scaleFactor * 5
                                  : scaleFactor * 10,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    isDesktop
                                        ? scaleFactor * 5
                                        : scaleFactor * 3,
                                  ),
                                  bottomLeft: Radius.circular(
                                    isDesktop
                                        ? scaleFactor * 5
                                        : scaleFactor * 3,
                                  ),
                                  topRight: Radius.circular(
                                    isDesktop
                                        ? scaleFactor * 5
                                        : scaleFactor * 3,
                                  ),
                                  bottomRight: Radius.circular(
                                    isDesktop
                                        ? scaleFactor * 5
                                        : scaleFactor * 3,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit_note_sharp,
                                    color: Colors.white,
                                    size: isDesktop
                                        ? scaleFactor * 1.9
                                        : scaleFactor * 3.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: isDesktop
                                  ? scaleFactor * 0.35
                                  : scaleFactor * 0.6,
                              right: isDesktop
                                  ? scaleFactor * 6
                                  : scaleFactor * 8.2,
                            ),
                            child: Container(
                              height: isDesktop
                                  ? scaleFactor * 3
                                  : scaleFactor * 5,
                              width: isDesktop
                                  ? scaleFactor * 13
                                  : scaleFactor * 20,
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
                                padding: isDesktop
                                    ? const EdgeInsets.only(top: 7)
                                    : const EdgeInsets.only(top: 2),
                                child: Text(
                                  depart.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDesktop
                                          ? scaleFactor * 1.3
                                          : scaleFactor * 2.7),
                                  textAlign: TextAlign.center,
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
