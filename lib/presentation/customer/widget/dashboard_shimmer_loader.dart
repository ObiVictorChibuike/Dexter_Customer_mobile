import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmerLoader extends StatelessWidget {
  const DashboardShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Shimmer.fromColors(
            period: Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: Color(0xff6F6F6F)
                .withOpacity(0.5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                Container(
                  height: 14,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Shimmer.fromColors(
            period: Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: Color(0xff6F6F6F).withOpacity(0.5),
            child: Container(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(8), height: 80, width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                ),
                separatorBuilder: (_, __) => SizedBox(
                  width: 10,
                ),
                itemCount: 3,
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Shimmer.fromColors(
            period: Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: Color(0xff6F6F6F)
                .withOpacity(0.5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                Container(
                  height: 14,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Shimmer.fromColors(
            period: Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: Color(0xff6F6F6F)
                .withOpacity(0.5),
            child: Container(
              height: 254,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
          )
        ],
      ),
    );
  }
}
