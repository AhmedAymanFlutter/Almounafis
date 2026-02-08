import 'package:almonafs_flutter/features/home/data/repo/country_repo.dart';
import 'package:almonafs_flutter/features/singel_country/view/manager/tour_guide_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourGuideCubit extends Cubit<TourGuideState> {
  final CountryRepository repository;

  TourGuideCubit(this.repository) : super(TourGuideInitial());

  Future<void> fetchTourGuides(String countrySlug) async {
    print("🚀 Fetching tour guides (Cubit) for slug: $countrySlug");
    if (isClosed) return;
    emit(TourGuideLoading());

    try {
      final response = await repository.getTourGuides(countrySlug);
      if (isClosed) return;

      print("📥 API Status: ${response.status}, Message: ${response.message}");

      if (response.status) {
        final data = response.data; // TourGuideData
        if (data != null) {
          print("✅ Tour Guide Data Loaded: ${data.introduction != null}");
          emit(TourGuideLoaded(data));
        } else {
          print("⚠️ No data in response");
          emit(const TourGuideError("No tour guide data available."));
        }
      } else {
        print("❌ API Error: ${response.message}");
        emit(TourGuideError(response.message));
      }
    } catch (e) {
      print("❌ Exception in TourGuideCubit: $e");
      if (!isClosed) emit(TourGuideError("An error occurred: $e"));
    }
  }
}
