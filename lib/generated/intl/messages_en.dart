// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(min, max) =>
      "New PIN should be at least ${min} characters long. The maximum length is ${max}.";

  static String m1(name) =>
      "This action will delete the account ${name} from your CanoKey. Make sure 2FA has been disabled on the web service.";

  static String m2(keyType) => "Change ${keyType} Key\'s Touch Policy";

  static String m3(retries) => "Incorrect PIN. ${retries} retries left.";

  static String m4(applet) =>
      "This operation will RESET all data of ${applet}! Please input your PIN to confirm.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actions": MessageLookupByLibrary.simpleMessage("Actions"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "appletLocked": MessageLookupByLibrary.simpleMessage(
            "This applet has been locked."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change": MessageLookupByLibrary.simpleMessage("Change"),
        "changePin": MessageLookupByLibrary.simpleMessage("Change PIN"),
        "changePinPrompt": m0,
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "homePress": MessageLookupByLibrary.simpleMessage("Press"),
        "homeScreenTitle":
            MessageLookupByLibrary.simpleMessage("CanoKey Management Tool"),
        "homeSelect":
            MessageLookupByLibrary.simpleMessage("to select an applet"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "CanoKey is busy. Replug it, wait for a moment, and retry."),
        "newPin": MessageLookupByLibrary.simpleMessage("New PIN"),
        "oathAccount": MessageLookupByLibrary.simpleMessage("Account name"),
        "oathAddAccount": MessageLookupByLibrary.simpleMessage("Add Account"),
        "oathAdded": MessageLookupByLibrary.simpleMessage("Successfully added"),
        "oathAlgorithm": MessageLookupByLibrary.simpleMessage("Algorithm"),
        "oathCode": MessageLookupByLibrary.simpleMessage("Passphrase"),
        "oathCodeChanged":
            MessageLookupByLibrary.simpleMessage("Passphrase Changed"),
        "oathCopy": MessageLookupByLibrary.simpleMessage("Copy to Clipboard"),
        "oathCounter": MessageLookupByLibrary.simpleMessage("Counter"),
        "oathCounterMustBeNumber":
            MessageLookupByLibrary.simpleMessage("Not a number"),
        "oathDelete": m1,
        "oathDeleted":
            MessageLookupByLibrary.simpleMessage("Successfully deleted"),
        "oathDigits": MessageLookupByLibrary.simpleMessage("Digits"),
        "oathInputCode": MessageLookupByLibrary.simpleMessage("Unlock CanoKey"),
        "oathInputCodePrompt": MessageLookupByLibrary.simpleMessage(
            "To prevent unauthorized access, this CanoKey is protected with a passphrase."),
        "oathInvalidKey":
            MessageLookupByLibrary.simpleMessage("Invalid secret key"),
        "oathIssuer": MessageLookupByLibrary.simpleMessage("Issuer"),
        "oathNewCode": MessageLookupByLibrary.simpleMessage("New Passphrase"),
        "oathNewCodePrompt": MessageLookupByLibrary.simpleMessage(
            "Enter a new passphrase. Leave it empty to disable current passphrase."),
        "oathPeriod": MessageLookupByLibrary.simpleMessage("Period"),
        "oathRequireTouch":
            MessageLookupByLibrary.simpleMessage("Require Touch"),
        "oathRequired": MessageLookupByLibrary.simpleMessage("Required"),
        "oathSecret": MessageLookupByLibrary.simpleMessage("Secret key"),
        "oathSetCode": MessageLookupByLibrary.simpleMessage("Set Passphrase"),
        "oathSetDefault":
            MessageLookupByLibrary.simpleMessage("Set as Default"),
        "oathTooLong": MessageLookupByLibrary.simpleMessage("Too long"),
        "oathType": MessageLookupByLibrary.simpleMessage("Type"),
        "off": MessageLookupByLibrary.simpleMessage("Off"),
        "oldPin": MessageLookupByLibrary.simpleMessage("Old PIN"),
        "on": MessageLookupByLibrary.simpleMessage("On"),
        "openpgpAuthentication":
            MessageLookupByLibrary.simpleMessage("Authentication"),
        "openpgpCardHolder":
            MessageLookupByLibrary.simpleMessage("Card Holder"),
        "openpgpCardInfo": MessageLookupByLibrary.simpleMessage("Card Info"),
        "openpgpChangeAdminPin":
            MessageLookupByLibrary.simpleMessage("Change Admin PIN"),
        "openpgpChangeInteraction": m2,
        "openpgpChangeTouchCacheTime":
            MessageLookupByLibrary.simpleMessage("Change Touch Cache Time"),
        "openpgpEncryption": MessageLookupByLibrary.simpleMessage("Encryption"),
        "openpgpKeyNone": MessageLookupByLibrary.simpleMessage("[none]"),
        "openpgpKeys": MessageLookupByLibrary.simpleMessage("Keys"),
        "openpgpManufacturer":
            MessageLookupByLibrary.simpleMessage("Manufacturer"),
        "openpgpPubkeyUrl":
            MessageLookupByLibrary.simpleMessage("Public Key URL"),
        "openpgpSN": MessageLookupByLibrary.simpleMessage("Serial Number"),
        "openpgpSignature": MessageLookupByLibrary.simpleMessage("Signature"),
        "openpgpUIF": MessageLookupByLibrary.simpleMessage("Touch Policies"),
        "openpgpUifCacheTime":
            MessageLookupByLibrary.simpleMessage("Touch Cache Time"),
        "openpgpUifCacheTimeChanged": MessageLookupByLibrary.simpleMessage(
            "Touch cache time has been successfully changed."),
        "openpgpUifChanged": MessageLookupByLibrary.simpleMessage(
            "Touch policy has been successfully changed."),
        "openpgpUifOff": MessageLookupByLibrary.simpleMessage("Off"),
        "openpgpUifOn": MessageLookupByLibrary.simpleMessage("On"),
        "openpgpUifPermanent":
            MessageLookupByLibrary.simpleMessage("Permanent (Cannot turn off)"),
        "openpgpVersion": MessageLookupByLibrary.simpleMessage("Version"),
        "pinChanged": MessageLookupByLibrary.simpleMessage(
            "PIN has been successfully changed."),
        "pinIncorrect": MessageLookupByLibrary.simpleMessage("Incorrect PIN."),
        "pinInvalidLength":
            MessageLookupByLibrary.simpleMessage("Invalid length"),
        "pinLength": MessageLookupByLibrary.simpleMessage(
            "The provided PIN is too short or too long."),
        "pinRetries": m3,
        "pivChangePUK": MessageLookupByLibrary.simpleMessage("Change PUK"),
        "pollCanceled":
            MessageLookupByLibrary.simpleMessage("No CanoKey is selected."),
        "pollCanoKey": MessageLookupByLibrary.simpleMessage(
            "Please read your CanoKey by clicking the refresh button"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "seconds": MessageLookupByLibrary.simpleMessage("seconds"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsChangeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "settingsChipId": MessageLookupByLibrary.simpleMessage("Chip ID"),
        "settingsFirmwareVersion":
            MessageLookupByLibrary.simpleMessage("Firmware Version"),
        "settingsFixNFC": MessageLookupByLibrary.simpleMessage("Fix NFC"),
        "settingsFixNFCSuccess":
            MessageLookupByLibrary.simpleMessage("NFC is successfully fixed"),
        "settingsHotp":
            MessageLookupByLibrary.simpleMessage("Input HOTP when touching"),
        "settingsInfo": MessageLookupByLibrary.simpleMessage("CanoKey Info"),
        "settingsInputPin":
            MessageLookupByLibrary.simpleMessage("PIN Verification"),
        "settingsInputPinPrompt": MessageLookupByLibrary.simpleMessage(
            "Please input your PIN. The default value is 123456. This PIN is irrelevant to other applets."),
        "settingsKeyboardWithReturn": MessageLookupByLibrary.simpleMessage(
            "The output of OTP value comes with enter"),
        "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "settingsModel": MessageLookupByLibrary.simpleMessage("Model"),
        "settingsNDEF":
            MessageLookupByLibrary.simpleMessage("NFC Tag Mode (NDEF)"),
        "settingsNDEFReadonly":
            MessageLookupByLibrary.simpleMessage("NFC Tag Readonly"),
        "settingsOtherSettings":
            MessageLookupByLibrary.simpleMessage("Other Settings"),
        "settingsResetAll": MessageLookupByLibrary.simpleMessage(
            "All data is about to be erased. When you confirm, the CanoKey will blink repeatedly. Touch while it is blinking until success."),
        "settingsResetApplet": m4,
        "settingsResetConditionNotSatisfying":
            MessageLookupByLibrary.simpleMessage("PIN has not been locked yet"),
        "settingsResetNDEF": MessageLookupByLibrary.simpleMessage("Reset NDEF"),
        "settingsResetOATH":
            MessageLookupByLibrary.simpleMessage("Reset TOTP/HOTP"),
        "settingsResetOpenPGP":
            MessageLookupByLibrary.simpleMessage("Reset OpenPGP"),
        "settingsResetPIV": MessageLookupByLibrary.simpleMessage("Reset PIV"),
        "settingsResetPresenceTestFailed": MessageLookupByLibrary.simpleMessage(
            "You did not touch the pad in time"),
        "settingsResetSuccess":
            MessageLookupByLibrary.simpleMessage("Successfully reset"),
        "settingsSN": MessageLookupByLibrary.simpleMessage("Serial Number"),
        "settingsWebUSB":
            MessageLookupByLibrary.simpleMessage("WebUSB prompt when plug-in"),
        "successfullyChanged":
            MessageLookupByLibrary.simpleMessage("Successfully changed"),
        "warning": MessageLookupByLibrary.simpleMessage("Warning")
      };
}
