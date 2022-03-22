import 'package:lcwc_live_incident_list/util.dart';

enum IncidentTypes { medical, fire, traffic, unknown }

class Incident {
  final List<String> _trafficUnitHints = ['squad'];
  final List<String> _fireUnitHints = [
    'engine',
    'ladder',
    'traffic',
    'duty chief'
  ];
  final List<String> _medicalUnitHints = [
    'ambulance',
    'medic',
    'ems',
    'intermediate'
  ];
  final List<String> _fireTitleHints = ['fire'];

  String? _description;
  String? title;
  String? location;
  String? intersection;
  String? units;
  DateTime? incidentDate;
  IncidentTypes incidentType = IncidentTypes.unknown;
  IncidentTypes? copyTo;

  Incident(this.title, String? description, this.incidentDate,
      {IncidentTypes incidentType = IncidentTypes.unknown}) {
    _description = description;
    _parseDescription();
    this.incidentType = incidentType == IncidentTypes.unknown
        ? _determineIncidentType()
        : incidentType;
  }

  void _parseDescription() {
    var splitDesc = _description!.split(';');
    if (splitDesc.length < 3) return;
    location = Utils.cleanString(splitDesc[0]);
    intersection = Utils.cleanString(splitDesc[1]);
    units = Utils.cleanString(splitDesc[2]);
  }

  IncidentTypes _determineIncidentType() {
    var titleLower = title!.toLowerCase();
    var unitsSplit = units!
        .split('\n')
        .where((item) => item.trim().isNotEmpty)
        .map((item) => item.toLowerCase());

    if (_trafficUnitHints
        .any((h) => unitsSplit.any((element) => element.contains(h)))) {
      if (_fireTitleHints.any((h) => titleLower.contains(h))) {
        copyTo = IncidentTypes.fire;
      }
      return IncidentTypes.traffic;
    }
    if (_fireUnitHints
        .any((h) => unitsSplit.any((element) => element.contains(h)))) {
      return IncidentTypes.fire;
    }
    if (_medicalUnitHints
        .any((h) => unitsSplit.any((element) => element.contains(h)))) {
      return IncidentTypes.medical;
    }
    if (_fireTitleHints
        .any((h) => unitsSplit.any((element) => element.contains(h)))) {
      return IncidentTypes.fire;
    }
    // default, if didn't find a match
    // TODO: maybe log this somewhere so that it can be worked in later
    return IncidentTypes.traffic;
  }
}
