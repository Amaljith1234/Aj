import 'package:eassets/User/user_wholesaler_model.dart';
import 'package:eassets/User/users_provider.dart';
import 'package:eassets/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  String status;

  UserPage({Key? key, required this.status}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController _searchTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false)
        .getUserList(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: widget.status == "1"
              ? const Text("Active Users")
              : const Text("Inactive Users"),
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  if (value== 1){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => UserPage(status: '1'),));
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => UserPage(status: '0'),));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 1,
                      child:Text("Active Users")),
                  PopupMenuItem(
                      value: 2,
                      child: Text("Inactive Users"))
                ]),],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6, top:2),
              child: TextField(
                controller: _searchTextEditController,
                onChanged: (value) {
                  debugPrint(provider.listOfUser.length.toString());
                  provider.search(value.trim());
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: 'Search Text',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
              ),
            ),
            Provider.of<UserProvider>(context, listen: true).is_loading
                ? const Center(child: CircularProgressIndicator())
                : provider.listOfSearchUser.isEmpty
                ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No Users"),
                ))
                : Expanded(child: getListView(provider.listOfSearchUser)),
          ],
        ),
    );
  }



  Widget getListView(List<UserWholesaler> listOfUser) {

    return ListView.builder(
      itemCount: listOfUser.length,
      itemBuilder: (BuildContext context, index) {
        String img = "";
        // if (listOfUser[index]!.image != null) {
        //   img = UrlConstantscreen.BASE_URL + listOfUser[index]!.image!;
        // }
        String? user_type = Utility.wholesale_user!.wholesalerUserType;
        UserWholesaler user = listOfUser[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(
                  Radius.circular(8)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
              leading: Icon(Icons.person),
              title: Padding(
                padding:
                const EdgeInsets.only(top: 6.0, bottom: 6, left: 2, right: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name!.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),

                      ],
                    ),
                    getEmailFiled(user.email),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                color: Colors.black45,
                                Icons.tablet_android_outlined,
                                size: 12,
                              ),
                            ),
                            Text(
                              user.contactNo!.toString(),
                              style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getEmailFiled(String? email) {
    if (email == null || email == "") {
      return SizedBox();
    } else {
      return Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              color: Colors.black45,
              Icons.email,
              size: 14,
            ),
          ),
          Text(
            email,
            style: const TextStyle(color: Colors.black45,
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }
  }
}
