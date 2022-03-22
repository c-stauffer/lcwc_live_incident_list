import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:lcwc_live_incident_list/incident.dart';

class RssFetcher {
// SEE: https://pub.dev/packages/dart_rss/example
  final _client = http.Client();
  String _url = '';

  RssFetcher(String url) {
    _url = url;
  }

  Future<List<Incident>> fetch() async {
    List<Incident> retList = [];
    await _client.get(Uri.parse(_url)).then((response) {
      return response.body;
    }).then((bodyString) {
      return RssFeed.parse(bodyString);
    }).then((parsedFeed) {
      for (var item in parsedFeed.items) {
        var incidentToAdd = Incident(item.title, item.description, _parseRssDateTime(item.pubDate));
        retList.add(incidentToAdd);
        if (incidentToAdd.copyTo != null && incidentToAdd.copyTo != IncidentTypes.unknown) {
          retList.add(Incident(item.title, item.description, _parseRssDateTime(item.pubDate),
              incidentType: incidentToAdd.copyTo ?? IncidentTypes.unknown));
        }
      }
    });
    return retList;
  }

  DateTime _parseRssDateTime(String? rssDateTimeString) {
    if (rssDateTimeString == null) return DateTime.now();
    bool dateIsUtc = false;
    if (rssDateTimeString.endsWith('GMT')) dateIsUtc = true;
    var parsedDateTime = DateFormat('E, dd MMM yyyy HH:mm:ss zzz', 'en_US').parse(rssDateTimeString, dateIsUtc);
    return parsedDateTime;
  }
}
