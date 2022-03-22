import 'package:flutter/material.dart';
import '../incident.dart';
import 'incident_listtile.dart';

class IncidentPage extends StatelessWidget {
  final List<Incident> _model;
  // store type separately, as the list may be empty and therefore we cannot
  // determine the page's type.
  final IncidentTypes _pageIncidentType;

  const IncidentPage(this._pageIncidentType, this._model, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).canvasColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _model.length,
        itemBuilder: (context, i) => IncidentListTile(_model[i]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  String _getTitle() {
    switch (_pageIncidentType) {
      case IncidentTypes.fire:
        return 'Fire Incidents';
      case IncidentTypes.medical:
        return 'Medical Incidents';
      case IncidentTypes.traffic:
        return 'Traffic Incidents';
      case IncidentTypes.unknown:
      default:
        return 'Unclassified Incidents';
    }
  }
}
