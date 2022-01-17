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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
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
  String get pollCanoKey {
    return Intl.message(
      'Please read your CanoKey by clicking the refresh button',
      name: 'pollCanoKey',
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

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Successfully changed`
  String get successfullyChanged {
    return Intl.message(
      'Successfully changed',
      name: 'successfullyChanged',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changePin {
    return Intl.message(
      'Change PIN',
      name: 'changePin',
      desc: '',
      args: [],
    );
  }

  /// `New PIN should be at least {min} characters long. The maximum length is 64.`
  String changePinPrompt(Object min) {
    return Intl.message(
      'New PIN should be at least $min characters long. The maximum length is 64.',
      name: 'changePinPrompt',
      desc: '',
      args: [min],
    );
  }

  /// `PIN has been successfully changed.`
  String get pinChanged {
    return Intl.message(
      'PIN has been successfully changed.',
      name: 'pinChanged',
      desc: '',
      args: [],
    );
  }

  /// `Invalid length`
  String get pinInvalidLength {
    return Intl.message(
      'Invalid length',
      name: 'pinInvalidLength',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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

  /// `CanoKey Info`
  String get settingsInfo {
    return Intl.message(
      'CanoKey Info',
      name: 'settingsInfo',
      desc: '',
      args: [],
    );
  }

  /// `Other Settings`
  String get settingsOtherSettings {
    return Intl.message(
      'Other Settings',
      name: 'settingsOtherSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get settingsReset {
    return Intl.message(
      'Reset',
      name: 'settingsReset',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get settingsModel {
    return Intl.message(
      'Model',
      name: 'settingsModel',
      desc: '',
      args: [],
    );
  }

  /// `Firmware Version`
  String get settingsFirmwareVersion {
    return Intl.message(
      'Firmware Version',
      name: 'settingsFirmwareVersion',
      desc: '',
      args: [],
    );
  }

  /// `Serial Number`
  String get settingsSN {
    return Intl.message(
      'Serial Number',
      name: 'settingsSN',
      desc: '',
      args: [],
    );
  }

  /// `Chip ID`
  String get settingsChipId {
    return Intl.message(
      'Chip ID',
      name: 'settingsChipId',
      desc: '',
      args: [],
    );
  }

  /// `PIN Verification`
  String get settingsInputPin {
    return Intl.message(
      'PIN Verification',
      name: 'settingsInputPin',
      desc: '',
      args: [],
    );
  }

  /// `Please input your PIN. The default value is 123456. This PIN is irrelevant to other applets.`
  String get settingsInputPinPrompt {
    return Intl.message(
      'Please input your PIN. The default value is 123456. This PIN is irrelevant to other applets.',
      name: 'settingsInputPinPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Input HOTP when touching`
  String get settingsHotp {
    return Intl.message(
      'Input HOTP when touching',
      name: 'settingsHotp',
      desc: '',
      args: [],
    );
  }

  /// `WebUSB prompt when plug-in`
  String get settingsWebUSB {
    return Intl.message(
      'WebUSB prompt when plug-in',
      name: 'settingsWebUSB',
      desc: '',
      args: [],
    );
  }

  /// `NFC Tag Mode (NDEF)`
  String get settingsNDEF {
    return Intl.message(
      'NFC Tag Mode (NDEF)',
      name: 'settingsNDEF',
      desc: '',
      args: [],
    );
  }

  /// `NFC Tag Readonly`
  String get settingsNDEFReadonly {
    return Intl.message(
      'NFC Tag Readonly',
      name: 'settingsNDEFReadonly',
      desc: '',
      args: [],
    );
  }

  /// `Reset OpenPGP`
  String get settingsResetOpenPGP {
    return Intl.message(
      'Reset OpenPGP',
      name: 'settingsResetOpenPGP',
      desc: '',
      args: [],
    );
  }

  /// `Reset PIV`
  String get settingsResetPIV {
    return Intl.message(
      'Reset PIV',
      name: 'settingsResetPIV',
      desc: '',
      args: [],
    );
  }

  /// `Reset TOTP/HOTP`
  String get settingsResetOATH {
    return Intl.message(
      'Reset TOTP/HOTP',
      name: 'settingsResetOATH',
      desc: '',
      args: [],
    );
  }

  /// `Reset NDEF`
  String get settingsResetNDEF {
    return Intl.message(
      'Reset NDEF',
      name: 'settingsResetNDEF',
      desc: '',
      args: [],
    );
  }

  /// `This operation will RESET all data of {applet}! Please input your PIN to confirm.`
  String settingsResetApplet(Object applet) {
    return Intl.message(
      'This operation will RESET all data of $applet! Please input your PIN to confirm.',
      name: 'settingsResetApplet',
      desc: '',
      args: [applet],
    );
  }

  /// `All data is about to be erased. When you confirm, the CanoKey will blink repeatedly. Touch while it is blinking until success.`
  String get settingsResetAll {
    return Intl.message(
      'All data is about to be erased. When you confirm, the CanoKey will blink repeatedly. Touch while it is blinking until success.',
      name: 'settingsResetAll',
      desc: '',
      args: [],
    );
  }

  /// `Successfully reset`
  String get settingsResetSuccess {
    return Intl.message(
      'Successfully reset',
      name: 'settingsResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `PIN has not been locked yet`
  String get settingsResetConditionNotSatisfying {
    return Intl.message(
      'PIN has not been locked yet',
      name: 'settingsResetConditionNotSatisfying',
      desc: '',
      args: [],
    );
  }

  /// `You did not touch the pad in time`
  String get settingsResetPresenceTestFailed {
    return Intl.message(
      'You did not touch the pad in time',
      name: 'settingsResetPresenceTestFailed',
      desc: '',
      args: [],
    );
  }

  /// `This action will delete the account {name} from your CanoKey. Make sure 2FA has been disabled on the web service.`
  String oathDelete(Object name) {
    return Intl.message(
      'This action will delete the account $name from your CanoKey. Make sure 2FA has been disabled on the web service.',
      name: 'oathDelete',
      desc: '',
      args: [name],
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