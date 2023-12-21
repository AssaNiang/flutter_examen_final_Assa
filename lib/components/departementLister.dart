import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class DepartementLister extends StatefulWidget {
  const DepartementLister({super.key, required this.regionCode});

  final String regionCode;

  @override
  State<DepartementLister> createState() => _DepartementListerState();
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementList?> departements;

  @override
  void initState(){
    super.initState();
    loadDepartements();
  }  

  void loadDepartements(){
    setState(() {
      departements = DepartementService.getDepartements(widget.regionCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: departements,
      builder: (context, snapshot){
        //Les données sont arrivées sans erreurs:
        if(snapshot.hasData){
          List<Departement> departements = snapshot.data!.departements;
          return ListView.builder(
            itemCount: snapshot.data!.departements.length,
            itemBuilder: (context, index){
              Departement departement = departements[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // You can customize Card properties here
                  child: ListTile(
                    title: Text("${departement.nom} de ${departement.code} - ${departement.codeRegion}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(departement.nom),
                      ],
                    ),
                    // You can handle onTap here
                    onTap: () {
                      // Add your onTap logic
                    },
                  ),
                ),
              );
            }
          );
          // La requests a provoqué une erreur
        } else if (snapshot.hasError){
          return Text("error: ${snapshot.error}");
        }

        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          )
        );
      }
    );
  }
}
