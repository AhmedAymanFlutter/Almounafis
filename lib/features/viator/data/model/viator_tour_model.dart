class ViatorTourResponse {
  bool? success;
  String? source;
  int? count;
  int? total;
  Pagination? pagination;
  List<ViatorTour>? tours;

  ViatorTourResponse({
    this.success,
    this.source,
    this.count,
    this.total,
    this.pagination,
    this.tours,
  });

  ViatorTourResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    source = json['source'];
    count = json['count'];
    total = json['total'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['tours'] != null) {
      tours = <ViatorTour>[];
      json['tours'].forEach((v) {
        tours!.add(ViatorTour.fromJson(v));
      });
    }
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? limit;

  Pagination({this.currentPage, this.totalPages, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
  }
}

class ViatorTour {
  String? sId;
  String? productCode;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  Rating? rating;
  City? city;
  Price? price;
  String? coverImage;
  CancellationPolicy? cancellationPolicy;
  String? slug;
  List<TourImage>? images;
  String? timeZone;
  String? lang;
  PricingInfo? pricingInfo;
  ReviewData? reviews;
  TicketInfo? ticketInfo;
  Supplier? supplier;
  BookingConfirmationSettings? bookingConfirmationSettings;
  BookingRequirements? bookingRequirements;
  SeoData? seo;
  List<Inclusion>? inclusions;
  List<Exclusion>? exclusions;
  List<AdditionalInfo>? additionalInfo;
  Itinerary? itinerary;
  Logistics? logistics;
  List<Tag>? tags;
  List<ProductOption>? productOptions;

  ViatorTour({
    this.sId,
    this.productCode,
    this.title,
    this.titleAr,
    this.description,
    this.descriptionAr,
    this.rating,
    this.city,
    this.price,
    this.coverImage,
    this.cancellationPolicy,
    this.slug,
    this.images,
    this.timeZone,
    this.lang,
    this.pricingInfo,
    this.reviews,
    this.ticketInfo,
    this.supplier,
    this.bookingConfirmationSettings,
    this.bookingRequirements,
    this.seo,
    this.inclusions,
    this.exclusions,
    this.additionalInfo,
    this.itinerary,
    this.logistics,
    this.tags,
    this.productOptions,
  });

  ViatorTour.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productCode = json['productCode'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    coverImage = json['coverImage'];
    cancellationPolicy = json['cancellationPolicy'] != null
        ? CancellationPolicy.fromJson(json['cancellationPolicy'])
        : null;
    slug = json['slug'];
    if (json['images'] != null) {
      images = <TourImage>[];
      json['images'].forEach((v) {
        images!.add(TourImage.fromJson(v));
      });
    }
    timeZone = json['timeZone'];
    lang = json['lang'];
    pricingInfo = json['pricingInfo'] != null
        ? PricingInfo.fromJson(json['pricingInfo'])
        : null;
    reviews = json['reviews'] != null
        ? ReviewData.fromJson(json['reviews'])
        : null;
    ticketInfo = json['ticketInfo'] != null
        ? TicketInfo.fromJson(json['ticketInfo'])
        : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    bookingConfirmationSettings = json['bookingConfirmationSettings'] != null
        ? BookingConfirmationSettings.fromJson(
            json['bookingConfirmationSettings'],
          )
        : null;
    bookingRequirements = json['bookingRequirements'] != null
        ? BookingRequirements.fromJson(json['bookingRequirements'])
        : null;
    seo = json['seo'] != null ? SeoData.fromJson(json['seo']) : null;
    if (json['inclusions'] != null) {
      inclusions = <Inclusion>[];
      json['inclusions'].forEach((v) {
        inclusions!.add(Inclusion.fromJson(v));
      });
    }
    if (json['exclusions'] != null) {
      exclusions = <Exclusion>[];
      json['exclusions'].forEach((v) {
        exclusions!.add(Exclusion.fromJson(v));
      });
    }
    if (json['additionalInfo'] != null) {
      additionalInfo = <AdditionalInfo>[];
      json['additionalInfo'].forEach((v) {
        additionalInfo!.add(AdditionalInfo.fromJson(v));
      });
    }
    itinerary = json['itinerary'] != null
        ? Itinerary.fromJson(json['itinerary'])
        : null;
    logistics = json['logistics'] != null
        ? Logistics.fromJson(json['logistics'])
        : null;
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
    if (json['productOptions'] != null) {
      productOptions = <ProductOption>[];
      json['productOptions'].forEach((v) {
        productOptions!.add(ProductOption.fromJson(v));
      });
    }
  }
}

class Rating {
  num? average;
  int? count;

  Rating({this.average, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    count = json['count'];
  }
}

class City {
  String? sId;
  String? name;
  String? slug;

  City({this.sId, this.name, this.slug});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }
}

class Price {
  num? amount;
  String? currency;

  Price({this.amount, this.currency});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }
}

