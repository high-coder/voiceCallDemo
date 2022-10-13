/// This will basically contain the data of the caller
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class CallingDetails {
  String callerName; // This will be the user name
  String callerToName; // This is the name of the person to whom we are calling
  bool isMuted;
  bool speakerMode;
  Duration? totalDuration;
  String channelName;
  String channelToken;
  int? remotedId;
  bool isJoined; // meaning if the local user has joined the channel or not
  ClientRoleType? clientRole;

  CallingDetails({
    required this.callerName,
    required this.isMuted,
    required this.speakerMode,
    required this.callerToName,
    required this.channelName,
    required this.channelToken,
    this.totalDuration,
    this.remotedId,
    required this.isJoined,
    this.clientRole,
  });
}
