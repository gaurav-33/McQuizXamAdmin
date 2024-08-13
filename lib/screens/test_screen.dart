import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Utils/toast_snack_bar.dart';
import '../models/test_paper_model.dart';
import '../services/fetch_test_paper_service.dart';

import '../routes/app_routes.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/list_card_box.dart';
import '../widgets/query_stream_builder.dart';
import '../widgets/rect_button.dart';
class TestScreen extends StatelessWidget {
   TestScreen({super.key});
  final String categoryId = Get.arguments["category_id"];
  final String category = Get.arguments["category"];
  final String subCatId = Get.arguments["subCat_id"];
  final String subCat = Get.arguments["subCat"];
  final FetchTestPaperService _fetchTestPaper = FetchTestPaperService();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MCQUIZ ADMIN",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.getCategoryRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("All Test",
              style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          RectButton(
            name: category,
            height: Get.height * 0.08,
            width: Get.width *0.8,
          ),
          const SizedBox(
            height: 10,
          ),
          RectButton(
            name: subCat,
            height: Get.height * 0.08,
            width: Get.width *0.8,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(child: _buildUI()),
        ],
      ),
    );
  }
  Widget _buildUI(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: Get.height * 0.8,
        child: QueryStreamBuilder(
          stream: _fetchTestPaper.fetchTestPaper(categoryId, subCatId),
          builder: (context, documents) {
            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final MockTestModel testModel = doc.data() as MockTestModel;
                return ListCardBox(
                  title: testModel.title,
                  subtitle: testModel.id,
                  detail: DateFormat("dd-MM-yyyy h:mm a")
                      .format(testModel.updatedAt.toDate()),
                  deleteFunc: (){
                    _deleteDialog(context, testModel.id);
                  },
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
              )),
          emptyWidget: const Center(child: Text('Add Test')),
          errorWidget: const Center(child: Text('Something went wrong')),
        ),
      ),
    );
  }
   void _deleteDialog(BuildContext context, testId) {
     Get.bottomSheet(
       backgroundColor: Theme.of(context).cardColor,
       CustomDialogForm(
         title: "Want to Delete it?",
         onCancel: () {
           Get.back();
         },
         onSave: () {
           _fetchTestPaper.deleteTestPaper(categoryId, subCatId, testId);
           Get.back();
           AppSnackBar.error("Deleted");
         },
       ),
     );
   }
}