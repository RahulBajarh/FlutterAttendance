
class UserDetails {
  final String userKey;
  final String userName;
  final String userEmail;
  final bool isUserTimeIn; // Need to handle locally
  final bool isUserTimeOut;
  final bool isUserCrossOverDay;
  final String lastDayTimeIn;
  final String lastDayTimeOut;

  UserDetails(
      {required this.userKey,
      required this.userName,
      required this.userEmail,
      required this.isUserTimeIn,
      required this.isUserTimeOut,
      required this.isUserCrossOverDay,
      required this.lastDayTimeIn,
      required this.lastDayTimeOut});
}

final userDetails = [
  UserDetails(
    userKey: "RB1507",
    userName: 'Rahul Bazad',
    userEmail: "rahulb@contata.in",
    isUserTimeIn: true,
    isUserTimeOut: true,
    isUserCrossOverDay: false,
    lastDayTimeIn: '09:05:10',
    lastDayTimeOut: '07:15:44',
  )
];