class CancellationPolicy {
  String? type;
  String? description;
  bool? cancelIfBadWeather;
  bool? cancelIfInsufficientTravelers;
  List<RefundEligibility>? refundEligibility;

  CancellationPolicy({
    this.type,
    this.description,
    this.cancelIfBadWeather,
    this.cancelIfInsufficientTravelers,
    this.refundEligibility,
  });

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    cancelIfBadWeather = json['cancelIfBadWeather'];
    cancelIfInsufficientTravelers = json['cancelIfInsufficientTravelers'];
    if (json['refundEligibility'] != null) {
      refundEligibility = <RefundEligibility>[];
      json['refundEligibility'].forEach((v) {
        refundEligibility!.add(RefundEligibility.fromJson(v));
      });
    }
  }
}

class RefundEligibility {
  int? dayRangeMin;
  int? dayRangeMax;
  int? percentageRefundable;

  RefundEligibility({
    this.dayRangeMin,
    this.dayRangeMax,
    this.percentageRefundable,
  });

  RefundEligibility.fromJson(Map<String, dynamic> json) {
    dayRangeMin = json['dayRangeMin'];
    dayRangeMax = json['dayRangeMax'];
    percentageRefundable = json['percentageRefundable'];
  }
}

class TourImage {
  String? url;
  String? caption;
  bool? isCover;

  TourImage({this.url, this.caption, this.isCover});

  TourImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    caption = json['caption'];
    isCover = json['isCover'];
  }
}

class PricingInfo {
  String? type;
  List<AgeBand>? ageBands;

  PricingInfo({this.type, this.ageBands});

  PricingInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['ageBands'] != null) {
      ageBands = <AgeBand>[];
      json['ageBands'].forEach((v) {
        ageBands!.add(AgeBand.fromJson(v));
      });
    }
  }
}

class AgeBand {
  String? ageBand;
  int? startAge;
  int? endAge;
  int? minTravelersPerBooking;
  int? maxTravelersPerBooking;

  AgeBand({
    this.ageBand,
    this.startAge,
    this.endAge,
    this.minTravelersPerBooking,
    this.maxTravelersPerBooking,
  });

  AgeBand.fromJson(Map<String, dynamic> json) {
    ageBand = json['ageBand'];
    startAge = json['startAge'];
    endAge = json['endAge'];
    minTravelersPerBooking = json['minTravelersPerBooking'];
    maxTravelersPerBooking = json['maxTravelersPerBooking'];
  }
}

class ReviewData {
  int? totalReviews;
  List<ReviewCountTotals>? reviewCountTotals;
  // sources omitted for brevity as usually totalReviews is used

  ReviewData({this.totalReviews, this.reviewCountTotals});

  ReviewData.fromJson(Map<String, dynamic> json) {
    totalReviews = json['totalReviews'];
    if (json['reviewCountTotals'] != null) {
      reviewCountTotals = <ReviewCountTotals>[];
      json['reviewCountTotals'].forEach((v) {
        reviewCountTotals!.add(ReviewCountTotals.fromJson(v));
      });
    }
  }
}

class ReviewCountTotals {
  int? rating;
  int? count;

  ReviewCountTotals({this.rating, this.count});

  ReviewCountTotals.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }
}

class TicketInfo {
  List<String>? ticketTypes;
  String? ticketTypeDescription;
  String? ticketsPerBooking;
  String? ticketsPerBookingDescription;

  TicketInfo({
    this.ticketTypes,
    this.ticketTypeDescription,
    this.ticketsPerBooking,
    this.ticketsPerBookingDescription,
  });

