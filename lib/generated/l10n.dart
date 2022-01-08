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

  /// `No CanoKey is selected.`
  String get pollCanceled {
    return Intl.message(
      'No CanoKey is selected.',
      name: 'pollCanceled',
      desc: '',
      args: [],
    );
  }

  /// `CanoKey is busy. Replug it, wait for a moment, and retry.`
  String get networkError {
    return Intl.message(
      'CanoKey is busy. Replug it, wait for a moment, and retry.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `This applet has been locked.`
  String get appletLocked {
    return Intl.message(
      'This applet has been locked.',
      name: 'appletLocked',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect PIN.`
  String get pinIncorrect {
    return Intl.message(
      'Incorrect PIN.',
      name: 'pinIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect PIN. {retries} retries left.`
  String pinRetries(Object retries) {
    return Intl.message(
      'Incorrect PIN. $retries retries left.',
      name: 'pinRetries',
      desc: '',
      args: [retries],
    );
  }

  /// `The provided PIN is too short or too long.`
  String get pinLength {
    return Intl.message(
      'The provided PIN is too short or too long.',
      name: 'pinLength',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Old PIN`
  String get oldPin {
    return Intl.message(
      'Old PIN',
      name: 'oldPin',
      desc: '',
      args: [],
    );
  }

  /// `New PIN`
  String get newPin {
    return Intl.message(
      'New PIN',
      name: 'newPin',
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

  /// `Touch Policies`
  String get openpgpUIF {
    return Intl.message(
      'Touch Policies',
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

  /// `Permanent (Cannot turn off)`
  String get openpgpUifPermanent {
    return Intl.message(
      'Permanent (Cannot turn off)',
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

  /// `Change Touch Cache Time`
  String get openpgpChangeTouchCacheTime {
    return Intl.message(
      'Change Touch Cache Time',
      name: 'openpgpChangeTouchCacheTime',
      desc: '',
      args: [],
    );
  }

  /// `PIN has been successfully changed.`
  String get openpgpPinChanged {
    return Intl.message(
      'PIN has been successfully changed.',
      name: 'openpgpPinChanged',
      desc: '',
      args: [],
    );
  }

  /// `Touch policy has been successfully changed.`
  String get openpgpUifChanged {
    return Intl.message(
      'Touch policy has been successfully changed.',
      name: 'openpgpUifChanged',
      desc: '',
      args: [],
    );
  }

  /// `Touch cache time has been successfully changed.`
  String get openpgpUifCacheTimeChanged {
    return Intl.message(
      'Touch cache time has been successfully changed.',
      name: 'openpgpUifCacheTimeChanged',
      desc: '',
      args: [],
    );
  }

  /// `Change {keyType} Key's Touch Policy`
  String openpgpChangeInteraction(Object keyType) {
    return Intl.message(
      'Change $keyType Key\'s Touch Policy',
      name: 'openpgpChangeInteraction',
      desc: '',
      args: [keyType],
    );
  }

  /// `[none]`
  String get openpgpKeyNone {
    return Intl.message(
      '[none]',
      name: 'openpgpKeyNone',
      desc: '',
      args: [],
    );
  }

  /// `New PIN should be at least {min} characters long. The maximum length is 64.`
  String openpgpChangePinPrompt(Object min) {
    return Intl.message(
      'New PIN should be at least $min characters long. The maximum length is 64.',
      name: 'openpgpChangePinPrompt',
      desc: '',
      args: [min],
    );
  }

  /// `Invalid length`
  String get openpgpPinInvalidLength {
    return Intl.message(
      'Invalid length',
      name: 'openpgpPinInvalidLength',
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