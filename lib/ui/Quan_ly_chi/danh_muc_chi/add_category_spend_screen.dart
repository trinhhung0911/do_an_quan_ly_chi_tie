import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import '../../../bloc/category_spend_bloc/category_spend_bloc.dart';

class AddTypeSpendScreen extends StatefulWidget {

  final dynamic arg;
  const AddTypeSpendScreen({Key? key,this.arg}) : super(key: key);
  @override
  _AddTypeSpendScreenState createState() => _AddTypeSpendScreenState();

}

class _AddTypeSpendScreenState extends State<AddTypeSpendScreen> {

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _maximumController=TextEditingController();
  final TextEditingController _noteController=TextEditingController();
  FocusNode nameFocus = FocusNode();
  CategorySpend ?categorySpend;
  @override
  void initState() {
    if (widget.arg is CategorySpend) {
      categorySpend = widget.arg as CategorySpend?;
      _nameController.text=categorySpend!.name;
      _noteController.text=categorySpend!.note!;
      _maximumController.text=categorySpend!.maximum.toString() ;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title:  Center(child: Text(categorySpend==null?"Thêm danh mục chi ":"Cập nhật danh mục chi !"),),
      ),
      body: BlocListener<CategorySpendBloc, CategorySpendState>(
        listener: (context, state) {
          if (state is CreateCategorySpendLoadingState||
              state is UpdateCategorySpendLoadingState) {

            LoadingHelper.showLoading(context);
          }
          else if (state is CreateCategorySpendSuccessState||
              state is UpdateCategorySpendSuccessState) {

            LoadingHelper.hideLoading(context);
            Navigator.pop(context);
            FunctionHelper.showSnackBar(
                context: context,
                title:categorySpend==null?
                'Thêm danh mục chi thành công !': 'Cập nhật danh mục chi thành công !');
            BlocProvider.of<CategorySpendBloc>(context).add(GetCategorySpendsEvent());

          }
          else if (state is CreateCategorySpendErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          }
          else if ( state is UpdateCategorySpendErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24,right: 24,top: 20),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              TextField(
                focusNode: nameFocus,
                controller: _nameController,
                style:AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.workspaces_outline,size: 30,) ,
                  hintText: 'Tên danh mục ',
                  hintStyle:AppThemes.commonText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child:TextField(
                  keyboardType: TextInputType.number,
                  controller: _maximumController,
                  style:AppThemes.commonText,
                  decoration: InputDecoration(
                    prefixIcon:const Icon(Icons.work,size: 30,) ,
                    hintText: 'Hạn mức ',
                    hintStyle:AppThemes.commonText,
                  ),
                ),
              ),
              TextField(
                controller: _noteController,
                style:AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.notes,size: 30,) ,
                  hintText: 'Chú thích',
                  hintStyle:AppThemes.commonText,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
               margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  color: AppColors.appColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  <Widget>[
                      const Icon(
                        Icons.arrow_circle_down_sharp,
                        size: 28,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(categorySpend==null?"Thêm":"Cập nhật",style: AppThemes.commonText.copyWith(color: Colors.white),),
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  onPressed:(){
                    if(_nameController.text.trim().isNotEmpty){
                      var categorySpend1 = CategorySpend(
                          name:_nameController.text.trim(),
                        maximum:_maximumController.text.isNotEmpty?int.tryParse(_maximumController.text.trim()) : 0,
                        note: _noteController.text.trim()
                      );
                      if(categorySpend==null){
                        BlocProvider.of<CategorySpendBloc>(context).add(CreateCategorySpendEvent(categorySpend: categorySpend1));
                      }else{
                        categorySpend1.id = categorySpend?.id;
                        categorySpend1.idUser = categorySpend!.idUser;
                        BlocProvider.of<CategorySpendBloc>(context).add(UpdateCategorySpendEvent(categorySpend: categorySpend1));
                      }
                    }else{
                      FunctionHelper.showSnackBar(context: context, title: 'Bạn cần nhập tên danh mục chi !');
                      FocusScope.of(context).requestFocus(nameFocus);
                    }


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

