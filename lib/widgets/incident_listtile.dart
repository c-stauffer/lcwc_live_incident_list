import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../incident.dart';
import '../util.dart';

class IncidentListTile extends StatelessWidget {
  final Incident _model;

  const IncidentListTile(this._model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _navigate,
      child: ListTile(
        title: Text(_model.title?.toTitleCase() ?? ''),
        subtitle: Text('''     ${_model.location?.toTitleCase()}
       ${_model.intersection?.toTitleCase()}
       ${_model.units?.toTitleCase().replaceAll('<Br> ', '\n       ')}
       ${_model.incidentDate?.toLocal().toFriendlyDisplayString()}'''),
        trailing: const Icon(
          Icons.place,
          size: 32,
        ),
      ),
    );
  }

  void _navigate() {
    if (_model.intersection != null) {
      MapsLauncher.launchQuery(_model.intersection!);
    }
  }
}
