import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/communeLister.dart';
import 'package:flutter_examen1/models/commune.module.dart';

class CommunePage extends StatelessWidget {
  const CommunePage({Key? key, required this.regionCode}) : super(key: key);

  final String regionCode;

  void _showCommuneDetails(BuildContext context, Commune commune) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(commune.nom),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Code de la commune: ${commune.code}"),
              Text("Code postal: ${commune.codesPostaux.isNotEmpty ? commune.codesPostaux[0] : ''}"),
              Text("Population: ${commune.population}"),
              Text("SIREN: ${commune.siren}"),
              Text("Code EPCI: ${commune.codeEpci}"),
              Text("Code région: ${commune.codeRegion}"),
              // Ajoutez d'autres informations de la commune selon vos besoins
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Département: $regionCode'),
      ),
      body: Flexible(
        child: CommuneLister(
          codeDepartement: regionCode,
          onCommuneTap: (commune) => _showCommuneDetails(context, commune),
        ),
      ),
    );
  }
}
