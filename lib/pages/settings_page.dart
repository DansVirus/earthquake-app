import 'package:earthquake_app/providers/earthquake_data_provider.dart';
import 'package:earthquake_app/providers/riverpod_earthquake_provider.dart';
import 'package:earthquake_app/util/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final queryParams = ref.watch(queryParamsProvider);
    final city = ref.watch(cityProvider);
    final shouldUseLocation = ref.watch(shouldUseLocationProvider);
    ref.listen(shouldUseLocationProvider, (previous, next) {
      if(next) {
        EasyLoading.show(status: 'Fetching location...');
      } else {
        EasyLoading.dismiss();
      }
    },);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(
            'Time Settings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(queryParams.starttime),
                  trailing: IconButton(
                    onPressed: () async {
                      final date = await selectDate();
                      if (date != null) {
                        ref.read(queryParamsProvider.notifier).setStartTime(date);
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(queryParams.endtime),
                  trailing: IconButton(
                    onPressed: () async {
                      final date = await selectDate();
                      if (date != null) {
                        ref.read(queryParamsProvider.notifier).setEndTime(date);
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                /// No need for this button with riverpod. Whenever a change occurs provider will rebuild the widget with the updated state.
                /*ElevatedButton(
                  onPressed: () {
                    provider.getEarthquakeData();
                    Navigator.pop(context);
                  },
                  child: const Text('Update Time Window'),
                ),*/
              ],
            ),
          ),
          Text(
            'Location Settings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Card(
            child: SwitchListTile(
              title: Text(city ?? 'Your location is unknown'),
              subtitle: city == null
                  ? const Text('Turn on the switch to find your location')
                  : Text(
                      'Earthquake data will be shown within ${queryParams.maxradiuskm} km radius from $city'),
              value: shouldUseLocation,
              onChanged: (value) async {
                await ref.read(queryParamsProvider.notifier).setLocation(value);
                EasyLoading.dismiss();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<String?> selectDate() async {
    final dt = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (dt != null) {
      return getFormattedDateTime(dt.millisecondsSinceEpoch);
    }
    return null;
  }
}
