import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';

final List<Departaments> dummyData = [
  Departaments(
      id: '1',
      name: 'Jovens',
      description: 'meninos e meninas entre 18 e 36 anos',
      imageUrl:
          'https://files.adventistas.org/downloads_v2/pt/2013/09/15150109/capa-ja.jpg',
      activity: [
        Activity(
          id: "0",
          name: "Home",
          icon: Icons.home,
          page: '/dashBoard',
        ),
        Activity(
          id: "1",
          name: "Reuniões",
          icon: Icons.ac_unit_rounded,
          page: '/navegacao',
        ),
        Activity(
          id: "2",
          name: "Teste",
          icon: Icons.card_membership,
          page: '/navegacao',
        ),
      ]),
  Departaments(
      id: '2',
      name: 'Desbravadores',
      description: 'meninos e meninas entre 10 e 15 anos',
      imageUrl:
          'https://files.adventistas.org/downloads_v2/pt/2020/01/16081900/capa-desbravadores.jpg',
      activity: [
        Activity(
          id: "0",
          name: "Home",
          icon: Icons.home,
          page: '/dashBoard',
        ),
        Activity(
          id: '3',
          name: 'Hasteamento de bandeiras',
          icon: Icons.credit_score,
          page: '/navegacao',
        ),
        Activity(
          id: '4',
          name: 'Classe Bíblica',
          icon: Icons.diamond,
          page: '/navegacao',
        ),
        Activity(
          id: '5',
          name: 'Cantinho da Unidade',
          icon: Icons.favorite,
          page: '/navegacao',
        ),
      ]),
  Departaments(
      id: '3',
      name: 'Aventureiros',
      description: 'meninos e meninas entre 6 e 9 anos',
      imageUrl:
          'https://s3.amazonaws.com/media.adventistas.org/apps/pt/2015/10/29130137/Aventureiros.png',
      activity: [
        Activity(
          id: "0",
          name: "Home",
          icon: Icons.home,
          page: '/dashBoard',
        ),
        Activity(
          id: '6',
          name: 'Especialidades',
          icon: Icons.car_repair,
          page: '/navegacao',
        ),
        Activity(
          id: '7',
          name: 'Classe Bíblica',
          icon: Icons.settings,
          page: '/navegacao',
        ),
        Activity(
          id: '8',
          name: 'Comunicação',
          icon: Icons.flight,
          page: '/navegacao',
        ),
        Activity(
          id: '9',
          name: 'Nosso planejamento',
          icon: Icons.run_circle,
          page: '/navegacao',
        ),
      ]),
  Departaments(
      id: '4',
      name: 'Música',
      description: 'Louvores',
      imageUrl:
          'http://files.adventistas.org/noticias/pt/2014/09/cartc3a3o-musica-grafica-848x478.jpg',
      activity: [
        Activity(
          id: "0",
          name: "Home",
          icon: Icons.home,
          page: '/dashBoard',
        ),
        Activity(
          id: '10',
          name: 'teste 1',
          icon: Icons.ac_unit,
          page: '',
        ),
        Activity(
          id: '11',
          name: 'teste 2',
          icon: Icons.home,
          page: '/navegacao',
        ),
        Activity(
          id: '12',
          name: 'teste 3',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '13',
          name: 'teste 4',
          icon: Icons.flight,
          page: '/navegacao',
        ),
        Activity(
          id: '14',
          name: 'teste 5',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '15',
          name: 'teste 6',
          icon: Icons.home,
          page: '/navegacao',
        ),
        Activity(
          id: '16',
          name: 'teste 7',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '17',
          name: 'teste 8',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '18',
          name: 'teste 9',
          icon: Icons.radar,
          page: '/navegacao',
        ),
        Activity(
          id: '19',
          name: 'teste 10',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '20',
          name: 'teste 11',
          icon: Icons.card_giftcard,
          page: 'navegacao',
        ),
        Activity(
          id: '21',
          name: 'teste 12',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '22',
          name: 'teste 13',
          icon: Icons.sunny,
          page: '/navegacao',
        ),
        Activity(
          id: '23',
          name: 'teste 14',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '24',
          name: 'teste 15',
          icon: Icons.edit,
          page: 'navegacao',
        ),
        Activity(
          id: '25',
          name: 'teste 16',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '26',
          name: 'teste 17',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '27',
          name: 'teste 18',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '28',
          name: 'teste 19',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
        Activity(
          id: '29',
          name: 'teste 20',
          icon: Icons.card_giftcard,
          page: '/navegacao',
        ),
      ]),
];
