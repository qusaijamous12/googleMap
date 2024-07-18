import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  var phoneController=TextEditingController();
  var countryController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    countryController.text=generateCountryFlag()+' +962 ';
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is Your Phone number ? ',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please enter your phone number to verify your account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  buildTextFormField(),
                  SizedBox(
                    height: 30,
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
                              if(formKey.currentState!.validate()){

                              }

                            },
                          child: Text(
                            'Next',
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
      ),

    );
  }
  String generateCountryFlag(){
    String countryCode='jo';
  return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match)=>String.fromCharCode(match.group(0)!.codeUnitAt(0)+127397));
   }
   Widget buildTextFormField()=> Row(
     children: [
       Expanded(
         flex: 1,
         child: TextFormField(
           decoration: InputDecoration(
             border: OutlineInputBorder(),

           ),
           controller: countryController,

           readOnly: true,
         ),
       ),
       SizedBox(
         width: 15,
       ),
       Expanded(
         flex: 2,
         child: TextFormField(
           decoration: InputDecoration(
               border: OutlineInputBorder(),
               hintText: 'Phone number',
               suffixIcon: Icon(
                   Icons.phone
               )
           ),
           validator: (String ?value){
             if(value!.isEmpty){
               return 'Please enter your phone !!';
             }
             else if(value!.length<11){
               return 'your phone must be >11 !';
             }
             return null;
           },
           keyboardType: TextInputType.number,
           controller: phoneController,
         ),
       ),
     ],
   );


}
