class GlobalSettingModel {
  bool? success;
  String? message; // Added field
  Data? data;

  GlobalSettingModel({this.success, this.message, this.data});

  GlobalSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ContactInfoSection? contactInfo; // Changed from List to Object
  SocialMediaSection? socialMedia; // Changed from List to Object
  BusinessHours? businessHours;
  WebsiteSettings? websiteSettings;
  String? sId;
  bool? isActive;
  String? createdBy;
  List<EmergencyContacts>? emergencyContacts;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? updatedBy;
  PrimaryPhone? primaryPhone;
  PrimaryEmail? primaryEmail;
  PrimaryAddress? primaryAddress;
  PrimaryPhone? primaryWhatsApp; // Casing changed in JSON
  DefaultCurrency? defaultCurrency;
  SupportedLanguages? defaultLanguageInfo;
  List<SupportedCurrencies>? activeCurrencies; // New field
  List<SupportedLanguages>? activeLanguages; // New field
  Map<String, dynamic>? activeSocialMediaWithIcons; // New field
  String? id;

  Data({
    this.contactInfo,
    this.socialMedia,
    this.businessHours,
    this.websiteSettings,
    this.sId,
    this.isActive,
    this.createdBy,
    this.emergencyContacts,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.updatedBy,
    this.primaryPhone,
    this.primaryEmail,
    this.primaryAddress,
    this.primaryWhatsApp,
    this.defaultCurrency,
    this.defaultLanguageInfo,
    this.activeCurrencies,
    this.activeLanguages,
    this.activeSocialMediaWithIcons,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    contactInfo = json['contactInfo'] != null
        ? new ContactInfoSection.fromJson(json['contactInfo'])
        : null;
    socialMedia = json['socialMedia'] != null
        ? new SocialMediaSection.fromJson(json['socialMedia'])
        : null;
    businessHours = json['businessHours'] != null
        ? new BusinessHours.fromJson(json['businessHours'])
        : null;
    websiteSettings = json['websiteSettings'] != null
        ? new WebsiteSettings.fromJson(json['websiteSettings'])
        : null;
    sId = json['_id'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    if (json['emergencyContacts'] != null) {
      emergencyContacts = <EmergencyContacts>[];
      if (json['emergencyContacts'] is List) {
        json['emergencyContacts'].forEach((v) {
          emergencyContacts!.add(new EmergencyContacts.fromJson(v));
        });
      }
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
    primaryPhone = json['primaryPhone'] != null
        ? new PrimaryPhone.fromJson(json['primaryPhone'])
        : null;
    primaryEmail = json['primaryEmail'] != null
        ? new PrimaryEmail.fromJson(json['primaryEmail'])
        : null;
    primaryAddress = json['primaryAddress'] != null
        ? new PrimaryAddress.fromJson(json['primaryAddress'])
        : null;
    primaryWhatsApp = json['primaryWhatsApp'] != null
        ? new PrimaryPhone.fromJson(json['primaryWhatsApp'])
        : null;
    defaultCurrency = json['defaultCurrency'] != null
        ? new DefaultCurrency.fromJson(json['defaultCurrency'])
        : null;
    defaultLanguageInfo = json['defaultLanguageInfo'] != null
        ? new SupportedLanguages.fromJson(json['defaultLanguageInfo'])
        : null;

    // New Lists handling
    if (json['activeCurrencies'] != null) {
      activeCurrencies = <SupportedCurrencies>[];
      json['activeCurrencies'].forEach((v) {
        activeCurrencies!.add(new SupportedCurrencies.fromJson(v));
      });
    }
    if (json['activeLanguages'] != null) {
      activeLanguages = <SupportedLanguages>[];
      json['activeLanguages'].forEach((v) {
        activeLanguages!.add(new SupportedLanguages.fromJson(v));
      });
    }

    activeSocialMediaWithIcons = json['activeSocialMediaWithIcons'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (contactInfo != null) {
      data['contactInfo'] = contactInfo!.toJson();
    }
    if (socialMedia != null) {
      data['socialMedia'] = socialMedia!.toJson();
    }
    if (businessHours != null) {
      data['businessHours'] = businessHours!.toJson();
    }
    if (websiteSettings != null) {
      data['websiteSettings'] = websiteSettings!.toJson();
    }
    data['_id'] = sId;
    data['isActive'] = isActive;
    data['createdBy'] = createdBy;
    if (emergencyContacts != null) {
      data['emergencyContacts'] = emergencyContacts!
          .map((v) => v.toJson())
          .toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['updatedBy'] = updatedBy;
    if (primaryPhone != null) {
      data['primaryPhone'] = primaryPhone!.toJson();
    }
    if (primaryEmail != null) {
      data['primaryEmail'] = primaryEmail!.toJson();
    }
    if (primaryAddress != null) {
      data['primaryAddress'] = primaryAddress!.toJson();
    }
    if (primaryWhatsApp != null) {
      data['primaryWhatsApp'] = primaryWhatsApp!.toJson();
    }
    if (defaultCurrency != null) {
      data['defaultCurrency'] = defaultCurrency!.toJson();
    }
    if (defaultLanguageInfo != null) {
      data['defaultLanguageInfo'] = defaultLanguageInfo!.toJson();
    }
    if (activeCurrencies != null) {
      data['activeCurrencies'] = activeCurrencies!
          .map((v) => v.toJson())
          .toList();
    }
    if (activeLanguages != null) {
      data['activeLanguages'] = activeLanguages!
          .map((v) => v.toJson())
          .toList();
    }
    data['activeSocialMediaWithIcons'] = activeSocialMediaWithIcons;
    data['id'] = id;
    return data;
  }
}

// --- NEW CLASS FOR CONTACT INFO SECTION ---
class ContactInfoSection {
  List<PhoneItem>? phones;
  List<WhatsappItem>? whatsapp;
  List<EmailItem>? emails;
  List<AddressItem>? addresses;

  ContactInfoSection({this.phones, this.whatsapp, this.emails, this.addresses});

  ContactInfoSection.fromJson(Map<String, dynamic> json) {
    if (json['phones'] != null) {
      phones = <PhoneItem>[];
      json['phones'].forEach((v) {
        phones!.add(new PhoneItem.fromJson(v));
      });
    }
    if (json['whatsapp'] != null) {
      whatsapp = <WhatsappItem>[];
      json['whatsapp'].forEach((v) {
        whatsapp!.add(new WhatsappItem.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      emails = <EmailItem>[];
      json['emails'].forEach((v) {
        emails!.add(new EmailItem.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <AddressItem>[];
      json['addresses'].forEach((v) {
        addresses!.add(new AddressItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (phones != null) {
      data['phones'] = phones!.map((v) => v.toJson()).toList();
    }
    if (whatsapp != null) {
      data['whatsapp'] = whatsapp!.map((v) => v.toJson()).toList();
    }
    if (emails != null) {
      data['emails'] = emails!.map((v) => v.toJson()).toList();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhoneItem {
  String? number;
  String? label;
  String? labelAr;
  bool? isPrimary;
  bool? isWhatsApp;
  String? countryCode;
  String? sId;
  String? id;

  PhoneItem({
    this.number,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.isWhatsApp,
    this.countryCode,
    this.sId,
    this.id,
  });

  PhoneItem.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    isWhatsApp = json['isWhatsApp'];
    countryCode = json['countryCode'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = number;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['isWhatsApp'] = isWhatsApp;
    data['countryCode'] = countryCode;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class WhatsappItem {
  String? number;
  String? label;
  String? labelAr;
  bool? isPrimary;
  String? message;
  String? messageAr;
  String? sId;
  String? id;

  WhatsappItem({
    this.number,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.message,
    this.messageAr,
    this.sId,
    this.id,
  });

  WhatsappItem.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    message = json['message'];
    messageAr = json['messageAr'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = number;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['message'] = message;
    data['messageAr'] = messageAr;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class EmailItem {
  String? email;
  String? label;
  String? labelAr;
  bool? isPrimary;
  String? department;
  String? sId;
  String? id;

  EmailItem({
    this.email,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.department,
    this.sId,
    this.id,
  });

  EmailItem.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    department = json['department'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['department'] = department;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class AddressItem {
  String? street;
  String? streetAr;
  String? city;
  String? cityAr;
  String? country;
  String? countryAr;
  String? postalCode;
  String? label;
  String? labelAr;
  bool? isPrimary;
  String? sId;
  String? id;

  AddressItem({
    this.street,
    this.streetAr,
    this.city,
    this.cityAr,
    this.country,
    this.countryAr,
    this.postalCode,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.sId,
    this.id,
  });

  AddressItem.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    streetAr = json['streetAr'];
    city = json['city'];
    cityAr = json['cityAr'];
    country = json['country'];
    countryAr = json['countryAr'];
    postalCode = json['postalCode'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = street;
    data['streetAr'] = streetAr;
    data['city'] = city;
    data['cityAr'] = cityAr;
    data['country'] = country;
    data['countryAr'] = countryAr;
    data['postalCode'] = postalCode;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

// --- NEW CLASS FOR SOCIAL MEDIA SECTION ---
class SocialMediaSection {
  SocialPlatform? facebook;
  SocialPlatform? instagram;
  SocialPlatform? youtube;
  SocialPlatform? twitter;
  SocialPlatform? tiktok;
  SocialPlatform? snapchat;
  SocialPlatform? linkedin;

  SocialMediaSection({
    this.facebook,
    this.instagram,
    this.youtube,
    this.twitter,
    this.tiktok,
    this.snapchat,
    this.linkedin,
  });

  SocialMediaSection.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'] != null
        ? new SocialPlatform.fromJson(json['facebook'])
        : null;
    instagram = json['instagram'] != null
        ? new SocialPlatform.fromJson(json['instagram'])
        : null;
    youtube = json['youtube'] != null
        ? new SocialPlatform.fromJson(json['youtube'])
        : null;
    twitter = json['twitter'] != null
        ? new SocialPlatform.fromJson(json['twitter'])
        : null;
    tiktok = json['tiktok'] != null
        ? new SocialPlatform.fromJson(json['tiktok'])
        : null;
    snapchat = json['snapchat'] != null
        ? new SocialPlatform.fromJson(json['snapchat'])
        : null;
    linkedin = json['linkedin'] != null
        ? new SocialPlatform.fromJson(json['linkedin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (facebook != null) data['facebook'] = facebook!.toJson();
    if (instagram != null) data['instagram'] = instagram!.toJson();
    if (youtube != null) data['youtube'] = youtube!.toJson();
    if (twitter != null) data['twitter'] = twitter!.toJson();
    if (tiktok != null) data['tiktok'] = tiktok!.toJson();
    if (snapchat != null) data['snapchat'] = snapchat!.toJson();
    if (linkedin != null) data['linkedin'] = linkedin!.toJson();
    return data;
  }
}

class SocialPlatform {
  String? url;
  String? username;
  bool? isActive;
  String? desktopIcon;
  String? mobileIcon;

  SocialPlatform({
    this.url,
    this.username,
    this.isActive,
    this.desktopIcon,
    this.mobileIcon,
  });

  SocialPlatform.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    username = json['username'];
    isActive = json['isActive'];
    desktopIcon = json['desktopIcon'];
    mobileIcon = json['mobileIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = url;
    data['username'] = username;
    data['isActive'] = isActive;
    data['desktopIcon'] = desktopIcon;
    data['mobileIcon'] = mobileIcon;
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
      // Handling if holidays might be a different structure later
      if (json['holidays'] is List) {
        json['holidays'].forEach((v) {
          holidays!.add(new Holidays.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = timezone;
    if (workingDays != null) {
      data['workingDays'] = workingDays!.map((v) => v.toJson()).toList();
    }
    if (holidays != null) {
      data['holidays'] = holidays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkingDays {
  String? day;
  String? dayAr; // Added
  bool? isOpen;
  String? openTime;
  String? closeTime;
  String? sId;
  String? id;

  WorkingDays({
    this.day,
    this.dayAr,
    this.isOpen,
    this.openTime,
    this.closeTime,
    this.sId,
    this.id,
  });

  WorkingDays.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    dayAr = json['dayAr'];
    isOpen = json['isOpen'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = day;
    data['dayAr'] = dayAr;
    data['isOpen'] = isOpen;
    data['openTime'] = openTime;
    data['closeTime'] = closeTime;
    data['_id'] = sId;
    data['id'] = id;
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
    data['name'] = name;
    data['date'] = date;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class WebsiteSettings {
  bool? maintenanceMode;
  String? maintenanceMessage; // Added
  String? maintenanceMessageAr; // Added
  bool? allowRegistration;
  bool? requireEmailVerification;
  String? defaultLanguage;
  List<SupportedCurrencies>? supportedCurrencies;
  List<SupportedLanguages>? supportedLanguages;

  WebsiteSettings({
    this.maintenanceMode,
    this.maintenanceMessage,
    this.maintenanceMessageAr,
    this.allowRegistration,
    this.requireEmailVerification,
    this.defaultLanguage,
    this.supportedCurrencies,
    this.supportedLanguages,
  });

  WebsiteSettings.fromJson(Map<String, dynamic> json) {
    maintenanceMode = json['maintenanceMode'];
    maintenanceMessage = json['maintenanceMessage'];
    maintenanceMessageAr = json['maintenanceMessageAr'];
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
    data['maintenanceMode'] = maintenanceMode;
    data['maintenanceMessage'] = maintenanceMessage;
    data['maintenanceMessageAr'] = maintenanceMessageAr;
    data['allowRegistration'] = allowRegistration;
    data['requireEmailVerification'] = requireEmailVerification;
    data['defaultLanguage'] = defaultLanguage;
    if (supportedCurrencies != null) {
      data['supportedCurrencies'] = supportedCurrencies!
          .map((v) => v.toJson())
          .toList();
    }
    if (supportedLanguages != null) {
      data['supportedLanguages'] = supportedLanguages!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class SupportedCurrencies {
  String? code;
  String? name; // Added
  String? nameAr; // Added
  String? symbol;
  double? exchangeRate;
  bool? isDefault;
  bool? isActive; // Added
  String? sId;
  String? id;

  SupportedCurrencies({
    this.code,
    this.name,
    this.nameAr,
    this.symbol,
    this.exchangeRate,
    this.isDefault,
    this.isActive,
    this.sId,
    this.id,
  });

  SupportedCurrencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nameAr = json['nameAr'];
    symbol = json['symbol'];
    if (json['exchangeRate'] != null) {
      if (json['exchangeRate'] is int) {
        exchangeRate = (json['exchangeRate'] as int).toDouble();
      } else {
        exchangeRate = json['exchangeRate'];
      }
    }
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['name'] = name;
    data['nameAr'] = nameAr;
    data['symbol'] = symbol;
    data['exchangeRate'] = exchangeRate;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class SupportedLanguages {
  String? code;
  String? name;
  String? nativeName; // Added
  String? flag; // Added
  bool? isDefault;
  bool? isActive; // Added
  String? sId;
  String? id;

  SupportedLanguages({
    this.code,
    this.name,
    this.nativeName,
    this.flag,
    this.isDefault,
    this.isActive,
    this.sId,
    this.id,
  });

  SupportedLanguages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nativeName = json['nativeName'];
    flag = json['flag'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['name'] = name;
    data['nativeName'] = nativeName;
    data['flag'] = flag;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class EmergencyContacts {
  // Empty in JSON, keeping standard structure
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
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class PrimaryPhone {
  String? number;
  String? label; // Added
  String? labelAr; // Added
  bool? isPrimary;
  bool? isWhatsApp; // Added
  String? countryCode; // Added
  String? message; // Added for PrimaryWhatsApp
  String? messageAr; // Added for PrimaryWhatsApp
  String? sId; // Added
  String? id; // Added

  PrimaryPhone({
    this.number,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.isWhatsApp,
    this.countryCode,
    this.message,
    this.messageAr,
    this.sId,
    this.id,
  });

  PrimaryPhone.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    isWhatsApp = json['isWhatsApp'];
    countryCode = json['countryCode'];
    message = json['message'];
    messageAr = json['messageAr'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = number;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['isWhatsApp'] = isWhatsApp;
    data['countryCode'] = countryCode;
    data['message'] = message;
    data['messageAr'] = messageAr;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class PrimaryEmail {
  String? email;
  String? label; // Added
  String? labelAr; // Added
  bool? isPrimary;
  String? department; // Added
  String? sId; // Added
  String? id; // Added

  PrimaryEmail({
    this.email,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.department,
    this.sId,
    this.id,
  });

  PrimaryEmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    department = json['department'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['department'] = department;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class PrimaryAddress {
  String? street;
  String? streetAr; // Added
  String? city;
  String? cityAr; // Added
  String? country;
  String? countryAr; // Added
  String? postalCode; // Added
  String? label; // Added
  String? labelAr; // Added
  bool? isPrimary;
  String? sId; // Added
  String? id; // Added

  PrimaryAddress({
    this.street,
    this.streetAr,
    this.city,
    this.cityAr,
    this.country,
    this.countryAr,
    this.postalCode,
    this.label,
    this.labelAr,
    this.isPrimary,
    this.sId,
    this.id,
  });

  PrimaryAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    streetAr = json['streetAr'];
    city = json['city'];
    cityAr = json['cityAr'];
    country = json['country'];
    countryAr = json['countryAr'];
    postalCode = json['postalCode'];
    label = json['label'];
    labelAr = json['labelAr'];
    isPrimary = json['isPrimary'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = street;
    data['streetAr'] = streetAr;
    data['city'] = city;
    data['cityAr'] = cityAr;
    data['country'] = country;
    data['countryAr'] = countryAr;
    data['postalCode'] = postalCode;
    data['label'] = label;
    data['labelAr'] = labelAr;
    data['isPrimary'] = isPrimary;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class DefaultCurrency {
  String? code;
  String? name; // Added
  String? nameAr; // Added
  String? symbol;
  int? exchangeRate;
  bool? isDefault;
  bool? isActive; // Added
  String? sId;
  String? id;

  DefaultCurrency({
    this.code,
    this.name,
    this.nameAr,
    this.symbol,
    this.exchangeRate,
    this.isDefault,
    this.isActive,
    this.sId,
    this.id,
  });

  DefaultCurrency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nameAr = json['nameAr'];
    symbol = json['symbol'];
    exchangeRate = json['exchangeRate'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['name'] = name;
    data['nameAr'] = nameAr;
    data['symbol'] = symbol;
    data['exchangeRate'] = exchangeRate;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}
