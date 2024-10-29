import 'package:earthquake_app/models/query_params.dart';
import 'package:earthquake_app/repositories/weather_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/helper_functions.dart';

// Create an enum
enum OrderFilter {
  magnitude,
  magnitudeAsc,
  time,
  timeAsc,
}

// Map the enum values
const orderFilterValues = {
  OrderFilter.magnitude: 'magnitude',
  OrderFilter.magnitudeAsc: 'magnitude-asc',
  OrderFilter.time: 'time',
  OrderFilter.timeAsc: 'time-asc',
};

// Create a ref of provider with the init state pointing to shorting by time.
final orderFilterProvider = StateProvider((ref) => OrderFilter.time);

// Create a ref of provider of type String(nullable) that initially points to null.
final cityProvider = StateProvider<String?>((ref) => null);

final shouldUseLocationProvider = StateProvider((ref) => false);

final shouldShowLoadingBarProvider = StateProvider((ref) => false);

// Create a ref of provider that returns an instance of WeatherRepository.
final weatherRepositoryProvider = Provider((ref) => WeatherRepository());

final queryParamsProvider = NotifierProvider<QueryParamsProvider, QueryParams>(QueryParamsProvider.new);

final weatherProvider = FutureProvider((ref) {
 final repo = ref.watch(weatherRepositoryProvider);
 final params = ref.watch(queryParamsProvider);
 return repo.getEarthquakeData(params);
});

// Create a provider class that returns a QueryParams obj. reference with initial values.
class QueryParamsProvider extends Notifier<QueryParams> {
  @override
  QueryParams build() {
    final order = orderFilterValues[ref.watch(orderFilterProvider)]!;
    final startTime = getFormattedDateTime(DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch);
    final endTime = getFormattedDateTime(DateTime.now().millisecondsSinceEpoch);
    return QueryParams(
      starttime: startTime,
      endtime: endTime,
      minmagnitude: '4.0',
      orderby: order,
      limit: '500',
      maxradiuskm: '20001.6',
      latitude: '0.0',
      longitude: '0.0',
    );
  }

  // The three methods below are used whenever we need to change the state in one(1,2) or more(3) of the values of QueryParams ref.
  void setStartTime(String date) {
    state = state.copyWith(starttime: date);
  }

  void setEndTime(String date) {
    state = state.copyWith(endtime: date);
  }

  //3. The logic behind location switch.
  Future<void> setLocation(bool value) async {
    ref.read(shouldUseLocationProvider.notifier).state = value;
    if(value) {
      ref.read(shouldShowLoadingBarProvider.notifier).state = true;
      final position = await determinePosition();
      final latitude = position.latitude;
      final longitude = position.longitude;
      ref.read(cityProvider.notifier).state = await getCurrentCity(latitude, longitude);
      ref.read(shouldShowLoadingBarProvider.notifier).state = false;
      state = state.copyWith(maxradiuskm: '500', latitude: '$latitude', longitude: '$longitude');
    } else {
      state = state.copyWith(maxradiuskm: '20001.6', latitude: '0.0', longitude: '0.0');
      ref.read(cityProvider.notifier).state = null;
    }
  }
}
