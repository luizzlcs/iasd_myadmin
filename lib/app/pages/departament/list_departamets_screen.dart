import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/activity.dart';
import '../../model/departaments.dart';
import 'list_activity_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListDepartamentScreen extends StatefulWidget {
  const ListDepartamentScreen({Key? key}) : super(key: key);

  @override
  State<ListDepartamentScreen> createState() => _ListDepartamentScreenState();
}

class _ListDepartamentScreenState extends State<ListDepartamentScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Departaments> departaments = [];

  TextEditingController nameEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController imageEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode descricaoFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode imageFocus = FocusNode();
  FocusNode textButtonSaveFocus = FocusNode();
  bool isLoading = false;

  List disposable = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  void dispose() {
    for (var disposables in disposable) {
      disposables.dispose();
    }
    super.dispose();
  }

  void refresh() async {
    List<Departaments> temp = [];
    QuerySnapshot<Map<String, dynamic>> sanpshot =
        await firestore.collection('departaments').get();
    for (var doc in sanpshot.docs) {
      temp.add(Departaments.fromMap(doc.data(), id: doc.id));
    }
    setState(() {
      departaments = temp;
    });
  }

  Widget _buildModal() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Color.fromARGB(255, 97, 96, 96),
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 92, 3, 92),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Cadastrar departamentos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: formsDepartaments(),
          ),
        ],
      ),
    );
  }

  Widget formsDepartaments() {
    disposable.add(descricaoEC);
    disposable.add(nameEC);
    disposable.add(imageEC);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: nameEC,
            autofocus: true,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Nome',
              hintText: 'Nome do departamento',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(descricaoFocus),
            validator: (value) {
              final values = value ?? '';
              if (values.trim().isEmpty) {
                return 'É necessário informar o nome do departamento';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: descricaoEC,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Decrição',
                hintText: 'Descrição do departamento',
                border: OutlineInputBorder()),
            textInputAction: TextInputAction.next,
            focusNode: descricaoFocus,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(imageFocus),
            validator: (value) {
              final values = value ?? '';
              if (values.trim().isEmpty) {
                return 'É necessário fazer uma descrição para o departamento';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: imageEC,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Imgem',
                hintText: 'Imagem do departamento',
                border: OutlineInputBorder()),
            textInputAction: TextInputAction.done,
            focusNode: imageFocus,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textButtonSaveFocus),
          ),
          const SizedBox(
            height: 30,
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      focusNode: textButtonSaveFocus,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50)),
                      onPressed: () async {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;
                        if (isValid) {
                          final name = nameEC.text;
                          final descricao = descricaoEC.text;
                          final image = imageEC.text;

                          // Se o formulário for válido HABILITA o CircularProgressIndicator
                          setState(
                            () {
                              if (isValid) {
                                isLoading = true;
                                refresh();
                              }
                            },
                          );

                          Departaments newDepartaments = Departaments(
                            name: name,
                            description: descricao,
                            imageUrl: image,
                            activity: [
                              Activity(
                                name: 'Home',
                                page: '/dashBoard',
                                icon: Icons.home,
                              ),
                            ],
                          );

                          final firestore = FirebaseFirestore.instance;

                          var query =
                              await firestore.collection('departaments').add(
                                    newDepartaments.toMap(),
                                  );
                          newDepartaments.id = query.id;
                          debugPrint(
                              'COLLECTION: ${query.parent.path} ID: ${query.id}');

                          // Se o formulário for válido DESABILITA o CircularProgressIndicator
                          setState(
                            () {
                              if (isValid) {
                                isLoading = false;
                              }
                            },
                          );
                          Navigator.of(context).pop();
                          return;
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    );
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactorHeight = MediaQuery.of(context).size.height / 100;
    final double scaleFactorWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          top: 40,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: scaleFactorHeight * 300,
            minWidth: scaleFactorWidth * 100,
            maxWidth: scaleFactorWidth * 100,
          ),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 138, 137, 138),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: scaleFactorWidth * 100,
                height: scaleFactorHeight * 7,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Lista de Departaments',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    return refresh();
                  },
                  child: (departaments.isEmpty)
                      ? Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white.withOpacity(0.5), size: 120),
                        )
                      : SizedBox(
                          height: scaleFactorHeight * 79,
                          width: scaleFactorWidth * 100,
                          child: ListView.builder(
                            itemCount: departaments.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: const Color.fromARGB(255, 55, 55, 56),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.purple,
                                    backgroundImage: NetworkImage(
                                        departaments[index].imageUrl),
                                    child: Text(departaments[index]
                                        .name
                                        .substring(0, 3)),
                                  ),
                                  title: Text(departaments[index].name),
                                  subtitle:
                                      Text(departaments[index].description),
                                  hoverColor: Colors.deepOrange,
                                  onTap: () {
                                    debugPrint(
                                      ' Departamento: ${departaments[index].name.toString()} Indix: $index ID: ${departaments[index].id}',
                                    );
        
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ListActivityScreen(
                                                departaments:
                                                    departaments[index],
                                                index: index),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.amber.withOpacity(0.0),
                barrierColor: Colors.black.withOpacity(0.8),
                isScrollControlled: true,
                constraints: BoxConstraints(
                  minWidth: 900,
                  maxWidth: 950,
                  maxHeight: scaleFactorHeight * 72,
                ),
                context: context,
                builder: (BuildContext context) {
                  return _buildModal();
                },
              ).then((value) {
                nameEC.text = '';
                descricaoEC.text = '';
                imageEC.text = '';
              });
            },
          ),
        ],
      ),
    );
  }
}
