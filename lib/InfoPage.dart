import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:convert';
import 'Enseignant.dart';
import 'Semester.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Semester>? _semesters;
  List<Enseignant>? _enseignants;
  int _selectedIndex = 1;
  final _navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.purple,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.info),
      title: const Text("Info"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.contact_mail),
      title: const Text("Contact Us"),
      selectedColor: Colors.orange,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.format_list_bulleted),
      title: const Text("Join"),
      selectedColor: Colors.teal,
    ),
  ];


  @override
  void initState() {
    super.initState();
    _fetchSemester();
    _fetchEnseignant();
  }

  void _fetchSemester() async {
    final response = await http.get(Uri.parse('http://localhost:3000/semestres'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Semester> semesters = [];
      data.forEach((semester) {
        semesters.add(Semester.fromJson(semester));
      });
      setState(() {
        _semesters = semesters;
      });
    } else {
      throw Exception('Failed to fetch semesters');
    }
  }
  void _fetchEnseignant() async {
    final response = await http.get(Uri.parse('http://localhost:3004/enseignants'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Enseignant> enseignants = [];
      data.forEach((enseignant) {
        enseignants.add(Enseignant.fromJson(enseignant));
      });
      setState(() {
        _enseignants = enseignants;
      });
    } else {
      throw Exception('Failed to fetch enseignants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blue,
      ),
      body: _semesters != null && _enseignants != null
          ? ListView.builder(
        itemCount: _semesters!.length,
        itemBuilder: (BuildContext context, int index) {
          final semester = _semesters![index];
          return Card(
            child: Column(
              children: [
                if (semester.numero == 1)
                  const ListTile(
                    title: Text(
                      'Enseignants',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.blue,
                  ),
                if (semester.numero == 1)
                   ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _enseignants!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final enseignant = _enseignants![index];
                    return ListTile(
                      title: Text(enseignant.nom),
                      subtitle: Text(enseignant.email),
                    );
                  },
                ),
                if (semester.numero == 1)
                const ListTile(
                  title: Text(
                    'Plan d"etudes',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.blue,
                ),
                ListTile(
                  title: Text('Semester ${semester.numero}',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: semester.modules.length,
                  itemBuilder: (BuildContext context, int index) {
                    final module = semester.modules[index];
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(module.nom),
                            textColor: Colors.deepPurple,
                          ),
                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: module.matieres.length,
                            itemBuilder: (BuildContext context, int index) {
                              final matiere = module.matieres[index];
                              return ListTile(
                                title: Text(matiere.nom),
                                subtitle: Text(
                                    'Coefficient: ${matiere.coefficient}, Credit: ${matiere.credit}'),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );

  }
}
