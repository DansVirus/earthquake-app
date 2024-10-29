import 'package:earthquake_app/pages/settings_page.dart';
import 'package:earthquake_app/providers/earthquake_data_provider.dart';
import 'package:earthquake_app/providers/riverpod_earthquake_provider.dart';
import 'package:earthquake_app/util/helper_functions.dart';
import 'package:earthquake_app/widgets/radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final weather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake App'),
        actions: [
          IconButton(
            onPressed: _showShortingDialog,
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage())),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: weather.when(
        data: (model) => ListView.builder(
          itemCount: model.features!.length,
          itemBuilder: (context, index) {
            final data = model.features![index].properties!;
            return ListTile(
              title: Text(data.place ?? data.title ?? 'Unknown'),
              subtitle: Text(getFormattedDateTime(
                  data.time!, 'EEE MMM dd yyyy hh:mm a')),
              trailing: Chip(
                avatar: data.alert == null
                    ? null
                    : CircleAvatar(
                  backgroundColor:
                  getAlertColor(data.alert!),
                ),
                label: Text('${data.mag}'),
              ),
            );
          },
        )
        ,
        error: (e, trace) => Center(child: Text('Error: ${e.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  void _showShortingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          final groupValue = orderFilterValues[ref.read(orderFilterProvider)]!;
          return AlertDialog(
            title: const Text('Sort by'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioGroup(
                  groupValue: groupValue,
                  value: 'magnitude',
                  label: 'Magnitude-Desc',
                  onChange: (value) {
                    Navigator.pop(context);
                    ref.read(orderFilterProvider.notifier).update((state) => state = OrderFilter.magnitude);
                  },
                ),
                RadioGroup(
                  groupValue: groupValue,
                  value: 'magnitude-asc',
                  label: 'Magnitude-Asc',
                  onChange: (value) {
                    Navigator.pop(context);
                    ref.read(orderFilterProvider.notifier).update((state) => state = OrderFilter.magnitudeAsc);
                  },
                ),
                RadioGroup(
                  groupValue: groupValue,
                  value: 'time',
                  label: 'Time-Desc',
                  onChange: (value) {
                    Navigator.pop(context);
                    ref.read(orderFilterProvider.notifier).update((state) => state = OrderFilter.time);
                  },
                ),
                RadioGroup(
                  groupValue: groupValue,
                  value: 'time-asc',
                  label: 'Time-Asc',
                  onChange: (value) {
                    Navigator.pop(context);
                    ref.read(orderFilterProvider.notifier).update((state) => state = OrderFilter.timeAsc);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        } );
  }
}
