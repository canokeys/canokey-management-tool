// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `CanoKey Management Tool`
  String get homeScreenTitle {
    return Intl.message(
      'CanoKey Management Tool',
      name: 'homeScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Please read your CanoKey by clicking the refresh button`
  String get openpgpPrompt {
    return Intl.message(
      'Please read your CanoKey by clicking the refresh button',
      name: 'openpgpPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Your old PIN is incorrect`
  String get openpgpOldPinIncorrect {
    return Intl.message(
      'Your old PIN is incorrect',
      name: 'openpgpOldPinIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Card Info`
  String get openpgpCardInfo {
    return Intl.message(
      'Card Info',
      name: 'openpgpCardInfo',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get openpgpVersion {
    return Intl.message(
      'Version',
      name: 'openpgpVersion',
      desc: '',
      args: [],
    );
  }

  /// `Manufacturer`
  String get openpgpManufacturer {
    return Intl.message(
      'Manufacturer',
      name: 'openpgpManufacturer',
      desc: '',
      args: [],
    );
  }

  /// `Serial Number`
  String get openpgpSN {
    return Intl.message(
      'Serial Number',
      name: 'openpgpSN',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder`
  String get openpgpCardHolder {
    return Intl.message(
      'Card Holder',
      name: 'openpgpCardHolder',
      desc: '',
      args: [],
    );
  }

  /// `Public Key URL`
  String get openpgpPubkeyUrl {
    return Intl.message(
      'Public Key URL',
      name: 'openpgpPubkeyUrl',
      desc: '',
      args: [],
    );
  }

  /// `Keys`
  String get openpgpKeys {
    return Intl.message(
      'Keys',
      name: 'openpgpKeys',
      desc: '',
      args: [],
    );
  }

  /// `Signature`
  String get openpgpSignature {
    return Intl.message(
      'Signature',
      name: 'openpgpSignature',
      desc: '',
      args: [],
    );
  }

  /// `Encryption`
  String get openpgpEncryption {
    return Intl.message(
      'Encryption',
      name: 'openpgpEncryption',
      desc: '',
      args: [],
    );
  }

  /// `Authentication`
  String get openpgpAuthentication {
    return Intl.message(
      'Authentication',
      name: 'openpgpAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `User Interactions`
  String get openpgpUIF {
    return Intl.message(
      'User Interactions',
      name: 'openpgpUIF',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get openpgpUifOff {
    return Intl.message(
      'Off',
      name: 'openpgpUifOff',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get openpgpUifOn {
    return Intl.message(
      'On',
      name: 'openpgpUifOn',
      desc: '',
      args: [],
    );
  }

  /// `Permanent`
  String get openpgpUifPermanent {
    return Intl.message(
      'Permanent',
      name: 'openpgpUifPermanent',
      desc: '',
      args: [],
    );
  }

  /// `Touch Cache Time`
  String get openpgpUifCacheTime {
    return Intl.message(
      'Touch Cache Time',
      name: 'openpgpUifCacheTime',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get openpgpActions {
    return Intl.message(
      'Actions',
      name: 'openpgpActions',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get openpgpChangePin {
    return Intl.message(
      'Change PIN',
      name: 'openpgpChangePin',
      desc: '',
      args: [],
    );
  }

  /// `Change Admin PIN`
  String get openpgpChangeAdminPin {
    return Intl.message(
      'Change Admin PIN',
      name: 'openpgpChangeAdminPin',
      desc: '',
      args: [],
    );
  }

  /// `Interaction has been successfully changed`
  String get openpgpUifChanged {
    return Intl.message(
      'Interaction has been successfully changed',
      name: 'openpgpUifChanged',
      desc: '',
      args: [],
    );
  }

  /// `Touch cache time has been successfully changed`
  String get openpgpUifCacheTimeChanged {
    return Intl.message(
      'Touch cache time has been successfully changed',
      name: 'openpgpUifCacheTimeChanged',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}