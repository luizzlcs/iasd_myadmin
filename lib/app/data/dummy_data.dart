import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';

final dummyData = {
  Departaments( 
    id: '1',
    name: 'Jovens',
    description: 'meninos e meninas entre 18 e 36 anos',
    imageUrl:
        'https://files.adventistas.org/downloads_v2/pt/2013/09/15150109/capa-ja.jpg',
    activity: [
      Activity(id: "0", name: "Painel",icon: Icons.arrow_circle_left_outlined, page:'/dashBoard', date: DateTime.now()),
      Activity(id: "1", name: "Reuniões",icon: Icons.ac_unit_rounded, page:'/navegacao', date: DateTime.now()),
      Activity(id: "2", name: "Teste", icon: Icons.card_membership, page:'/navegacao', date: DateTime.now()),
      
    ]
  ),
  Departaments(
    id: '2',
    name: 'Desbravadores',
    description: 'meninos e meninas entre 10 e 15 anos',
    imageUrl:
        'https://files.adventistas.org/downloads_v2/pt/2020/01/16081900/capa-desbravadores.jpg',
    activity: [
      Activity(id: "0", name: "Painel",icon: Icons.arrow_circle_left_outlined, page:'/dashBoard', date: DateTime.now()),
      Activity(id: '3', name: 'Hasteamento de bandeiras',icon: Icons.credit_score, page:'/navegacao' ,date: DateTime.now(),),
      Activity(id: '4', name: 'Classe Bíblica', icon: Icons.diamond, page:'/navegacao', date: DateTime.now()),
      Activity(id: '5', name: 'Cantinho da Unidade',icon: Icons.favorite, page:'/navegacao', date: DateTime.now()),
    ]
    
  ),
  Departaments(
    id: '3',
    name: 'Aventureiros',
    description: 'meninos e meninas entre 6 e 9 anos',
    imageUrl:
        'https://s3.amazonaws.com/media.adventistas.org/apps/pt/2015/10/29130137/Aventureiros.png',
    activity: [
      Activity(id: "0", name: "Painel",icon: Icons.arrow_circle_left_outlined, page:'/dashBoard', date: DateTime.now()),
      Activity(id: '6', name: 'Especialidades', icon: Icons.car_repair, page:'/navegacao', date: DateTime.now()),
      Activity(id: '7', name: 'Classe Bíblica', icon: Icons.settings, page:'/navegacao', date: DateTime.now()),
      Activity(id: '8', name: 'Comunicação', icon:  Icons.flight, page:'/navegacao', date: DateTime.now()),
      Activity(id: '9', name: 'Nosso planejamento', icon: Icons.run_circle, page:'/navegacao',  date: DateTime.now()),
    ]
  ),
  Departaments(
    id: '4',
    name: 'Música',
    description: 'Louvores',
    imageUrl:
        'http://files.adventistas.org/noticias/pt/2014/09/cartc3a3o-musica-grafica-848x478.jpg',
    activity: [
      Activity(id: "0", name: "Painel",icon: Icons.arrow_circle_left_outlined, page:'/dashBoard', date: DateTime.now()),
      Activity(id: '10', name: 'teste 1', icon: Icons.ac_unit, page: '', date: DateTime.now()),
      Activity(id: '11', name: 'teste 2', icon: Icons.home, page:'/navegacao', date: DateTime.now()),
      Activity(id: '12', name: 'teste 3', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '13', name: 'teste 4', icon: Icons.flight, page:'/navegacao', date: DateTime.now()),
      Activity(id: '14', name: 'teste 5', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '15', name: 'teste 6', icon: Icons.home, page:'/navegacao', date: DateTime.now()),
      Activity(id: '16', name: 'teste 7', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '17', name: 'teste 8', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '18', name: 'teste 9', icon: Icons.radar, page:'/navegacao', date: DateTime.now()),
      Activity(id: '19', name: 'teste 10', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '20', name: 'teste 11', icon: Icons.card_giftcard, page:'navegacao', date: DateTime.now()),
      Activity(id: '21', name: 'teste 12', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '22', name: 'teste 13', icon: Icons.sunny, page:'/navegacao', date: DateTime.now()),
      Activity(id: '23', name: 'teste 14', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '24', name: 'teste 15', icon: Icons.edit, page:'navegacao', date: DateTime.now()),
      Activity(id: '25', name: 'teste 16', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '26', name: 'teste 17', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '27', name: 'teste 18', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '28', name: 'teste 19', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
      Activity(id: '29', name: 'teste 20', icon: Icons.card_giftcard, page:'/navegacao', date: DateTime.now()),
    ]
      
  ),
  Departaments(
    id: '5',
    name: 'Mordomia',
    description: 'Louvores',
    imageUrl:
        'http://files.adventistas.org/noticias/pt/2016/01/20105227/Mordomia-I.jpg',
  ),
  Departaments(
    id: '6',
    name: 'M. Crinaça',
    description: 'Louvores',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR99XlhO3JrXEGZRA-z3ttIrDPfcyNg4lJUYQTFb5DK45yaCEt30hX6zdLurSHSXrgWlbA&usqp=CAU',
  ),
  Departaments(
    id: '7',
    name: 'Diaconato',
    description: 'Louvores',
    imageUrl:
        'https://media.istockphoto.com/id/1027781310/pt/foto/man-looks-like-politician-or-businessman-stands-with-holy-bible.jpg?s=170667a&w=0&k=20&c=9U9WFuFA75UjXOqiqxO3PrOWmnF0FSbNVEHBmdgX_yg=',
  ),
  Departaments(
      id: '8',
      name: 'Secretaria',
      description: 'Louvores',
      imageUrl:
          'https://sigeigrejas.com.br/wp-content/uploads/2022/05/abrir-igreja.jpeg'),
  Departaments(
    id: '9',
    name: 'Sonoplastia',
    description: 'Louvores',
    imageUrl:
        'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX33029398.jpg',
  ),
  Departaments(
    id: '10',
    name: 'Ancionato',
    description: 'Louvores',
    imageUrl:
        'https://files.adventistas.org/institucional/pt/sites/23/2013/04/site_sou_pastor.jpg',
  ),
  Departaments(
    id: '11',
    name: 'Mulher',
    description: 'Louvores',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3LiaqxGAL68xaLmcweVdfQZj1bz3I8UL2Q8wH_9bvaGSyDbnkvrWj9sxWuWVceWUi6Cs&usqp=CAU',
  ),
  Departaments(
    id: '12',
    name: 'Tesouraria',
    description: 'Louvores',
    imageUrl:
        'https://files.adventistas.org/noticias/pt/2021/08/shutterstock_382756228.jpg',
  ),
  Departaments(
    id: '13',
    name: 'Comunicação',
    description: 'Louvores',
    imageUrl:
        'http://4.bp.blogspot.com/_mpdJ4ytUOtE/TAVz7rvqPDI/AAAAAAAABWo/00_DBOtZAOM/s1600/comunica%C3%A7%C3%A3o.jpg',
  ),
  Departaments(
    id: '14',
    name: 'Sabatina',
    description: 'Louvores',
    imageUrl:
        'https://files.adventistas.org/downloads_v2/pt/2020/01/16081948/capa-escola-sabatina.jpg',
  ),
  Departaments(
    id: '15',
    name: 'M. Pessoal',
    description: 'Louvores',
    imageUrl:
        'https://1.bp.blogspot.com/-Lj49EAvN5FY/XF22iVX-tGI/AAAAAAAAOB4/bwvoungmtWYIherDqKbrkimHu8jAPnUmQCLcBGAs/s1600/divisao%2Bdos%2Bdizimos.jpg',
  ),
  Departaments(
    id: '16',
    name: 'Adolescentes',
    description: 'Louvores',
    imageUrl:
        'https://files.adventistas.org/downloads_v2/pt/2013/04/15130333/capa-adolescente.jpg',
  ),
  Departaments(
    id: '17',
    name: 'PG',
    description: 'Louvores',
    imageUrl:
        'https://aa3c56fda2.cbaul-cdnwnd.com/b7400be98e79c21e115bb40d09024d91/200000022-47dd447dd6/700/images%20%281%29-0.jpeg?ph=aa3c56fda2',
  ),
  Departaments(
    id: '18',
    name: 'Publicação',
    description: 'Louvores',
    imageUrl:
        'https://image.isu.pub/130520133333-1e684ef7763f4b3897208c3d8f67af90/jpg/page_1_thumb_large.jpg',
  ),
  Departaments(
    id: '20',
    name: 'Recepção',
    description: 'Louvores',
    imageUrl:
        'http://www.igrejaunasp.org/imgLogoDepartamento/5//LOGO.RECEPC%CC%A7A%CC%83O.jpg',
  ),
  Departaments(
    id: '21',
    name: 'ASA',
    description: 'Louvores',
    imageUrl:
        'https://files.adventistas.org/downloads_v2/pt/2020/01/15132934/capa-asa.jpg',
  ),
  Departaments(
    id: '21',
    name: 'Saúde',
    description: 'Louvores',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQOEaRnkh7B4fYTYMGt1bIRf8EC8H5drQuWpD_HPHHMWElTU-_ltyR3IoFiz-TD5w_4JQ&usqp=CAU ',
  ),
};
