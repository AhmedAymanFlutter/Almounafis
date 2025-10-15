class GlobalSettingModel {
  bool? success;
  Data? data;

  GlobalSettingModel({this.success, this.data});

  GlobalSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  BusinessHours? businessHours;
  WebsiteSettings? websiteSettings;
  String? sId;
  List<ContactInfo>? contactInfo;
  List<SocialMedia>? socialMedia;
  List<EmergencyContacts>? emergencyContacts;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  PrimaryPhone? primaryPhone;
  PrimaryPhone? primaryWhatsapp;
  PrimaryEmail? primaryEmail;
  PrimaryAddress? primaryAddress;
  DefaultCurrency? defaultCurrency;
  SupportedLanguages? defaultLanguageInfo;
  String? id;

  Data(
      {this.businessHours,
      this.websiteSettings,
      this.sId,
      this.contactInfo,
      this.socialMedia,
      this.emergencyContacts,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.primaryPhone,
      this.primaryWhatsapp,
      this.primaryEmail,
      this.primaryAddress,
      this.defaultCurrency,
      this.defaultLanguageInfo,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    businessHours = json['businessHours'] != null
        ? new BusinessHours.fromJson(json['businessHours'])
        : null;
    websiteSettings = json['websiteSettings'] != null
        ? new WebsiteSettings.fromJson(json['websiteSettings'])
        : null;
    sId = json['_id'];
    if (json['contactInfo'] != null) {
      contactInfo = <ContactInfo>[];
      json['contactInfo'].forEach((v) {
        contactInfo!.add(new ContactInfo.fromJson(v));
      });
    }
    if (json['socialMedia'] != null) {
      socialMedia = <SocialMedia>[];
      json['socialMedia'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
    if (json['emergencyContacts'] != null) {
      emergencyContacts = <EmergencyContacts>[];
      json['emergencyContacts'].forEach((v) {
        emergencyContacts!.add(new EmergencyContacts.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    primaryPhone = json['primaryPhone'] != null
        ? new PrimaryPhone.fromJson(json['primaryPhone'])
        : null;
    primaryWhatsapp = json['primaryWhatsapp'] != null
        ? new PrimaryPhone.fromJson(json['primaryWhatsapp'])
        : null;
    primaryEmail = json['primaryEmail'] != null
        ? new PrimaryEmail.fromJson(json['primaryEmail'])
        : null;
    primaryAddress = json['primaryAddress'] != null
        ? new PrimaryAddress.fromJson(json['primaryAddress'])
        : null;
    defaultCurrency = json['defaultCurrency'] != null
        ? new DefaultCurrency.fromJson(json['defaultCurrency'])
        : null;
    defaultLanguageInfo = json['defaultLanguageInfo'] != null
        ? new SupportedLanguages.fromJson(json['defaultLanguageInfo'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessHours != null) {
      data['businessHours'] = this.businessHours!.toJson();
    }
    if (this.websiteSettings != null) {
      data['websiteSettings'] = this.websiteSettings!.toJson();
    }
    data['_id'] = this.sId;
    if (this.contactInfo != null) {
      data['contactInfo'] = this.contactInfo!.map((v) => v.toJson()).toList();
    }
    if (this.socialMedia != null) {
      data['socialMedia'] = this.socialMedia!.map((v) => v.toJson()).toList();
    }
    if (this.emergencyContacts != null) {
      data['emergencyContacts'] =
          this.emergencyContacts!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.primaryPhone != null) {
      data['primaryPhone'] = this.primaryPhone!.toJson();
    }
    if (this.primaryWhatsapp != null) {
      data['primaryWhatsapp'] = this.primaryWhatsapp!.toJson();
    }
    if (this.primaryEmail != null) {
      data['primaryEmail'] = this.primaryEmail!.toJson();
    }
    if (this.primaryAddress != null) {
      data['primaryAddress'] = this.primaryAddress!.toJson();
    }
    if (this.defaultCurrency != null) {
      data['defaultCurrency'] = this.defaultCurrency!.toJson();
    }
    if (this.defaultLanguageInfo != null) {
      data['defaultLanguageInfo'] = this.defaultLanguageInfo!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class BusinessHours {
  String? timezone;
  List<WorkingDays>? workingDays;
  List<Holidays>? holidays;

  BusinessHours({this.timezone, this.workingDays, this.holidays});

  BusinessHours.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    if (json['workingDays'] != null) {
      workingDays = <WorkingDays>[];
      json['workingDays'].forEach((v) {
        workingDays!.add(new WorkingDays.fromJson(v));
      });
    }
    if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    if (this.workingDays != null) {
      data['workingDays'] = this.workingDays!.map((v) => v.toJson()).toList();
    }
    if (this.holidays != null) {
      data['holidays'] = this.holidays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkingDays {
  String? day;
  bool? isOpen;
  String? openTime;
  String? closeTime;
  String? sId;
  String? id;

  WorkingDays(
      {this.day,
      this.isOpen,
      this.openTime,
      this.closeTime,
      this.sId,
      this.id});

  WorkingDays.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    isOpen = json['isOpen'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['isOpen'] = this.isOpen;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class Holidays {
  String? name;
  String? date;
  String? sId;
  String? id;

  Holidays({this.name, this.date, this.sId, this.id});

  Holidays.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class WebsiteSettings {
  bool? maintenanceMode;
  bool? allowRegistration;
  bool? requireEmailVerification;
  String? defaultLanguage;
  List<SupportedCurrencies>? supportedCurrencies;
  List<SupportedLanguages>? supportedLanguages;

  WebsiteSettings(
      {this.maintenanceMode,
      this.allowRegistration,
      this.requireEmailVerification,
      this.defaultLanguage,
      this.supportedCurrencies,
      this.supportedLanguages});

  WebsiteSettings.fromJson(Map<String, dynamic> json) {
    maintenanceMode = json['maintenanceMode'];
    allowRegistration = json['allowRegistration'];
    requireEmailVerification = json['requireEmailVerification'];
    defaultLanguage = json['defaultLanguage'];
    if (json['supportedCurrencies'] != null) {
      supportedCurrencies = <SupportedCurrencies>[];
      json['supportedCurrencies'].forEach((v) {
        supportedCurrencies!.add(new SupportedCurrencies.fromJson(v));
      });
    }
    if (json['supportedLanguages'] != null) {
      supportedLanguages = <SupportedLanguages>[];
      json['supportedLanguages'].forEach((v) {
        supportedLanguages!.add(new SupportedLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenanceMode'] = this.maintenanceMode;
    data['allowRegistration'] = this.allowRegistration;
    data['requireEmailVerification'] = this.requireEmailVerification;
    data['defaultLanguage'] = this.defaultLanguage;
    if (this.supportedCurrencies != null) {
      data['supportedCurrencies'] =
          this.supportedCurrencies!.map((v) => v.toJson()).toList();
    }
    if (this.supportedLanguages != null) {
      data['supportedLanguages'] =
          this.supportedLanguages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportedCurrencies {
  String? code;
  String? symbol;
  double? exchangeRate; // Keep as double?
  bool? isDefault;
  String? sId;
  String? id;

  SupportedCurrencies({
    this.code,
    this.symbol,
    this.exchangeRate,
    this.isDefault,
    this.sId,
    this.id,
  });

  SupportedCurrencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    
    // Fix: Handle both int and double values for exchangeRate
    if (json['exchangeRate'] != null) {
      if (json['exchangeRate'] is int) {
        exchangeRate = (json['exchangeRate'] as int).toDouble();
      } else if (json['exchangeRate'] is double) {
        exchangeRate = json['exchangeRate'];
      } else {
        exchangeRate = null;
      }
    }
    
    isDefault = json['isDefault'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['exchangeRate'] = exchangeRate;
    data['isDefault'] = isDefault;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class SupportedLanguages {
  String? code;
  String? name;
  bool? isDefault;
  String? sId;
  String? id;

  SupportedLanguages({this.code, this.name, this.isDefault, this.sId, this.id});

  SupportedLanguages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    isDefault = json['isDefault'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class ContactInfo {
  String? type;
  Value? value;

  ContactInfo({this.type, this.value});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Value {
  String? number;
  bool? isPrimary;
  String? email;
  String? street;
  String? city;
  String? country;

  Value(
      {this.number,
      this.isPrimary,
      this.email,
      this.street,
      this.city,
      this.country});

  Value.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    isPrimary = json['isPrimary'];
    email = json['email'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['isPrimary'] = this.isPrimary;
    data['email'] = this.email;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}

class SocialMedia {
  String? platform;
  String? url;
  String? desktopIconUrl;
  String? mobileIconUrl;
  String? sId;
  String? id;

  SocialMedia(
      {this.platform,
      this.url,
      this.desktopIconUrl,
      this.mobileIconUrl,
      this.sId,
      this.id});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    url = json['url'];
    desktopIconUrl = json['desktopIconUrl'];
    mobileIconUrl = json['mobileIconUrl'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['url'] = this.url;
    data['desktopIconUrl'] = this.desktopIconUrl;
    data['mobileIconUrl'] = this.mobileIconUrl;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class EmergencyContacts {
  String? name;
  String? phone;
  String? role;
  String? sId;
  String? id;

  EmergencyContacts({this.name, this.phone, this.role, this.sId, this.id});

  EmergencyContacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}

class PrimaryPhone {
  String? number;
  bool? isPrimary;

  PrimaryPhone({this.number, this.isPrimary});

  PrimaryPhone.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class PrimaryEmail {
  String? email;
  bool? isPrimary;

  PrimaryEmail({this.email, this.isPrimary});

  PrimaryEmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class PrimaryAddress {
  String? street;
  String? city;
  String? country;
  bool? isPrimary;

  PrimaryAddress({this.street, this.city, this.country, this.isPrimary});

  PrimaryAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    country = json['country'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class DefaultCurrency {
  String? code;
  String? symbol;
  int? exchangeRate;
  bool? isDefault;
  String? sId;
  String? id;

  DefaultCurrency(
      {this.code,
      this.symbol,
      this.exchangeRate,
      this.isDefault,
      this.sId,
      this.id});

  DefaultCurrency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    exchangeRate = json['exchangeRate'];
    isDefault = json['isDefault'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['symbol'] = this.symbol;
    data['exchangeRate'] = this.exchangeRate;
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    data['id'] = this.id;
    return data;
  }
}