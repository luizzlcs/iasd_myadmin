import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:iasd_myadmin/app/core/util/email_validator_util.dart'
    as email_valid;

import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScrenUserData extends StatefulWidget {
  const ScrenUserData({Key? key}) : super(key: key);

  @override
  State<ScrenUserData> createState() => _ScrenUserDataState();
}

class _ScrenUserDataState extends State<ScrenUserData> {
  final imagePicker = ImagePicker();
  File? imageFile;
  bool uploadin = false;
  double total = 0;
  int decimalPlaces = 2;
  String uploadFile = '';

  final TextEditingController _emailEC = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final TextEditingController _nameEC = TextEditingController();
  final FocusNode _nameFocus = FocusNode();

  final user = FirebaseAuth.instance.currentUser;
  String name = '';
  String email = '';
  String uid = '';
  String imageUrl = '';
  Object emailVerified = '';

  @override
  void initState() {
    name = user?.displayName ?? 'Sem nome';
    email = user?.email ?? 'Sem e-mail';
    uid = user?.uid ?? 'Sem identificador único';
    imageUrl = user?.photoURL ??
        'https://tm.ibxk.com.br/2017/06/22/22100428046161.jpg';
    emailVerified = user?.emailVerified ?? 'Sem verficado?';
    _nameEC.text = name;
    _emailEC.text = email;
    super.initState();
  }

  void snackBar({required Widget menssage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: menssage,
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.green[900],
        showCloseIcon: true,
      ),
    );
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Future<UploadTask> upload(String path) async {
      try {
        String ref = 'imagens/img-${DateTime.now().toString()}.jpeg';
        final storageRef = FirebaseStorage.instance.ref();
        return storageRef.child(ref).putFile(
              File(path),
            );
      } on FirebaseException catch (e) {
        throw Exception('Erro no upload: ${e.code}');
      }
    }

    pick(ImageSource source) async {
      final XFile? pickedFile = await imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        UploadTask task = await upload(pickedFile.path);

        task.snapshotEvents.listen((TaskSnapshot snapshot) async {
          if (snapshot.state == TaskState.running) {
            setState(() {
              uploadin = true;
              total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            });
          } else if (snapshot.state == TaskState.success) {
            final photoRef = snapshot.ref;
            final photoUrl = await photoRef.getDownloadURL();
            setState(() {
              uploadFile = photoUrl;
              imageUrl = photoUrl;
              uploadin = false;
            });
            await user?.updatePhotoURL(photoUrl);
          }
        });

        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    }

    void returnPage() {
      Navigator.pop(context);
    }

    void clearUrl() async {
      setState(() {
        imageUrl = '';
      });
      await user?.updatePhotoURL(null);
    }

   

    

    void updateLogin() async {
      setState(() {
        name = _nameEC.text;
        email = _emailEC.text;
      });
      if (user?.email != _emailEC.text || user?.displayName != _nameEC.text) {
      
        snackBar(
          menssage: const Text(
            'Os dados foram alterados com sucesso!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }
      await user?.updateDisplayName(_nameEC.text);
      await user?.updateEmail(_emailEC.text);
    }

    void showOpcoesBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.photo_library_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text(
                    'Galeria',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    pick(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.camera,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text(
                    'Câmera',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    pick(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red[500],
                      ),
                    ),
                  ),
                  title: Text(
                    'Remover',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    clearUrl();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    imageDialogin() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            title: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.network(fit: BoxFit.cover, imageUrl),
                )
              ],
            ),
          );
        },
      );
    }

    youDialogin() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 58, 57, 57),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            title: Column(
              children: [
                const Text(
                  'Alterando os dados da conta!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameEC,
                  focusNode: _nameFocus,
                  validator: (value) {
                    final values = value ?? '';
                    if (values.isNotEmpty && values.length >= 4) {
                      return null;
                    }
                    return 'O nome precisa ter pelomenos 4 caracteres!';
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSaved: (name) {},
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_nameFocus);
                  },
                  decoration: const InputDecoration(
                    hintText: "Nome",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _emailEC,
                  focusNode: _emailFocus,
                  validator: (value) {
                    final values = value ?? '';
                    final values2 =
                        values.trim().replaceAll(RegExp(r'\s+$'), '');
                    if (email_valid.isValid(values2)) {
                      return null;
                    }
                    return 'O email não é válido';
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSaved: (email) {},
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                  decoration: const InputDecoration(
                    hintText: "Seu e-mail",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Ao alterar o endereço de e-mail você será deslogado para fazer uma nova autenticação.',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow),
                  maxLines: 4,
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 200, 199, 201),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 200, 199, 201),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  updateLogin();
                  returnPage();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.dashBoard, (route) => false);
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: uploadin
            ? Center(child: Text('${total.toStringAsFixed(1)}% enviado'))
            : const Center(child: Text('Perfil do usuário')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey[200],
                      child: uploadin
                          ? LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.blue.withOpacity(0.5),
                              size: 120,
                            )
                          : GestureDetector(
                              onTap: () {
                                imageDialogin();
                              },
                              child: CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.grey[400],
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: showOpcoesBottomSheet,
                          icon: Icon(
                            Icons.image_search,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              height: 540,
              width: 600,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Chip(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.black,
                    label: Text(
                      name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Colors.black,
                        label: Text(
                          email,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Chip(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.black,
                    label: Text(
                      uid,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Chip(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.black,
                    label: Text(
                      (emailVerified == true)
                          ? 'O e-mail foi confirmado: SIM'
                          : 'O e-mail foi confirmado: NÃO',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        youDialogin();
                      },
                      child: const Text('Editar'))
                ],
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
