
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gellery/Core/helper/error_app_custom.dart';
import 'package:my_gellery/Core/helper/loading_app_custom.dart';
import 'package:my_gellery/Core/helper/sussess_app_custom.dart';
import 'package:my_gellery/Core/unit/app_router.dart';
import 'package:my_gellery/Core/unit/assets_data.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Core/unit/styles.dart';
import 'package:my_gellery/Core/unit/unit.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_cubit.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_state.dart';
import 'package:my_gellery/Feather/auth/presentation/view/widget/input_text_custom.dart';

import 'widget/auth_button_custom.dart';

class LoginView extends StatelessWidget {
   LoginView({Key? key}) : super(key: key);

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

   FocusNode emailNode = FocusNode();
   FocusNode passwordNode = FocusNode();

   GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthState>(
        builder: (context,state){
          var cubit = AuthCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsData.backGroundLogin),
                    fit: BoxFit.fill
                )
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: kForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AssetsData.topLogin,height: Unit(context).getHeightSize*0.25,fit: BoxFit.cover),
                    Center(
                      child: Text('My\nGallery',style: Styles.textStyle50.copyWith(
                          fontSize: Unit(context).getWidthSize*0.13
                      ),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: SizeData.s15,),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(SizeData.s10),
                      margin: EdgeInsets.symmetric(horizontal: SizeData.s20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeData.s32),
                        color: ColorData.whiteColor.withOpacity(0.75),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          SizedBox(height: SizeData.s25,),
                          Text('Log in'.toUpperCase(),style: Styles.textStyle50.copyWith(
                              fontSize: Unit(context).getWidthSize*0.08
                          ),textAlign: TextAlign.center,),
                          SizedBox(height: SizeData.s25,),

                          InputTextCustom(
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              hintText: 'User Name',
                            focusNode: emailNode,
                            onEditingComplete: ()=>FocusScope.of(context).requestFocus(passwordNode),
                          ),

                          SizedBox(height: SizeData.s20,),

                          InputTextCustom(
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            hintText: 'Password',
                            obscureText: true,
                            focusNode: passwordNode,
                          ),

                          SizedBox(height: SizeData.s20,),

                          (state is LoadingLoginState) ? const LoadingAppCustom():
                          AuthButtonCustom(text: 'SUBMIT',fct: (){
                            if(kForm.currentState!.validate()){
                              cubit.login(email: emailController.text, password: passwordController.text);
                            }
                          }),
                          SizedBox(height: SizeData.s20,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessLoginState){
            context.go(AppRouter.kGalleryView);
            showSuccessToast(context: context,msg: 'Login Success');
          }else if(state is ErrorLoginState){
            showErrorToast(context: context,msg: 'Error Login , Please try again!');
          }
          else if(state is FailedLoginState){
            showErrorToast(context: context,msg: state.errorModel?.message??'');
          }
        },
      )
    );
  }
}
