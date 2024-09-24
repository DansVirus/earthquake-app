import 'package:earthquake_app/pages/settings_page.dart';
import 'package:earthquake_app/providers/earthquake_data_provider.dart';
import 'package:earthquake_app/util/helper_functions.dart';
import 'package:earthquake_app/widgets/radio_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<EarthquakeDataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake App'),
        actions: [
          IconButton(
            onPressed: _showShortingDialog,
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Consumer<EarthquakeDataProvider>(
        builder: (BuildContext context, EarthquakeDataProvider provider,
                Widget? child) =>
            provider.hasDataLoaded
                ? provider.earthquakeModel!.features!.isEmpty
                    ? const Center(
                        child: Text('No record found'),
                      )
                    : ListView.builder(
                        itemCount: provider.earthquakeModel!.features!.length,
                        itemBuilder: (context, index) {
                          final data = provider
                              .earthquakeModel!.features![index].properties!;
                          return ListTile(
                            title: Text(data.place ?? data.title ?? 'Unknown'),
                            subtitle: Text(getFormattedDateTime(
                                data.time!, 'EEE MMM dd yyyy hh:mm a')),
                            trailing: Chip(
                              avatar: data.alert == null
                                  ? null
                                  : CircleAvatar(
                                      backgroundColor:
                                          provider.getAlertColor(data.alert!),
                                    ),
                              label: Text('${data.mag}'),
                            ),
                          );
                        },
                      )
                : const Center(
                    child: Text('Please wait'),
                  ),
      ),
    );
  }

  void _showShortingDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Sort by'),
              content: Consumer<EarthquakeDataProvider>(
                builder: (context, provider, child) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioGroup(
                      groupValue: provider.orderBy,
                      value: 'magnitude',
                      label: 'Magnitude-Desc',
                      onChange: (value) {
                        provider.orderBy = value!;
                      },
                    ),
                    RadioGroup(
                      groupValue: provider.orderBy,
                      value: 'magnitude-asc',
                      label: 'Magnitude-Asc',
                      onChange: (value) {
                        provider.orderBy = value!;
                      },
                    ),
                    RadioGroup(
                      groupValue: provider.orderBy,
                      value: 'time',
                      label: 'Time-Desc',
                      onChange: (value) {
                        provider.orderBy = value!;
                      },
                    ),
                    RadioGroup(
                      groupValue: provider.orderBy,
                      value: 'time-asc',
                      label: 'Time-Asc',
                      onChange: (value) {
                        provider.orderBy = value!;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ));
  }
}
