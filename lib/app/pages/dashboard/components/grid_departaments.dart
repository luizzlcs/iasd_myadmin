import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/ui/helpers/size_extensions.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';
import 'package:iasd_myadmin/app/core/util/responsive.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'departaments_pages.dart';

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
                    topRight: Radius.circular(isDesktop
                        ? context.percentWidth(.1)
                        : context.percentWidth(.14)),
                    topLeft: Radius.circular(isDesktop
                        ? context.percentWidth(.1)
                        : context.percentWidth(.14)),
                    bottomLeft: Radius.circular(scaleFactor * 0.5),
                    bottomRight: Radius.circular(isDesktop
                        ? context.percentWidth(.1)
                        : context.percentWidth(.14)),
                  ),
                ),
                child: InkWell(
                  focusColor: Colors.purple,
                  splashColor: Colors.pink.withOpacity(0.5),
                  highlightColor: Colors.blue,
                  borderRadius: BorderRadius.circular(200),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DepartamentsPages(),
                        settings: RouteSettings(arguments: depart),
                      ),
                    );
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
                                        ? context.percentWidth(.085)
                                        : context.percentWidth(.125),
                                    child: Text(
                                      'MyAdmin7',
                                      style: TextStyle(
                                        fontSize: isDesktop
                                            ? context.percentWidth(.02)
                                            : context.percentWidth(.05),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: isDesktop
                                        ? context.percentWidth(.085)
                                        : context.percentWidth(.125),
                                    backgroundImage: ResizeImage(
                                      NetworkImage(depart.imageUrl),
                                      width:
                                          (context.percentWidth(.006)).toInt(),
                                      height:
                                          (context.percentHeight(.006)).toInt(),
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
                                  ? context.percentWidth(.13)
                                  : context.percentWidth(.177),
                              right: isDesktop
                                  ? context.percentWidth(.15)
                                  : context.percentWidth(.19),
                            ),
                            child: Container(
                              height: isDesktop
                                  ? context.percentWidth(.02)
                                  : context.percentWidth(.049),
                              width: isDesktop
                                  ? context.percentWidth(.05)
                                  : context.percentWidth(.1),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    isDesktop
                                        ? context.percentWidth(.05)
                                        : context.percentWidth(.03),
                                  ),
                                  bottomLeft: Radius.circular(
                                    isDesktop
                                        ? context.percentWidth(.05)
                                        : context.percentWidth(.03),
                                  ),
                                  topRight: Radius.circular(
                                    isDesktop
                                        ? context.percentWidth(.05)
                                        : context.percentWidth(.03),
                                  ),
                                  bottomRight: Radius.circular(
                                    isDesktop
                                        ? context.percentWidth(.05)
                                        : context.percentWidth(.03),
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
                                        ? context.percentWidth(.019)
                                        : context.percentWidth(.035),
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
                                  ? context.percentWidth(.0035)
                                  : context.percentWidth(.0006),
                              right: isDesktop
                                  ? context.percentWidth(.06)
                                  : context.percentWidth(.082),
                            ),
                            child: Container(
                              height:
                                  isDesktop ? context.percentWidth(.03) : context.percentWidth(.05),
                              width: isDesktop
                                  ? context.percentWidth(.13)
                                  : context.percentWidth(.2),
                              decoration:  BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(context.percentWidth(.5)),
                                  topLeft: Radius.circular(context.percentWidth(.05)),
                                  bottomLeft: Radius.circular(context.percentWidth(.05)),
                                  topRight: Radius.circular(context.percentWidth(.05)),
                                ),
                              ),
                              child: Padding(
                                padding: isDesktop
                                    ? const EdgeInsets.only(top: 7)
                                    : const EdgeInsets.only(top: 2),
                                child: AutoSizeText(
                                  depart.name,
                                  style: const TextStyle(fontSize: 18),
                                  maxLines: 2,
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
