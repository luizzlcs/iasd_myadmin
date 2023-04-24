import 'package:flutter/material.dart';

class CreatDepartaments extends StatefulWidget {
  const CreatDepartaments({Key? key}) : super(key: key);

  @override
  State<CreatDepartaments> createState() => _CreatDepartamentsState();
}

class _CreatDepartamentsState extends State<CreatDepartaments> {
  final _formKey = GlobalKey<FormState>();

  _submitForm(){
    debugPrint('Salvando dados');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de departamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          key: _formKey,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Nome do departamento',
                  border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Decrição',
                  hintText: 'Descrição do departamento',
                  border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Imgaem',
                  hintText: 'Imagem do departamento',
                  border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_)=> _submitForm(),

            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const  Size(300, 50)
              ) ,
              onPressed: ()=> _submitForm() ,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
