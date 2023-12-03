import 'package:doanchuyende/Screen/Login/Username.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { Waiting, Error }

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId;
  final _textEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phonesAuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (_verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => const Username()));
      })
          .whenComplete(() {})
          .onError((error, stackTrace) {
        setState(() {
          _textEditingController.text = "";
          _status = Status.Error;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Xác Thực Số Điện Thoại"),
        previousPageTitle: "RegisterAccount",
      ),
      child: _status != Status.Error
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Xác thực",
                style: TextStyle(
                    color: const Color(0xFF2196F3).withOpacity(0.7),
                    fontSize: 30)),
          ),
          const Text("Nhập mã OTP vừa gửi đến SĐT của bạn",
              style: TextStyle(
                  color: CupertinoColors.secondaryLabel, fontSize: 20)),
          Text(phoneNumber ?? ""),
          CupertinoTextField(
              onChanged: (value) async {
                if (value.length == 6) {
                  //perform the auth verification
                  _sendCodeToFirebase(code: value);
                }
              },
              textAlign: TextAlign.center,
              style: const TextStyle(letterSpacing: 30, fontSize: 30),
              maxLength: 6,
              controller: _textEditingController,
              keyboardType: TextInputType.number),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Không nhận được mã OPT"),
              CupertinoButton(
                  child: const Text("Gửi lại mã OTP"),
                  onPressed: () async {
                    setState(() {
                      _status = Status.Waiting;
                    });
                    _verifyPhoneNumber();
                  })
            ],
          )
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("OTP Verification",
                style: TextStyle(
                    color: const Color(0xFF2196F3).withOpacity(0.7),
                    fontSize: 30)),
          ),
          const Text("Mã được sử dụng không hợp lệ!"),
          CupertinoButton(
              child: const Text("Đăng Kí số điện thoại khác"),
              onPressed: () => Navigator.pop(context)),
          CupertinoButton(
              child: const Text("Resend Code"),
              onPressed: () async {
                setState(() {
                  _status = Status.Waiting;
                });

                _verifyPhoneNumber();
              }),
        ],
      ),
    );
  }
}