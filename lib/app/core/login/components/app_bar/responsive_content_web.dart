import 'package:flutter/material.dart';

class ResponsiveContentWeb extends StatelessWidget {
  const ResponsiveContentWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 36,
                  child: Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('QUEM SOMOS'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('NOSSAS CRENÇAS'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('CONTATENOS'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('ONDE ESTAMOS'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('POR DO SOL'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (constraints.maxWidth > 900)
                  PopupMenuButton(
                    child: Text(
                      'REDES SOCIAIS',
                      style: TextStyle(fontSize: 14),
                    ),
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
                        child: Text('Youtub'),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