  TicketInfo.fromJson(Map<String, dynamic> json) {
    ticketTypes = json['ticketTypes'] != null
        ? List<String>.from(json['ticketTypes'])
        : null;
    ticketTypeDescription = json['ticketTypeDescription'];
    ticketsPerBooking = json['ticketsPerBooking'];
    ticketsPerBookingDescription = json['ticketsPerBookingDescription'];
  }
}

class Supplier {
  String? name;
  String? reference;

  Supplier({this.name, this.reference});

  Supplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    reference = json['reference'];
  }
}

class BookingConfirmationSettings {
  String? bookingCutoffType;
  int? bookingCutoffInMinutes;
  String? confirmationType;

  BookingConfirmationSettings({
    this.bookingCutoffType,
    this.bookingCutoffInMinutes,
    this.confirmationType,
  });

  BookingConfirmationSettings.fromJson(Map<String, dynamic> json) {
    bookingCutoffType = json['bookingCutoffType'];
    bookingCutoffInMinutes = json['bookingCutoffInMinutes'];
    confirmationType = json['confirmationType'];
  }
}

class BookingRequirements {
  int? minTravelersPerBooking;
  int? maxTravelersPerBooking;
  bool? requiresAdultForBooking;

  BookingRequirements({
    this.minTravelersPerBooking,
    this.maxTravelersPerBooking,
    this.requiresAdultForBooking,
  });

  BookingRequirements.fromJson(Map<String, dynamic> json) {
    minTravelersPerBooking = json['minTravelersPerBooking'];
    maxTravelersPerBooking = json['maxTravelersPerBooking'];
    requiresAdultForBooking = json['requiresAdultForBooking'];
  }
}

class SeoData {
  String? metaTitle;
  String? metaDescription;
  String? slugUrl;
  String? ogTitle;
  String? ogDescription;
  String? ogImage;

  SeoData({
    this.metaTitle,
    this.metaDescription,
    this.slugUrl,
    this.ogTitle,
    this.ogDescription,
    this.ogImage,
  });

  SeoData.fromJson(Map<String, dynamic> json) {
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    slugUrl = json['slugUrl'];
    ogTitle = json['ogTitle'];
    ogDescription = json['ogDescription'];
    ogImage = json['ogImage'];
  }
}

class Inclusion {
  String? category;
  String? categoryDescription;
  String? type;
  String? typeDescription;
  String? otherDescription;
  String? description;

  Inclusion({
    this.category,
    this.categoryDescription,
    this.type,
    this.typeDescription,
    this.otherDescription,
    this.description,
  });

  Inclusion.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryDescription = json['categoryDescription'];
    type = json['type'];
    typeDescription = json['typeDescription'];
    otherDescription = json['otherDescription'];
    description = json['description'];
  }
}

class Exclusion {
  String? category;
  String? categoryDescription;
  String? type;
  String? typeDescription;
  String? description;

  Exclusion({
    this.category,
    this.categoryDescription,
    this.type,
    this.typeDescription,
    this.description,
  });

  Exclusion.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryDescription = json['categoryDescription'];
    type = json['type'];
    typeDescription = json['typeDescription'];
    description = json['description'];
  }
}

class AdditionalInfo {
  String? type;
  String? description;

  AdditionalInfo({this.type, this.description});

  AdditionalInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
  }
}

class Itinerary {
  String? itineraryType;
  bool? skipTheLine;
  bool? privateTour;
  int? maxTravelersInSharedTour;
  DurationInfo? duration;
  List<ItineraryItem>? itineraryItems;

  Itinerary({
    this.itineraryType,
    this.skipTheLine,
    this.privateTour,
    this.maxTravelersInSharedTour,
    this.duration,
    this.itineraryItems,
  });

  Itinerary.fromJson(Map<String, dynamic> json) {
    itineraryType = json['itineraryType'];
    skipTheLine = json['skipTheLine'];
    privateTour = json['privateTour'];
    maxTravelersInSharedTour = json['maxTravelersInSharedTour'];
    duration = json['duration'] != null
        ? DurationInfo.fromJson(json['duration'])
        : null;
    if (json['itineraryItems'] != null) {
      itineraryItems = <ItineraryItem>[];
      json['itineraryItems'].forEach((v) {
        itineraryItems!.add(ItineraryItem.fromJson(v));
      });
    }
  }
}

