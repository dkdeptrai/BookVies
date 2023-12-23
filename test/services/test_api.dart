// import 'package:flutter/foundation.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// class _TestFirebaseCoreHostApiCodec extends StandardMessageCodec {
//   const _TestFirebaseCoreHostApiCodec();
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is PigeonFirebaseOptions) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     } else if (value is PigeonInitializeResponse) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     } else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return PigeonFirebaseOptions.decode(readValue(buffer)!);
//       case 129:
//         return PigeonInitializeResponse.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class TestFirebaseCoreHostApi {
//   static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding => TestDefaultBinaryMessengerBinding.instance;
//   static const MessageCodec<Object?> codec = _TestFirebaseCoreHostApiCodec();
//
//   Future<PigeonInitializeResponse> initializeApp(String appName, PigeonFirebaseOptions initializeAppRequest);
//
//   Future<List<PigeonInitializeResponse?>> initializeCore();
//
//   Future<PigeonFirebaseOptions> optionsFromResource();
//
//   static void setup(TestFirebaseCoreHostApi? api, {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel =
//           BasicMessageChannel<Object?>('dev.flutter.pigeon.FirebaseCoreHostApi.initializeApp', codec, binaryMessenger: binaryMessenger);
//       if (api == null) {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
//       } else {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
//           assert(message != null, 'Argument for dev.flutter.pigeon.FirebaseCoreHostApi.initializeApp was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final String? arg_appName = (args[0] as String?);
//           assert(arg_appName != null, 'Argument for dev.flutter.pigeon.FirebaseCoreHostApi.initializeApp was null, expected non-null String.');
//           final PigeonFirebaseOptions? arg_initializeAppRequest = (args[1] as PigeonFirebaseOptions?);
//           assert(arg_initializeAppRequest != null,
//               'Argument for dev.flutter.pigeon.FirebaseCoreHostApi.initializeApp was null, expected non-null PigeonFirebaseOptions.');
//           final PigeonInitializeResponse output = await api.initializeApp(arg_appName!, arg_initializeAppRequest!);
//           return <Object?>[output];
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel =
//           BasicMessageChannel<Object?>('dev.flutter.pigeon.FirebaseCoreHostApi.initializeCore', codec, binaryMessenger: binaryMessenger);
//       if (api == null) {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
//       } else {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
//           // ignore message
//           final List<PigeonInitializeResponse?> output = await api.initializeCore();
//           return <Object?>[output];
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel =
//           BasicMessageChannel<Object?>('dev.flutter.pigeon.FirebaseCoreHostApi.optionsFromResource', codec, binaryMessenger: binaryMessenger);
//       if (api == null) {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
//       } else {
//         _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
//           // ignore message
//           final PigeonFirebaseOptions output = await api.optionsFromResource();
//           return <Object?>[output];
//         });
//       }
//     }
//   }
// }
