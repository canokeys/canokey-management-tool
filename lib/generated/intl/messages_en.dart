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

  static m1(name) => "This action will delete the account ${name} from your CanoKey. Make sure 2FA has been disabled on the web service.";

  static m2(keyType) => "Change ${keyType} Key\'s Touch Policy";

  static m3(retries) => "Incorrect PIN. ${retries} retries left.";

  static m4(applet) => "This operation will RESET all data of ${applet}! Please input your PIN to confirm.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "actions" : MessageLookupByLibrary.simpleMessage("Actions"),
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "appletLocked" : MessageLookupByLibrary.simpleMessage("This applet has been locked."),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "change" : MessageLookupByLibrary.simpleMessage("Change"),
    "changePin" : MessageLookupByLibrary.simpleMessage("Change PIN"),
    "changePinPrompt" : m0,
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "homeScreenTitle" : MessageLookupByLibrary.simpleMessage("CanoKey Management Tool"),
    "networkError" : MessageLookupByLibrary.simpleMessage("CanoKey is busy. Replug it, wait for a moment, and retry."),
    "newPin" : MessageLookupByLibrary.simpleMessage("New PIN"),
    "oathAccount" : MessageLookupByLibrary.simpleMessage("Account name"),
    "oathAddAccount" : MessageLookupByLibrary.simpleMessage("Add Account"),
    "oathAdded" : MessageLookupByLibrary.simpleMessage("Successfully added"),
    "oathAlgorithm" : MessageLookupByLibrary.simpleMessage("Algorithm"),
    "oathCopy" : MessageLookupByLibrary.simpleMessage("Copy to Clipboard"),
    "oathCounter" : MessageLookupByLibrary.simpleMessage("Counter"),
    "oathCounterMustBeNumber" : MessageLookupByLibrary.simpleMessage("Not a number"),
    "oathDelete" : m1,
    "oathDeleted" : MessageLookupByLibrary.simpleMessage("Successfully deleted"),
    "oathDigits" : MessageLookupByLibrary.simpleMessage("Digits"),
    "oathInputCode" : MessageLookupByLibrary.simpleMessage("Unlock CanoKey"),
    "oathInputCodePrompt" : MessageLookupByLibrary.simpleMessage("To prevent unauthorized access, this CanoKey is protected with a password."),
    "oathInvalidKey" : MessageLookupByLibrary.simpleMessage("Invalid secret key"),
    "oathIssuer" : MessageLookupByLibrary.simpleMessage("Issuer"),
    "oathPeriod" : MessageLookupByLibrary.simpleMessage("Period"),
    "oathRequireTouch" : MessageLookupByLibrary.simpleMessage("Require Touch"),
    "oathRequired" : MessageLookupByLibrary.simpleMessage("Required"),
    "oathSecret" : MessageLookupByLibrary.simpleMessage("Secret key"),
    "oathSetDefault" : MessageLookupByLibrary.simpleMessage("Set as Default"),
    "oathTooLong" : MessageLookupByLibrary.simpleMessage("Too long"),
    "oathType" : MessageLookupByLibrary.simpleMessage("Type"),
    "off" : MessageLookupByLibrary.simpleMessage("Off"),
    "oldPin" : MessageLookupByLibrary.simpleMessage("Old PIN"),
    "on" : MessageLookupByLibrary.simpleMessage("On"),
    "openpgpAuthentication" : MessageLookupByLibrary.simpleMessage("Authentication"),
    "openpgpCardHolder" : MessageLookupByLibrary.simpleMessage("Card Holder"),
    "openpgpCardInfo" : MessageLookupByLibrary.simpleMessage("Card Info"),
    "openpgpChangeAdminPin" : MessageLookupByLibrary.simpleMessage("Change Admin PIN"),
    "openpgpChangeInteraction" : m2,
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
    "pinRetries" : m3,
    "pollCanceled" : MessageLookupByLibrary.simpleMessage("No CanoKey is selected."),
    "pollCanoKey" : MessageLookupByLibrary.simpleMessage("Please read your CanoKey by clicking the refresh button"),
    "reset" : MessageLookupByLibrary.simpleMessage("Reset"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "seconds" : MessageLookupByLibrary.simpleMessage("seconds"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsChangeLanguage" : MessageLookupByLibrary.simpleMessage("Change Language"),
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
    "settingsResetAll" : MessageLookupByLibrary.simpleMessage("All data is about to be erased. When you confirm, the CanoKey will blink repeatedly. Touch while it is blinking until success."),
    "settingsResetApplet" : m4,
    "settingsResetConditionNotSatisfying" : MessageLookupByLibrary.simpleMessage("PIN has not been locked yet"),
    "settingsResetNDEF" : MessageLookupByLibrary.simpleMessage("Reset NDEF"),
    "settingsResetOATH" : MessageLookupByLibrary.simpleMessage("Reset TOTP/HOTP"),
    "settingsResetOpenPGP" : MessageLookupByLibrary.simpleMessage("Reset OpenPGP"),
    "settingsResetPIV" : MessageLookupByLibrary.simpleMessage("Reset PIV"),
    "settingsResetPresenceTestFailed" : MessageLookupByLibrary.simpleMessage("You did not touch the pad in time"),
    "settingsResetSuccess" : MessageLookupByLibrary.simpleMessage("Successfully reset"),
    "settingsSN" : MessageLookupByLibrary.simpleMessage("Serial Number"),
    "settingsWebUSB" : MessageLookupByLibrary.simpleMessage("WebUSB prompt when plug-in"),
    "successfullyChanged" : MessageLookupByLibrary.simpleMessage("Successfully changed"),
    "warning" : MessageLookupByLibrary.simpleMessage("Warning")
  };
}
