import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.crisis_alert,
                    size: 50,
                    color: Colors.white,
                  ),
                  const Text(
                    'Ops!',
                    style: TextStyle(fontSize: 45),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: const AutoSizeText(
                      'A página que você está procurando não foi encontrada!',
                      maxLines: 3,
                    ),
                  )
                ],
              ),
            ),
            TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Voltar'))
          ],
        ),
      ),
    );
  }
}
