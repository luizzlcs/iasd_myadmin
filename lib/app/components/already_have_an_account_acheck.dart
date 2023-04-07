import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/screens/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/util/constants.dart';
import 'package:provider/provider.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final Function? press;
  const AlreadyHaveAnAccountCheck({Key? key, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLogin =
        Provider.of<ControllerAlthLogin>(context, listen: true).isLogin();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Provider.of<ControllerAlthLogin>(context, listen: false).isLogin()
              ? "Não possui uma conta"
              : "Já possui uma conta",
          overflow: TextOverflow.fade,
          style: const TextStyle(color: kPrimaryLightColor),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ControllerAlthLogin>(context, listen: false)
                .swichAlthMode();
          },
          child: Text(isLogin ? 'CRIAR CONTA' : 'FAZER LOGIN'),
        ),
      ],
    );
  }
}