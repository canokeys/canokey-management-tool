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

  static m0(keyType) => "Change ${keyType} Key\'s Touch Policy";

  static m1(min) => "New PIN should be at least ${min} characters long. The maximum length is 64.";

  static m2(retries) => "Incorrect PIN. ${retries} retries left.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appletLocked" : MessageLookupByLibrary.simpleMessage("This applet has been locked."),
    "change" : MessageLookupByLibrary.simpleMessage("Change"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "homeScreenTitle" : MessageLookupByLibrary.simpleMessage("CanoKey Management Tool"),
    "networkError" : MessageLookupByLibrary.simpleMessage("CanoKey is busy. Replug it, wait for a moment, and retry."),
    "newPin" : MessageLookupByLibrary.simpleMessage("New PIN"),
    "oldPin" : MessageLookupByLibrary.simpleMessage("Old PIN"),
    "openpgpActions" : MessageLookupByLibrary.simpleMessage("Actions"),
    "openpgpAuthentication" : MessageLookupByLibrary.simpleMessage("Authentication"),
    "openpgpCardHolder" : MessageLookupByLibrary.simpleMessage("Card Holder"),
    "openpgpCardInfo" : MessageLookupByLibrary.simpleMessage("Card Info"),
    "openpgpChangeAdminPin" : MessageLookupByLibrary.simpleMessage("Change Admin PIN"),
    "openpgpChangeInteraction" : m0,
    "openpgpChangePin" : MessageLookupByLibrary.simpleMessage("Change PIN"),
    "openpgpChangePinPrompt" : m1,
    "openpgpChangeTouchCacheTime" : MessageLookupByLibrary.simpleMessage("Change Touch Cache Time"),
    "openpgpEncryption" : MessageLookupByLibrary.simpleMessage("Encryption"),
    "openpgpKeyNone" : MessageLookupByLibrary.simpleMessage("[none]"),
    "openpgpKeys" : MessageLookupByLibrary.simpleMessage("Keys"),
    "openpgpManufacturer" : MessageLookupByLibrary.simpleMessage("Manufacturer"),
    "openpgpPinChanged" : MessageLookupByLibrary.simpleMessage("PIN has been successfully changed."),
    "openpgpPinInvalidLength" : MessageLookupByLibrary.simpleMessage("Invalid length"),
    "openpgpPrompt" : MessageLookupByLibrary.simpleMessage("Please read your CanoKey by clicking the refresh button"),
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
    "pinIncorrect" : MessageLookupByLibrary.simpleMessage("Incorrect PIN."),
    "pinLength" : MessageLookupByLibrary.simpleMessage("The provided PIN is too short or too long."),
    "pinRetries" : m2,
    "pollCanceled" : MessageLookupByLibrary.simpleMessage("No CanoKey is selected."),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "seconds" : MessageLookupByLibrary.simpleMessage("seconds")
  };
}
