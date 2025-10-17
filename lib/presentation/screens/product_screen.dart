import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Product"),
        centerTitle: true,
        backgroundColor: AppColors.green1,
        foregroundColor: AppColors.white,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.chat))],
      ),
      body: Column(
        children: [
          CustomContainer(),
          SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.white,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            'https://tse2.mm.bing.net/th/id/OIP.mGth7fmoMXzDxSCvOR61sAHaFj?rs=1&pid=ImgDetMain&o=7&rm=3',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'داشبورد',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Dashboard', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.green2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.green1,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 0, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, color: Colors.amber),
                  SizedBox(height: 5),
                  Text(
                    "10",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "إجمالي المبيعات",
                    style: TextStyle(fontSize: 14, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            color: AppColors.green2,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.green1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 8, 0, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.amber),
                        SizedBox(height: 5),
                        Text(
                          "10",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "المنتجات النشطة",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
