import 'package:flutter/material.dart';

import 'homePageAdmin.dart';
import 'inputVoucherPage.dart';
import 'main.dart';

enum DrawerSections{
  home,
  voucher,
  inputVoucher,
  updateVoucher,
}

class NavigationAdmin extends StatefulWidget {
  var page;
  NavigationAdmin({super.key, this.page});

  @override
  State<NavigationAdmin> createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin> {
  var currentPage = DrawerSections.home;
  int notInput = 0;

  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.home) {
      container = const HomePageAdmin();
    } else if (currentPage == DrawerSections.voucher) {
      container = const InputVoucherPage();
    }

    if (notInput == 0){
      if (widget.page == DrawerSections.inputVoucher) {
        // container = const InputVoucherPage();
      } else if (widget.page == DrawerSections.updateVoucher) {
        // container = const UpdateVoucherPage();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationAdmin()),
                    );
                  },
                  icon: Image.asset("logo_white_icon.png")
              )
          )
        ],
      ),
      body: container,
      drawer: Drawer(
        backgroundColor: Colors.green[700],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 160, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('logo_white.png'),
                    const SizedBox(height: 5,),
                    const Text("Admin", style: TextStyle(color: Colors.white, fontSize: 20),)
                  ]
                ) 
              ),
              MyDrawerList(),
              Padding(
                padding: const EdgeInsets.fromLTRB(27, 360, 0, 0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Role()),
                        );
                      },
                      icon: const Icon(Icons.logout_outlined),
                      label: const Text("Keluar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        elevation: 0
                      ),
                    )
                  ],
                )
              )
            ],
          )
        )
      ),
    );
  }

  Widget MyDrawerList(){
    return Container(
      padding: const EdgeInsets.only(top: 15,),
      child: Column(
        children: [
          menuItem(0, "Home", Icons.home_outlined,
              currentPage == DrawerSections.home ? true : false),
          menuItem(1, "Voucher List", Icons.discount_outlined,
              currentPage == DrawerSections.voucher ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected){
    return Material(
      color: selected ? Colors.green[600] : Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            if(id == 0){
              currentPage = DrawerSections.home;
              notInput = 1;
            } else if(id == 1){
              currentPage = DrawerSections.voucher;
              notInput = 1;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                    icon,
                    size: 25,
                    color: Colors.white,
                  )
              ),
              Expanded(
                flex: 5,
                  child: Text(
                      title,
                      style: const TextStyle(color: Colors.white,
                      fontSize: 16
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}