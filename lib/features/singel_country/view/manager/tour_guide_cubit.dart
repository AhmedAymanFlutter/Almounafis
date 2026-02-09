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
      final guideResponse = await repository.fetchCountryGuide(countrySlug);
      if (isClosed) return;

      print("✅ Guide Response Loaded: ${guideResponse.data != null}");

      if (guideResponse.success == true && guideResponse.data != null) {
        emit(TourGuideLoaded(guideResponse.data!));
      } else {
        print("⚠️ No data in response");
        emit(const TourGuideError("No tour guide data available."));
      }
    } catch (e) {
      print("❌ Exception in TourGuideCubit: $e");
      if (!isClosed) emit(TourGuideError("An error occurred: $e"));
    }
  }
}
