import 'dart:io';
import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:expencetracker/core/utils/utils_function.dart';
import 'package:expencetracker/core/widgets/custom_button.dart';
import 'package:expencetracker/core/widgets/custom_text_form_field.dart';
import 'package:expencetracker/feature/addExpense/presentation/provider/add_expense_provider.dart';
import 'package:expencetracker/feature/home/presentation/provider/home_provider.dart';
import 'package:expencetracker/feature/settings/presentation/add_category.dart';
import 'package:expencetracker/feature/settings/presentation/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _note = TextEditingController();
  final _date = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();
  final formKey = GlobalKey<FormState>();

 DateTime? _selectedDate;


  File? _selectedImage; 

  @override
  Widget build(BuildContext context) {
    return Consumer3<ExpenseProvider,CategoryProvider,HomeProvider>(
      builder: (context,store,storeTwo,storeThree,child) {
        return Scaffold(
          appBar: AppBar(title: Text("Add New Expense",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    CustomTextFormField(
                      readeOnly: true,
                      labelText: "Category",
                      controller: _category,
                      suffixIcon: IconButton(onPressed: (){
                        storeTwo.getAllCategory().then((_)=>showForm(storeTwo.categories));
                      }, icon: Icon(Icons.category)),
                    ),
                    SizedBox(height: 20,),
                    CustomTextFormField(
                      labelText: "Price",
                      controller: _price,
                    ),
                    SizedBox(height: 20,),
                    CustomTextFormField(
                      labelText: "Date & Time",
                      controller: _date,
                      suffixIcon: IconButton(
                        onPressed: (){
                        _pickDate();
                        }, 
                        icon: Icon(Icons.calendar_month),
                      ),
                    ),
                    SizedBox(height: 20,),
                    CustomTextFormField(
                      labelText: "Note",
                      controller: _note,
                    ),
                    SizedBox(height: 20,),
                    Text("Add Image"),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),border: Border.all(width: 0.1)),
                      child: _selectedImage!=null? Image.file(_selectedImage!):IconButton(onPressed: (){
                      pickImageFromGalary();
                    }, icon: Icon(Icons.add)),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: CustomButton(child: Text("Add Expense",style: TextStyle(color: Colors.white),), onTap: ()async{
              if(_category.text.isNotEmpty && _price.text.isNotEmpty){
                Map<String,dynamic> expense = {
                  "category":_category.text.trim(),
                  "amount":convertStringToDouble(_price.text),
                  "date":_selectedDate!=null?_selectedDate!.toUtc().toString():DateTime.now().toUtc().toString(),
                  "note":_note.text,
                  "photo":_selectedImage==null?"":_selectedImage!.path
                };
                await store.addExpense(expense).then((_){
                  storeThree.updateTotalBalance(convertStringToDouble(_price.text),false);
                  _category.text="";
                  _date.text="";
                  _note.text="";
                  _price.text="";
                  _selectedImage=null;
                  _selectedDate = null;
                });
              }else{

              }
             
            }),
          ),
        );
      }
    );
  }

  void showForm(List<Map<String,dynamic>> category){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      showDragHandle: true,
      isScrollControlled: true,
      context: context, builder: (context){

      return category.isEmpty?Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Category Added"),
            SizedBox(height: 20,),
            CustomButton(child: Text("Add Category",style: TextStyle(color: Colors.white),), onTap: (){
             Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategory()));
            }),
          ],
        ),
      ) : 
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 10,
                children: [
          ...category.map((e){
            return GestureDetector(
              onTap: (){
                _category.text=e['categoryName'];
                Navigator.pop(context);
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),side: BorderSide(width: 0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.category,color:AppColors.buttonColor,),
                    )),
                  Text(e['categoryName'],style: TextStyle(),)
                ],),
              ),
            );
          })
                ],),
        );
    });
  }

  Future<void>pickImageFromGalary()async{
   final image= await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
   setState(() {
     _selectedImage = File(image.path);

   });
  }

   Future<void>pickImageFromCamera()async{
   final image= await ImagePicker().pickImage(source: ImageSource.camera);
  if(image == null) return;
   setState(() {
     _selectedImage = File(image.path);
   });
  }


  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate=pickedDate;
        _date.text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    }
  }
}