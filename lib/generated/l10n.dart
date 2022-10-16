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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
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

  /// `Press`
  String get homePress {
    return Intl.message(
      'Press',
      name: 'homePress',
      desc: '',
      args: [],
    );
  }

  /// `to select an applet`
  String get homeSelect {
    return Intl.message(
      'to select an applet',
      name: 'homeSelect',
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

  /// `New PIN should be at least {min} characters long. The maximum length is {max}.`
  String changePinPrompt(Object min, Object max) {
    return Intl.message(
      'New PIN should be at least $min characters long. The maximum length is $max.',
      name: 'changePinPrompt',
      desc: '',
      args: [min, max],
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

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
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

  /// `Change Language`
  String get settingsChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'settingsChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Fix NFC`
  String get settingsFixNFC {
    return Intl.message(
      'Fix NFC',
      name: 'settingsFixNFC',
      desc: '',
      args: [],
    );
  }

  /// `NFC is successfully fixed`
  String get settingsFixNFCSuccess {
    return Intl.message(
      'NFC is successfully fixed',
      name: 'settingsFixNFCSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The output of OTP value comes with enter`
  String get settingsKeyboardWithReturn {
    return Intl.message(
      'The output of OTP value comes with enter',
      name: 'settingsKeyboardWithReturn',
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

  /// `Copy to Clipboard`
  String get oathCopy {
    return Intl.message(
      'Copy to Clipboard',
      name: 'oathCopy',
      desc: '',
      args: [],
    );
  }

  /// `Set as Default`
  String get oathSetDefault {
    return Intl.message(
      'Set as Default',
      name: 'oathSetDefault',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get oathAddAccount {
    return Intl.message(
      'Add Account',
      name: 'oathAddAccount',
      desc: '',
      args: [],
    );
  }

  /// `Issuer`
  String get oathIssuer {
    return Intl.message(
      'Issuer',
      name: 'oathIssuer',
      desc: '',
      args: [],
    );
  }

  /// `Account name`
  String get oathAccount {
    return Intl.message(
      'Account name',
      name: 'oathAccount',
      desc: '',
      args: [],
    );
  }

  /// `Secret key`
  String get oathSecret {
    return Intl.message(
      'Secret key',
      name: 'oathSecret',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get oathType {
    return Intl.message(
      'Type',
      name: 'oathType',
      desc: '',
      args: [],
    );
  }

  /// `Algorithm`
  String get oathAlgorithm {
    return Intl.message(
      'Algorithm',
      name: 'oathAlgorithm',
      desc: '',
      args: [],
    );
  }

  /// `Digits`
  String get oathDigits {
    return Intl.message(
      'Digits',
      name: 'oathDigits',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get oathPeriod {
    return Intl.message(
      'Period',
      name: 'oathPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Require Touch`
  String get oathRequireTouch {
    return Intl.message(
      'Require Touch',
      name: 'oathRequireTouch',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get oathRequired {
    return Intl.message(
      'Required',
      name: 'oathRequired',
      desc: '',
      args: [],
    );
  }

  /// `Too long`
  String get oathTooLong {
    return Intl.message(
      'Too long',
      name: 'oathTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Counter`
  String get oathCounter {
    return Intl.message(
      'Counter',
      name: 'oathCounter',
      desc: '',
      args: [],
    );
  }

  /// `Not a number`
  String get oathCounterMustBeNumber {
    return Intl.message(
      'Not a number',
      name: 'oathCounterMustBeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid secret key`
  String get oathInvalidKey {
    return Intl.message(
      'Invalid secret key',
      name: 'oathInvalidKey',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted`
  String get oathDeleted {
    return Intl.message(
      'Successfully deleted',
      name: 'oathDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added`
  String get oathAdded {
    return Intl.message(
      'Successfully added',
      name: 'oathAdded',
      desc: '',
      args: [],
    );
  }

  /// `Unlock CanoKey`
  String get oathInputCode {
    return Intl.message(
      'Unlock CanoKey',
      name: 'oathInputCode',
      desc: '',
      args: [],
    );
  }

  /// `To prevent unauthorized access, this CanoKey is protected with a passphrase.`
  String get oathInputCodePrompt {
    return Intl.message(
      'To prevent unauthorized access, this CanoKey is protected with a passphrase.',
      name: 'oathInputCodePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase`
  String get oathCode {
    return Intl.message(
      'Passphrase',
      name: 'oathCode',
      desc: '',
      args: [],
    );
  }

  /// `Set Passphrase`
  String get oathSetCode {
    return Intl.message(
      'Set Passphrase',
      name: 'oathSetCode',
      desc: '',
      args: [],
    );
  }

  /// `New Passphrase`
  String get oathNewCode {
    return Intl.message(
      'New Passphrase',
      name: 'oathNewCode',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase Changed`
  String get oathCodeChanged {
    return Intl.message(
      'Passphrase Changed',
      name: 'oathCodeChanged',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new passphrase. Leave it empty to disable current passphrase.`
  String get oathNewCodePrompt {
    return Intl.message(
      'Enter a new passphrase. Leave it empty to disable current passphrase.',
      name: 'oathNewCodePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Change PUK`
  String get pivChangePUK {
    return Intl.message(
      'Change PUK',
      name: 'pivChangePUK',
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
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
