// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(min) => "New PIN should be at least ${min} characters long. The maximum length is 64.";

  static m1(keyType) => "Change ${keyType} Key\'s Touch Policy";

  static m2(retries) => "Incorrect PIN. ${retries} retries left.";

  static m3(applet) => "This operation will RESET all data of ${applet}! Please input your PIN to confirm.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "actions" : MessageLookupByLibrary.simpleMessage("Actions"),
    "appletLocked" : MessageLookupByLibrary.simpleMessage("This applet has been locked."),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "change" : MessageLookupByLibrary.simpleMessage("Change"),
    "changePin" : MessageLookupByLibrary.simpleMessage("Change PIN"),
    "changePinPrompt" : m0,
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "homeScreenTitle" : MessageLookupByLibrary.simpleMessage("CanoKey Management Tool"),
    "networkError" : MessageLookupByLibrary.simpleMessage("CanoKey is busy. Replug it, wait for a moment, and retry."),
    "newPin" : MessageLookupByLibrary.simpleMessage("New PIN"),
    "off" : MessageLookupByLibrary.simpleMessage("Off"),
    "oldPin" : MessageLookupByLibrary.simpleMessage("Old PIN"),
    "on" : MessageLookupByLibrary.simpleMessage("On"),
    "openpgpAuthentication" : MessageLookupByLibrary.simpleMessage("Authentication"),
    "openpgpCardHolder" : MessageLookupByLibrary.simpleMessage("Card Holder"),
    "openpgpCardInfo" : MessageLookupByLibrary.simpleMessage("Card Info"),
    "openpgpChangeAdminPin" : MessageLookupByLibrary.simpleMessage("Change Admin PIN"),
    "openpgpChangeInteraction" : m1,
    "openpgpChangeTouchCacheTime" : MessageLookupByLibrary.simpleMessage("Change Touch Cache Time"),
    "openpgpEncryption" : MessageLookupByLibrary.simpleMessage("Encryption"),
    "openpgpKeyNone" : MessageLookupByLibrary.simpleMessage("[none]"),
    "openpgpKeys" : MessageLookupByLibrary.simpleMessage("Keys"),
    "openpgpManufacturer" : MessageLookupByLibrary.simpleMessage("Manufacturer"),
    "openpgpPubkeyUrl" : MessageLookupByLibrary.simpleMessage("Public Key URL"),
    "openpgpSN" : MessageLookupByLibrary.simpleMessage("Serial Number"),
    "openpgpSignature" : MessageLookupByLibrary.simpleMessage("Signature"),
    "openpgpUIF" : MessageLookupByLibrary.simpleMessage("Touch Policies"),
    "openpgpUifCacheTime" : MessageLookupByLibrary.simpleMessage("Touch Cache Time"),
    "openpgpUifCacheTimeChanged" : MessageLookupByLibrary.simpleMessage("Touch cache time has been successfully changed."),
    "openpgpUifChanged" : MessageLookupByLibrary.simpleMessage("Touch policy has been successfully changed."),
    "openpgpUifOff" : MessageLookupByLibrary.simpleMessage("Off"),
    "openpgpUifOn" : MessageLookupByLibrary.simpleMessage("On"),
    "openpgpUifPermanent" : MessageLookupByLibrary.simpleMessage("Permanent (Cannot turn off)"),
    "openpgpVersion" : MessageLookupByLibrary.simpleMessage("Version"),
    "pinChanged" : MessageLookupByLibrary.simpleMessage("PIN has been successfully changed."),
    "pinIncorrect" : MessageLookupByLibrary.simpleMessage("Incorrect PIN."),
    "pinInvalidLength" : MessageLookupByLibrary.simpleMessage("Invalid length"),
    "pinLength" : MessageLookupByLibrary.simpleMessage("The provided PIN is too short or too long."),
    "pinRetries" : m2,
    "pollCanceled" : MessageLookupByLibrary.simpleMessage("No CanoKey is selected."),
    "pollCanoKey" : MessageLookupByLibrary.simpleMessage("Please read your CanoKey by clicking the refresh button"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "seconds" : MessageLookupByLibrary.simpleMessage("seconds"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsChipId" : MessageLookupByLibrary.simpleMessage("Chip ID"),
    "settingsFirmwareVersion" : MessageLookupByLibrary.simpleMessage("Firmware Version"),
    "settingsHotp" : MessageLookupByLibrary.simpleMessage("Input HOTP when touching"),
    "settingsInfo" : MessageLookupByLibrary.simpleMessage("CanoKey Info"),
    "settingsInputPin" : MessageLookupByLibrary.simpleMessage("PIN Verification"),
    "settingsInputPinPrompt" : MessageLookupByLibrary.simpleMessage("Please input your PIN. The default value is 123456. This PIN is irrelevant to other applets."),
    "settingsLanguage" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsModel" : MessageLookupByLibrary.simpleMessage("Model"),
    "settingsNDEF" : MessageLookupByLibrary.simpleMessage("NFC Tag Mode (NDEF)"),
    "settingsNDEFReadonly" : MessageLookupByLibrary.simpleMessage("NFC Tag Readonly"),
    "settingsOtherSettings" : MessageLookupByLibrary.simpleMessage("Other Settings"),
    "settingsReset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "settingsResetAll" : MessageLookupByLibrary.simpleMessage("All data is about to be erased. When you confirm, the CanoKey will blink repeatedly. Touch while it is blinking until success."),
    "settingsResetApplet" : m3,
    "settingsResetConditionNotSatisfying" : MessageLookupByLibrary.simpleMessage("PIN has not been locked yet"),
    "settingsResetNDEF" : MessageLookupByLibrary.simpleMessage("Reset NDEF"),
    "settingsResetOATH" : MessageLookupByLibrary.simpleMessage("Reset TOTP/HOTP"),
    "settingsResetOpenPGP" : MessageLookupByLibrary.simpleMessage("Reset OpenPGP"),
    "settingsResetPIV" : MessageLookupByLibrary.simpleMessage("Reset PIV"),
    "settingsResetPresenceTestFailed" : MessageLookupByLibrary.simpleMessage("You did not touch the pad in time"),
    "settingsResetSuccess" : MessageLookupByLibrary.simpleMessage("Successfully reset"),
    "settingsSN" : MessageLookupByLibrary.simpleMessage("Serial Number"),
    "settingsWarning" : MessageLookupByLibrary.simpleMessage("Warning"),
    "settingsWebUSB" : MessageLookupByLibrary.simpleMessage("WebUSB prompt when plug-in"),
    "successfullyChanged" : MessageLookupByLibrary.simpleMessage("Successfully changed")
  };
}