class DurationInfo {
  int? fixedDurationInMinutes;

  DurationInfo({this.fixedDurationInMinutes});

  DurationInfo.fromJson(Map<String, dynamic> json) {
    fixedDurationInMinutes = json['fixedDurationInMinutes'];
  }
}

class ItineraryItem {
  PointOfInterestLocation? pointOfInterestLocation;
  DurationInfo? duration;
  bool? passByWithoutStopping;
  String? admissionIncluded;
  String? description;

  ItineraryItem({
    this.pointOfInterestLocation,
    this.duration,
    this.passByWithoutStopping,
    this.admissionIncluded,
    this.description,
  });

  ItineraryItem.fromJson(Map<String, dynamic> json) {
    pointOfInterestLocation = json['pointOfInterestLocation'] != null
        ? PointOfInterestLocation.fromJson(json['pointOfInterestLocation'])
        : null;
    duration = json['duration'] != null
        ? DurationInfo.fromJson(json['duration'])
        : null;
    passByWithoutStopping = json['passByWithoutStopping'];
    admissionIncluded = json['admissionIncluded'];
    description = json['description'];
  }
}

class PointOfInterestLocation {
  LocationRef? location;
  int? attractionId;

  PointOfInterestLocation({this.location, this.attractionId});

  PointOfInterestLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? LocationRef.fromJson(json['location'])
        : null;
    attractionId = json['attractionId'];
  }
}

class LocationRef {
  String? ref;

  LocationRef({this.ref});

  LocationRef.fromJson(Map<String, dynamic> json) {
    ref = json['ref'];
  }
}

class Logistics {
  List<LogisticsPoint>? start;
  List<LogisticsPoint>? end;
  Redemption? redemption;
  TravelerPickup? travelerPickup;

  Logistics({this.start, this.end, this.redemption, this.travelerPickup});

  Logistics.fromJson(Map<String, dynamic> json) {
    if (json['start'] != null) {
      start = <LogisticsPoint>[];
      json['start'].forEach((v) {
        start!.add(LogisticsPoint.fromJson(v));
      });
    }
    if (json['end'] != null) {
      end = <LogisticsPoint>[];
      json['end'].forEach((v) {
        end!.add(LogisticsPoint.fromJson(v));
      });
    }
    redemption = json['redemption'] != null
        ? Redemption.fromJson(json['redemption'])
        : null;
    travelerPickup = json['travelerPickup'] != null
        ? TravelerPickup.fromJson(json['travelerPickup'])
        : null;
  }
}

class LogisticsPoint {
  String? description;

  LogisticsPoint({this.description});

  LogisticsPoint.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }
}

class Redemption {
  String? redemptionType;
  String? specialInstructions;

  Redemption({this.redemptionType, this.specialInstructions});

  Redemption.fromJson(Map<String, dynamic> json) {
    redemptionType = json['redemptionType'];
    specialInstructions = json['specialInstructions'];
  }
}

class TravelerPickup {
  String? pickupOptionType;
  bool? allowCustomTravelerPickup;

  TravelerPickup({this.pickupOptionType, this.allowCustomTravelerPickup});

  TravelerPickup.fromJson(Map<String, dynamic> json) {
    pickupOptionType = json['pickupOptionType'];
    allowCustomTravelerPickup = json['allowCustomTravelerPickup'];
  }
}

class Tag {
  int? id;
  String? name;

  Tag({this.id, this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class ProductOption {
  String? productOptionCode;
  String? description;
  String? title;
  List<LanguageGuide>? languageGuides;

  ProductOption({
    this.productOptionCode,
    this.description,
    this.title,
    this.languageGuides,
  });

  ProductOption.fromJson(Map<String, dynamic> json) {
    productOptionCode = json['productOptionCode'];
    description = json['description'];
    title = json['title'];
    if (json['languageGuides'] != null) {
      languageGuides = <LanguageGuide>[];
      json['languageGuides'].forEach((v) {
        languageGuides!.add(LanguageGuide.fromJson(v));
      });
    }
  }
}

class LanguageGuide {
  String? type;
  String? language;
  String? legacyGuide;

  LanguageGuide({this.type, this.language, this.legacyGuide});

  LanguageGuide.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    language = json['language'];
    legacyGuide = json['legacyGuide'];
  }
}
