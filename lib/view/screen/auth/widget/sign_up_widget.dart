import 'package:flutter/material.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_app/data/model/body/register_model.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/provider/auth_provider.dart';
import 'package:user_app/provider/profile_provider.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/view/basewidget/button/custom_button.dart';
import 'package:user_app/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:user_app/view/basewidget/textfield/custom_textfield.dart';
import 'package:user_app/view/screen/auth/auth_screen.dart';
import 'package:user_app/view/screen/auth/widget/places/place_service.dart';
import 'package:user_app/view/screen/auth/widget/sign_in_widget.dart';
import 'package:user_app/view/screen/dashboard/dashboard_screen.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ltController = TextEditingController();
  TextEditingController _lgController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _ltFocus = FocusNode();
  FocusNode _lgFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  // PickResult selectedPlace;
  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  addUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      isEmailVerified = true;

      String _firstName = _firstNameController.text.trim();
      String _email = _emailController.text.trim();
      String _phone = _phoneController.text.trim();
      String _lt = _ltController.text.trim();
      String _lg = _lgController.text.trim();
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();

      if (_firstName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_lt.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_lg.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)),
          backgroundColor: Colors.red,
        ));
      } else {
        register.fName = '${_firstNameController.text}';
        register.lName = _lastNameController.text ?? " ";
        register.email = _emailController.text;
        register.phone = _phoneController.text;
        register.lt = _ltController.text;
        register.lg = _lgController.text;
        register.password = _passwordController.text;
        await Provider.of<AuthProvider>(context, listen: false)
            .registration(register, route);
      }
    } else {
      isEmailVerified = false;
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                    initialPage: 1,
                  )),
          (route) => false);
      _emailController.clear();
      _passwordController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _ltController.clear();
      _lgController.clear();
      _confirmPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _ltController.text =
        Provider.of<AuthProvider>(context, listen: false).lat.toString();
    _lgController.text =
        Provider.of<AuthProvider>(context, listen: false).lng.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('FIRST_NAME', context),
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      capitalization: TextCapitalization.words,
                      controller: _firstNameController,
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('LAST_NAME', context),
                      focusNode: _lNameFocus,
                      nextNode: _emailFocus,
                      capitalization: TextCapitalization.words,
                      controller: _lastNameController,
                    )),
                  ],
                ),
              ),

              // for email
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                  focusNode: _emailFocus,
                  nextNode: _phoneFocus,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              ),

              // for phone

              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                  focusNode: _phoneFocus,
                  nextNode: _lgFocus,
                  controller: _phoneController,
                  isPhoneNumber: true,
                ),
              ),
              // for password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('PASSWORD', context),
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // for re-enter password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  _ltController.text = value.lat.toString();
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 1)) // changes position of shadow
                      ],
                    ),
                    //  child: Text("Latitude: $lat")
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Lat',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15),
                          isDense: true,
                          filled: true,
                          fillColor: Theme.of(context).accentColor,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          hintStyle: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor),
                          border: InputBorder.none),
                      onTap: () {
                        showSearch(
                          context: context,
                          // we haven't created AddressSearch class
                          // this should be extending SearchDelegate
                          delegate: AddressSearch(),
                        );
                      },
                      focusNode: _ltFocus,
                      controller: _ltController,
                    ),
                  );
                },
              ),

              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  _lgController.text = value.lng.toString();
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 1)) // changes position of shadow
                      ],
                    ),
                    //  child: Text("Longitude: $lan")
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Lat',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15),
                          isDense: true,
                          filled: true,
                          fillColor: Theme.of(context).accentColor,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          hintStyle: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor),
                          border: InputBorder.none),
                      onTap: () {
                        showSearch(
                          context: context,
                          // we haven't created AddressSearch class
                          // this should be extending SearchDelegate
                          delegate: AddressSearch(),
                        );
                      },
                      focusNode: _lgFocus,
                      controller: _lgController,
                    ),
                    // child: CustomTextField(
                    //   textInputType: TextInputType.number,
                    //   hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                    //   focusNode: _lgFocus,
                    //   nextNode: _passwordFocus,
                    //   controller: _lgController,
                    //   isPhoneNumber: true,
                    // ),
                  );
                },
              ),

              // Container(
              //   child: TextButton(
              //     onPressed: () {
              //       //showplacepicker();
              //     },
              //     child: Text(getTranslated('CHOSE_LOC', context),
              //         style: titilliumRegular.copyWith(
              //             fontSize: Dimensions.FONT_SIZE_LARGE,
              //             color: ColorResources.getColombiaBlue(context))),
              //   ),
              // )
            ],
          ),
        ),

        // for register button
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: Provider.of<AuthProvider>(context).isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : CustomButton(
                  onTap: addUser,
                  buttonText: getTranslated('SIGN_UP', context)),
        ),

        // for skip for now
        Provider.of<AuthProvider>(context).isLoading
            ? SizedBox()
            : Center(
                child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => DashBoardScreen()));
                },
                child: Text(getTranslated('SKIP_FOR_NOW', context),
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: ColorResources.getColombiaBlue(context))),
              )),
      ],
    );
  }

  double lat = 0;
  double lan = 0;
// showplacepicker() async {
//   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => PlacePicker(
//             "AIzaSyApW8gGWAffK0xp47vZ_Nw3mT66LqU0-K0",
//             // displayLocation: customLocation,
//           )));
//
//   // Handle the result in your way
//   setState(() {
//     lat = result.latLng.latitude;
//     lan = result.latLng.longitude;
//   });
//   print(result);
// }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  PlaceApiProvider placeApiProvider = PlaceApiProvider("sessionToken");
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      // We will put the api call here
      future: placeApiProvider.fetchSuggestions(query, "en"),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title: Text(snapshot.data[index].description),
                    onTap: () async {
                      List<double> list = await placeApiProvider
                          .getPlaceDetailFromId(snapshot.data[index].placeId);
                      await Provider.of<AuthProvider>(context, listen: false)
                          .changelatlng(list[0], list[1]);
                      Navigator.pop(context);

                      //close(context, snapshot.data[index]);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}
