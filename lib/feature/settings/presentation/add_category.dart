import 'package:expencetracker/core/theme/app_colors.dart';
import 'package:expencetracker/core/widgets/custom_button.dart';
import 'package:expencetracker/core/widgets/custom_text_form_field.dart';
import 'package:expencetracker/feature/settings/presentation/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _category = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  Future<void>getAllCategory()async{
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context,store,child) {
        return Scaffold(
          appBar: AppBar(title: Text("Categories",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),),
          body:
          store.categories.isEmpty?Center(child: Text("No Category Found"),):
           ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: store.categories.length,
            itemBuilder: (_,index){
            final currentItem = store.categories[index];
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.05)),
                leading: CircleAvatar(
                  backgroundColor: AppColors.buttonColor,
                  child: Icon(Icons.category,color: Colors.white,),
                  ),
                title: Text(currentItem['categoryName']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  IconButton(onPressed: (){
                    showForm(context, currentItem["key"],store);
                  }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){
                    store.deleteCategory(currentItem['key']);
                  }, icon: Icon(Icons.delete))
                ],),
              ),
            );
          }),
          floatingActionButton: FloatingActionButton(onPressed:()=> showForm(context,null,store),child: Icon(Icons.add),),
        );
      }
    );
  }

  void showForm(BuildContext context,int? itemKey,CategoryProvider store)async{
    if(itemKey!=null){
      final existingItem = store.categories.firstWhere((element)=>element['key']==itemKey);
      _category.text = existingItem['categoryName'];
    }
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      showDragHandle: true,
      context: context, builder: (builder){
      return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom
          ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Add New Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            CustomTextFormField(controller: _category,labelText: "Category",),
            SizedBox(height: 20,),
            CustomButton(child: Text(itemKey!=null?"Edit":"Add",style: TextStyle(color: Colors.white),), onTap: ()async{
             if(itemKey!=null){
              final item = {"categoryName":_category.text.trim()};
              await store.updateCategory(item,itemKey).then((_){
                Navigator.pop(context);
                _category.text="";
              });
             }else{
               final newCategory = {
                "categoryName":_category.text.trim(),
              };
              await store.addCategory(newCategory,"categoryName",_category.text.trim()).then((_){
                Navigator.pop(context);
                _category.text="";
                showToast(store.success,
                context: context,
                position: StyledToastPosition.bottom,
                duration: Duration(seconds: 1)
              );
              });
             }
            })
          ],),
        ),
      );
    });
  }

}