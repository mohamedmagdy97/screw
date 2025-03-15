import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/screens/dashboard/dashboard_data.dart';
import 'package:screw_calc/screens/home/widgets/marquee_widget.dart';
import 'package:screw_calc/utility/app_theme.dart';

class MarqueeBar extends StatelessWidget {
  final DashboardData dashboardData;

  const MarqueeBar({super.key, required this.dashboardData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
      bloc: dashboardData.hideMarquee,
      builder: (context, state) {
        if (state.data == false) {
          return Container(
            width: 1.sw,
            padding: const EdgeInsets.all(8),
            color: AppColors.black,
            child: Row(
              children: [
                const Expanded(
                  child: MarqueeWidget(
                    direction: Axis.horizontal,
                    child: CustomText(
                      text:
                          "            صلي على النبي, لا اله الا الله وحده لا شريك له, له الملك وله الحمد يحي ويميت وهو على كل شيء قدير, سبحان الله والحمد لله ولا اله الا الله ولا حول ولا قوة الا بالله, استغفر الله العظيم وأتوب اليه, لا اله الا انت سبحانك اني كنت من الظالمين .            ",
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () =>
                        dashboardData.hideMarquee.update(data: true),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ))
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
