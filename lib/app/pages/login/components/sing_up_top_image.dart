import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/global/constantes_icons.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Criando uma conta".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: SvgPicture.asset(ImagesIasd.signup),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
