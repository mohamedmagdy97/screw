import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/main.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/screens/rules/widgets/title_with_value.dart';
import 'package:screw_calc/utility/app_theme.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  @override
  void initState() {
    homeData.loadAd();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
    loadAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grayy,
        title: CustomText(text: "قوانين اللعبه", fontSize: 22.sp),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Transform.flip(
                flipX: true,
                child: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: AppColors.white,
                ),
              ))
        ],
      ),
      backgroundColor: AppColors.bg,
      bottomNavigationBar: homeData.bannerAd != null
          ? Container(
              color: AppColors.grayy,
              width: homeData.bannerAd!.size.width.toDouble(),
              height: homeData.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: homeData.bannerAd!),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: Image.asset("assets/icons/icon.png", height: 0.10.sh),
          ),
          CustomText(text: "الكروت الجديدة", fontSize: 16.sp),
          const Divider(),
          const TitleWithValue(
            title: "كارت خد بس",
            highlight: true,
            value:
                "دا زي كارت خد وهات بس الفرق انك بتدي بس يعني هتتخلص من كارت من كروتك وتعطيه لحد غيرك",
          ),
          const TitleWithValue(
            title: "SEE And SWAP كارت",
            highlight: true,
            value:
                "دا بيخليك تشوف ورقة من عند غيرك ولازم تبدلها من عندك وخد بالك انت بتديله كارت من عندك من غير ما تشوفه سواء كنت عارفه أو لا",
            // "دا بيخليك تشوف ورقة من عند غيرك ولازم تبدلها من عندك أو من عند حد من الاعبين",
          ),
          const TitleWithValue(
            title: "كارت الحرامي",
            highlight: true,
            value:
                " كارت لما بتسحبه مش بترميه ولو كان معاك برضو بتخليه معاك عادي , لان انت بتحتاجه لما حد غيرك يقول اسكرو والكارت معاك وبعد ما الدور يلف وكله يكشف ورقه بيقول فلان الحرام لو طلع كلامه صح يبق كده كارت الحرامي مات لو طلع غلط دا يخلي الشخص اللي معاه كارت الحرامي ياخد اسكور اللي قال سكرو وهو ياخد الاسكور بتاعه , يعني بيبدلوا الاسكور بتاعهم مع بعض,  \n وممكن ترميه عل الارض ويتحرق على الكل ولو كان الحرامي معاك واللي قال سكرو قال انه معاك قبل ما يكشف ورقة بيتحسب عليك بقيمتة اللي هي 10",
          ),
          const Divider(),
          const TitleWithValue(
            title: "قواعد اللعبة",
            highlight: true,
            value:
                " كل لاعب بيبدأ معاه 4 كروت, مسموحله يشوف كارتين بس في أول الجيم ومينغعش يغير مكان أي كارت منهم",
          ),
          const TitleWithValue(
            title: "تتكون اللعبة من",
            isSmaller: true,
            value: "تتكون اللعبة من 58 كارت (أرقام عادية و كروت باور)\n "
                "أرقام 7 و 8 بتخليك تشوف ورقة ذيادة من ورقك\n"
                "أرقام 9 و 10 بتخليك تشوف ورقة ذيادة من لاعب تختاره\n"
                "خد وهات بتخليك تبدل كارت مع حد تاني من غير ما تشوفه\n"
                "كعب داير بتخليك تشوف كارت من كل لاعب وانت معاهم\n"
                "البصره بتخليك تتخلص من كارت من الكروت اللي معاك",
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 20),
            color: AppColors.mainColor.withOpacity(0.2),
            child: const CustomText(
              text:
                  "كروت الباور عشان تتفعل لازم تكون مسحوبة من الورق لكن لو من ضمن ورقك المقلوب حاول تتخلص منها عشان قيمتها 10 نقط",
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
          ),
          const TitleWithValue(
            title: "هدف اللعبة",
            value:
                "مع كل راوند تتخلص من الكروت التقيلة لحد ما يبقى معاك أقل سكور يخليك تقول سكرول\n بدل ما تلعب الراوند بتكمل لحد ما باقي اللاعيبه يلعبوا أخر لعبة ليهم وبنكشف الورق \n وصاحب أقل سكور بيكسب",
          ),
          const TitleWithValue(
            title: "أهم كروت اللعبة",
            highlight: true,
            value: "كارت ال -1 و الاسكرول الاخضر (قيمتهم ب 0) حاول تحافظ عليهم",
          ),
          const TitleWithValue(
            title: "أسوء كروت اللعبة",
            highlight: true,
            value:
                "كارت ال +20 و كارت الاسكرول الاحمر (قيمتهم ب 25 ) لو معاك حاول تتخلص منهم",
          ),
        ],
      ),
    );
  }
}
