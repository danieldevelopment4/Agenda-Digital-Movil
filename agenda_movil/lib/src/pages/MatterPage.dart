// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/ActivityModel.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/StudentModel.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/CreateActivityPage.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/TeacherPage.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';
import 'AdtivityPage.dart';

class MatterPage extends StatefulWidget {
  const MatterPage({Key? key}) : super(key: key);

  static const String route = "Matter";

  @override
  State<MatterPage> createState() => _MatterPageState();
}

class _MatterPageState extends State<MatterPage> {
  late Size _size;
  late Management _management;

  late TextStyle _titlle;
  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late TextStyle _headerSubTitlle;
  late TextStyle _headerSubTitlleApproved;
  late TextStyle _headerSubTitlleDeprecated;
  late TextStyle _cardSubText;
  late ButtonStyle _buttonStyle;

  TextEditingController searchTextField = TextEditingController();
  bool _searchTeacherLoading = false;
  bool _addTeacherLoading = false;

  String _teacherId="";
  String _teacherFullName="";
  String _teacherEmail="";
  String _teacherCellphone="";

  final TextEditingController _teacherIdTextField = TextEditingController();

  late MatterModel _matter;
  late List<ActivityModel> _activitiesList;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _notificationTitle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
    _notificationText = const TextStyle(
      fontSize: 15,
    );
     _matter = _management.getMatter();
     _activitiesList = _matter.getActivitiesList;
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _headerSubTitlle = const TextStyle(
      fontSize: 20,
    );
    _headerSubTitlleApproved = const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
    _headerSubTitlleDeprecated = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
    _cardSubText = const TextStyle(
      fontSize: 18,
    );
    _buttonStyle = TextButton.styleFrom(
      primary: Colors.white, //color de la letra 
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      minimumSize: Size(_size.width*.9, 40),
      backgroundColor: Colors.blue[700], 
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _titlle
        ),
        
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: PageView(
      controller: PageController(initialPage: 1),
      children: <Widget>[
        _principal(),
        _activitys(context),
        _teacher(context),
        _extras(),
      ],
      ),
         
    );
  }

  Widget _principal(){

    int percent = 0;
    double note = 0;
    
    if (_activitiesList.isNotEmpty) {
      int term = _activitiesList[_activitiesList.length-1].getTerm;
      for (var i = _activitiesList.length-1; i >= 0; i--) {
        if(term==_activitiesList[i].getTerm){
          percent+=_activitiesList[i].getPercen;
          if(_activitiesList[i].getSumission!=null){
            if (_activitiesList[i].getSumission!.getNote!=null) {
              note += _activitiesList[i].getSumission!.getNote!*_activitiesList[i].getPercen;
            }
          }
        }else{
          break;
        }
      }
    }
    return Column(
      children: <Widget>[
        const SizedBox(width: double.infinity),
        Text(
          _matter.getName,
          style: _titlle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Definitiva actual: ",
              style: _headerSubTitlle,
            ),
            Text(
              note.toString(),
              style: (note>=3)?_headerSubTitlleApproved:_headerSubTitlleDeprecated,
            ),
          ],
        ),
        LinearPercentIndicator(
          width: _size.width*.95,
          animation: true,
          animationDuration: 1200,
          lineHeight: 20.0,
          percent: percent/100,
          center: Text(
            percent.toString(),
            style: _headerSubTitlle,
          ),
          progressColor: Colors.blue[300],
        ),
        Divider(height: 8, color: Colors.blue[700]),
        const Expanded(child: SizedBox()),
        Divider(height: 8, color: Colors.blue[700]),
        TextButton(
          child: const Text("Salir del grupo"),
          style: _buttonStyle,
          onPressed: ()async{
            Map<String, dynamic> response = await _management.exitMatterRequest();
            _notificateRequest(response);
            Navigator.pushReplacementNamed(context, HomePage.HomeRoute);
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _activitys(BuildContext context){
    List<Widget>  activities = List.empty(growable: true); 
    
    for(int i=0; i<_activitiesList.length; i++){
      activities.add(_card(_activitiesList[i], i));
    }
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "ACTIVIDADES",
                    style: _headerSubTitlle
                  ), 
                  const Expanded(child: SizedBox()),
                  IconButton(icon: const Icon(Icons.add), iconSize: 30, color: Colors.blue[700], onPressed: (){
                      Navigator.pushNamed(context, CreateActivityPage.route);
                    }
                  ),
                  
                ],
              ),
              TextField(
                controller: searchTextField,
                decoration: InputDecoration(
                  hintText: "Filtrar",
                  prefix: Icon(Icons.search_rounded, color: Colors.blue[700]!),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue[700]!)
                  )
                ), 
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: activities,
          ),
        ),
      ],
    );
  }

  Widget _card(ActivityModel activity, int matterIndex){
    TextStyle titleStile = const TextStyle(
      fontSize: 20,
    );
    TextStyle subtitleStile = const TextStyle(
      fontSize: 13,
      color: Colors.grey
    );
    List<Widget> column = List.empty(growable: true);
    List<Widget> row = List.empty(growable: true);
    List<Widget> row1 = List.empty(growable: true);
    Color color = Colors.grey;

    row.add(Text(activity.getName, style: titleStile,));
    row.add(const Expanded(child: SizedBox()));
    if(activity.getSumission!=null){
      if(activity.getSumission!.getNote!=null){
        if(activity.getSumission!.getNote!>=3){
          color = Colors.green;
        }else{
          color = Colors.deepOrange;
        }
        row.add(Text(
          activity.getSumission!.getNote!.toString(),
          style: TextStyle(
            fontSize: 13,
            color: color
          ),
        ));
        row.add(const Icon(Icons.rate_review));
      }
    }
    column.add(ListTile(title: Row(children: row,)));
    column.add(Text(
      (activity.getDescription!=null)?activity.getDescription!:"",
      style: subtitleStile,
    ));
    column.add(Divider(color: color, height: 2.8,));
    row1.add(Text(activity.getSubmissionDate.split(' ')[0], style: subtitleStile,));
    row1.add(const Icon(Icons.calendar_month, color: Colors.grey,));
    row1.add(const Expanded(child: SizedBox()));
    row1.add(Text(activity.getNoDayRecordatories.toString(), style: subtitleStile,));
    row1.add(const Icon(Icons.timelapse, color: Colors.grey,));
    row1.add(const Expanded(child: SizedBox()));
    row1.add(Text(activity.getPercen.toString(), style: subtitleStile,));
    row1.add(const Icon(Icons.percent, color: Colors.grey,));
    column.add(ListTile(title: Row(children: row1,)));

    return GestureDetector(
      onTap: () {
        // print("Activity:"+activity.getId.toString()+"::"+activity.getName);
        Navigator.pushNamed(context, ActivityPage.route);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        child: Card(
          elevation: 10,//sombreado
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              children: column,
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _teacher(BuildContext context){
    
    if(_matter.getTeacher!=null){//hay profesor registrado
      _teacherFullName = _matter.getTeacher!.getFullName;
      if(_matter.getTeacher!.getEmail!=null){
        // print(_matter.getTeacher!.getEmail!);
        _teacherEmail = _matter.getTeacher!.getEmail!;
      }else{
        _teacherEmail = "NO asignado";
      }
      if(_matter.getTeacher!.getCellPhone!=null){
        // print(_matter.getTeacher!.getCellPhone.toString());
        _teacherCellphone = _matter.getTeacher!.getCellPhone.toString();
      }else{
        _teacherCellphone = "NO asignado";
      }
      return Column(
        children: <Widget>[
          Text(
            "DOCENTE",
            style: _headerSubTitlle
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Nombre: "+_teacherFullName, style: _headerSubTitlle,),
                  Text("Correo: "+_teacherEmail, style: _headerSubTitlle,),
                  Text("Celular: "+_teacherCellphone, style: _headerSubTitlle,),
                ],
              ),
              const Expanded(child: SizedBox(),),
              Column(
                children: <Widget>[
                  IconButton(
                    icon:  Icon(Icons.edit, color:Colors.blue[700], size: 35),
                    onPressed: (){_editTeacherRequest(context);}, 
                  ),
                  IconButton(
                    icon:  Icon(Icons.delete, color:Colors.blue[700], size: 30),
                    onPressed: (){_removeTeacherRequest();}, 
                  )
                ],
              )
            ],
          ),
          const Divider(height: 2,),
          const Center(child: Text("Plantillas mensajes ;)")),
          const Divider(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Icon(Icons.mail, color: Colors.white, size: 30,),
                onPressed: (){_sendEmail();},
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Icon(Icons.whatsapp, color: Colors.white, size: 30,),
                onPressed: (){((_matter.getTeacher!.getCellPhone!=null)?_sendWhatsApp():null);},
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Icon(Icons.telegram, color: Colors.white, size: 30,),
                onPressed: (){((_matter.getTeacher!.getCellPhone!=null)?_sendTelegram():null);},
              ),
            ]
          )
        ],
      );
    }else{//NO hay profesor
      return Column(
        children: <Widget>[
          Text(
            "DOCENTE",
            style: _headerSubTitlle
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: _management.streams.teacherIdStream, 
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                    return TextField(
                      controller: _teacherIdTextField,
                      keyboardType: TextInputType.number,
                      style: _cardSubText,
                      decoration: InputDecoration(
                        label: const Text("ID del docente"), 
                        errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      onChanged: _management.streams.changeTeacherId,
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: _management.streams.teacherIdStream, 
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                  return TextButton(
                    onPressed: (snapshot.hasData)?(){_serachTeacherRequest();}:null,
                    child: (_searchTeacherLoading)?_loading():const Icon(Icons.search, color: Colors.white, size: 30,),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[700], 
                    ),
                  );
                },
              ),
            ],
          ),
          Text(
            "Nombre: "+_teacherFullName,
            style: _cardSubText,
            textAlign: TextAlign.left,
          ),
          Text(
            "Correo: "+_teacherEmail,
            style: _cardSubText,
            textAlign: TextAlign.left,
          ),
          Text(
            "Celular: "+_teacherCellphone,
            style: _cardSubText,
            textAlign: TextAlign.left,
          ),
          TextButton(
            onPressed: (_teacherId!="")?(){_addTeacherRequest();}:null,
            child: (_addTeacherLoading)?_loading():const Text("Confirmar seleccion"),
            style: TextButton.styleFrom(
              primary: Colors.white, //color de la letra
              onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
              backgroundColor: Colors.blue[700],
              minimumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
              maximumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
              textStyle: const TextStyle(
                fontSize: 18,
              ),
            )
          )
        ],
      );
    }
  }

  void _serachTeacherRequest()async{
    setState(() {
      _searchTeacherLoading=true;
    });
    Map<String, dynamic> response = await _management.searchTeacherRequest();
    if (response["status"]) {
      _teacherId = response["body"]["id"].toString();
      _teacherFullName = response["body"]["name"]+" "+response["body"]["lastName"];
      _teacherEmail = (response["body"]["email"]==null)?"NO asignado":response["body"]["email"];
      _teacherCellphone = (response["body"]["cellphone"]==null)?"NO asignado":response["body"]["cellphone"];
    }else{
      _notificateRequest(response);
    }
    setState(() {
      _management.streams.resetMatterId();
      _teacherIdTextField.text="";
      _searchTeacherLoading=false;
    });
  }

  void _addTeacherRequest()async{
    setState(() {
      _addTeacherLoading = true;
    });
    Map<String, dynamic> response = await _management.addTeacher(_teacherId);
    setState(() {
      _addTeacherLoading = false;
    });
    _notificateRequest(response);
  }
  
  void _editTeacherRequest(BuildContext context){
    _management.streams.changeTeacherId(_matter.getTeacher!.getId.toString());
    Navigator.pushNamed(context, TeacherPage.editRroute);
  }

  void _removeTeacherRequest()async{
    _teacherId = "";
    _teacherFullName="";
    _teacherEmail="";
    _teacherCellphone="";
    Map<String, dynamic> response = await _management.removeTeacher();
    _notificateRequest(response);
  }

  void _sendEmail(){

  }
  
  void _sendWhatsApp(){
    
  }

  void _sendTelegram(){
    
  }

   Widget _extras(){
    List<Widget> extras = List.empty(growable: true);
    extras.add(Text(
        "Estudiantes registrados",
        style: _headerSubTitlle
      )
    );
    extras.add(_aprobedStudents());
    if (_matter.getAdmin) {
      extras.add(Text(
          "Estudiantes en espera",
          style: _headerSubTitlle
        )
      );
      extras.add(_waitingStudents());
    }
    return Column(
      children: extras,
    );
  }

  Widget _headerContainer(String text, Color color){
    return Container(
      // height: height,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(3, 169, 244, .7),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color
          ),
          textAlign: TextAlign.center,
        )
      ),
    );
  }

  Widget _rowContainer(Widget widget){
    return Container(
      height: 40,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(33, 150, 243, .3),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child:widget
    );
  }

  Widget _aprobedStudents(){
    List<TableRow> rows = List.empty(growable: true);
    TableRow header;
    if(_matter.getAdmin){
      header = TableRow(
        children: <Widget>[
          _headerContainer("Nombre", Colors.black),
          _headerContainer("Explusar", Colors.black),
        ]
      );
    }else{
      header = TableRow(
        children: <Widget>[
          _headerContainer("Nombre", Colors.black),
        ]
      );
    }
    rows.add(header);
    List<StudentModel> students = _matter.getAprobedStudentsList;
  
    for (int i = 0; i < students.length; i++) {
      if(_matter.getAdmin){
      rows.add(TableRow(
          children: <Widget>[
            _rowContainer(
              Center(
                child: Text(
                  students[i].getFullName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
            _rowContainer(
              IconButton(
                icon: const Icon(Icons.not_interested, color: Colors.red),
                onPressed: () => _deniedRequest(students[i].getId)
              )
            ),
          ]
        )
      );
    }else{
      rows.add(TableRow(
          children: <Widget>[
            _rowContainer(Center(
              child: Text(
                  students[i].getFullName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
          ]
        )
      );
    }
      
    }
    return Expanded(
      child: ListView(
        children: <Widget>[
          Table(
            columnWidths: const {
              0: FlexColumnWidth(76),
              1: FlexColumnWidth(24),
            },
            children: rows,
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
          )
        ],
      ),
    );
  }

  Widget _waitingStudents(){
    List<TableRow> rows = List.empty(growable: true);
    rows.add(TableRow(
        children: <Widget>[
          _headerContainer("Nombre", Colors.black),
          _headerContainer("Aceptar", Colors.black),
          _headerContainer("Rechazar", Colors.black),
        ]
      )
    );
    List<StudentModel> students = _matter.getWaitingStudentsList;
    for (int i = 0; i < students.length; i++) {
      rows.add(TableRow(
          children: <Widget>[
            _rowContainer(Center(
              child: Text(
                  students[i].getFullName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
            _rowContainer(IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () => _aprobeRequest(students[i].getId)
              )
            ),
            _rowContainer(IconButton(
              icon: const Icon(Icons.not_interested, color: Colors.red),
              onPressed: () => _deniedRequest(students[i].getId)
              )
            )
          ]
        )
      );
    }
    return Expanded(
      child: ListView(
        children: <Widget>[
          Table(
            columnWidths: const {
              0: FlexColumnWidth(53),
              1: FlexColumnWidth(22),
              2: FlexColumnWidth(25),
            },
            children: rows,
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
          )
        ],
      ),
    );
  }

  _aprobeRequest(String id)async{
    Map<String, dynamic> response = await _management.aprobeSubscriptionRequest(id);
    _notificateRequest(response);
  }

  _deniedRequest(String id)async{
    Map<String, dynamic> response = await _management.deniedSubscriptionRequest(id);
    _notificateRequest(response);
  }

  Widget _loading(){
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 4,
    );
  }

  void _notificateRequest(Map<String, dynamic> response)async{
    if (response["status"]) {
      await _management.viewSubscripciptionsRequest();
      setState(() {});
      ElegantNotification.success(
        title: Text("Accion exitosa", style: _notificationTitle,),
        description:  Text(response["message"], style: _notificationText,),
        toastDuration: const Duration(seconds: 2, milliseconds: 500)
      ).show(context);
    } else {
      if(response["type"]=="info"){
        ElegantNotification.info(
          title: Text("Informacion", style: _notificationTitle,),
          description:  Text(response["message"], style: _notificationText,),
          toastDuration: const Duration(seconds: 4),
        ).show(context);
      }else{
        ElegantNotification.error(
          title: Text("Error", style: _notificationTitle,),
          description:  Text(response["message"], style: _notificationText,),
          toastDuration: const Duration(seconds: 3, milliseconds: 500)
        ).show(context);
      }
    }
    setState(() {});
  }
  
}