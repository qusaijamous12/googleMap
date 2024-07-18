import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  String ?otpCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Your Phone number ? ',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                    text:TextSpan(
                      text: 'Enter your 6 digit code numbers sent to you at ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16

                      ),
                      children:<TextSpan> [
                        TextSpan(
                          text: '+962797313842',
                          style: TextStyle(
                            color: Colors.blue,
                            height: 1.4,
                            fontWeight: FontWeight.w300,
                            fontSize: 16
                          )
                        )

                      ]

                    ),

                ),
                SizedBox(
                  height: 50,
                ),
                buildPinCodeFields(context),
                SizedBox(
                  height: 20,
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.black

                      ),
                      child: MaterialButton(
                        onPressed: (){
                        },
                        child: Text(
                          'Verify',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
  Widget buildPinCodeFields(context)=>Container(
    child:PinCodeTextField(
      appContext:context,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: Colors.white,
        inactiveColor: Colors.blue,
        inactiveFillColor: Colors.white,
        activeFillColor: Colors.lightBlue,
        selectedColor: Colors.blue,
        selectedFillColor: Colors.white
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        print("Completed");
        otpCode=code;
      },
    ) ,
  );

}
