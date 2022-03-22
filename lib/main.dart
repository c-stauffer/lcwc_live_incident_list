import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lcwc_live_incident_list/rss_fetcher.dart';
import 'package:lcwc_live_incident_list/incident.dart';
import 'package:lcwc_live_incident_list/widgets/incident_page.dart';

void main() {
  runApp(const LcwcLiveIncidentList());
}

class LcwcLiveIncidentList extends StatelessWidget {
  const LcwcLiveIncidentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'LCWC Live Incident List',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        primaryColorLight: Colors.amber,
        primaryColorDark: Colors.amber,
        dividerColor: Colors.deepOrange,
        secondaryHeaderColor: Colors.amber,
        indicatorColor: Colors.deepOrange,
      ),
      home: const IncidentListHomePage(title: 'LCWC Live Incident List'),
    );
  }
}

class IncidentListHomePage extends StatefulWidget {
  const IncidentListHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<IncidentListHomePage> createState() => _IncidentListHomePageState();
}

class _IncidentListHomePageState extends State<IncidentListHomePage> {
  List<Incident>? list;
  var dataFetcher = RssFetcher('http://webcad.lcwc911.us/Pages/Public/LiveIncidentsFeed.aspx');
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final List<IncidentTypes> typesToDisplay = [IncidentTypes.fire, IncidentTypes.medical, IncidentTypes.traffic];

    return PageView(
      scrollBehavior: AppScrollBehavior(),
      children: typesToDisplay
          .map(
            (e) => Scaffold(
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: refreshList,
                  child: IncidentPage(
                      e,
                      list == null
                          ? List<Incident>.empty()
                          : list!.where((element) => element.incidentType == e).toList()),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    var fetchedData = await dataFetcher.fetch();
    setState(() {
      list = fetchedData;
    });
    return;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
