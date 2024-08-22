import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/countryFlag/country_code.dart';
import 'package:nationremit/countryFlag/country_code_picker.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';

import '../common_widget/country_iso.dart';
import '../model/partner_destination_country_model.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class SelectRecipientCountryPage extends StatefulWidget {
  const SelectRecipientCountryPage({Key? key}) : super(key: key);

  @override
  State<SelectRecipientCountryPage> createState() =>
      _SelectRecipientCountryPageState();
}

class _SelectRecipientCountryPageState
    extends State<SelectRecipientCountryPage> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  PartnerDestinationCountryModel? mCountryList = null;
  late List<String> mFilteredCountriesList = List.empty(growable: true);

 CountryCodePicker countryPicker =CountryCodePicker(
    showDialCode: false,
    showSearchBar: true,
  );
  CountryCode countryCode =
      CountryCode(name: 'Australia', code: 'AU', dialCode: '+61');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      if (provider.countryDestinationList == null) {
        await provider.getCountryDestinationList(false);
      }
      if (provider.countryDestinationList != null) {
        mFilteredCountriesList.clear();
        for (var res in provider
            .countryDestinationList!.response!.destinationCurrency!) {
          print('flag======== ${res.countryCode}');
          mFilteredCountriesList
              .add(CountryISOMapping().getCountryISO2(res.countryCode!));
        }
      }
      countryPicker = CountryCodePicker(
          showDialCode: false,
          showSearchBar: true,
          filteredCountries: mFilteredCountriesList);

      showPicker();
    });
    super.initState();
  }

  Widget getWidget(
      DashBoardProvider provider, SourceCurrency data, String type) {
    return GestureDetector(
      onTap: () {
        provider.sourceCountryName = data.countryName!;
        provider.selectCountryCodeByUser(data.countryCode!);
        if (type == 'destination') {
          provider.destinationCurrency = data.currencySupported![0].currency!;
        }

        //  Navigator.pop(context, data.currencySupported[0].currency);

        Navigator.pushNamed(context, RouterConstants.addNewRecipientRoute,
            arguments: {
              Constants.showDestinationCountry: data.countryCode,
              Constants.currency: data.currencySupported![0].currency
            });
      },
      onTapDown: (_) {
        // provider.selectCountryCodeByUser(data.countryCode);
      },
      onTapCancel: () {
        // provider.selectCountryCodeByUser('');
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              provider.getCountryFlag(data.countryCode!),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              data.countryName!,
              style: TextStyle(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter-Medium',
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(-1.05, 1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(AssetsConstant.icBack),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AssetsConstant.icBarSelected),
                          SizedBox(width: 5),
                          Image.asset(AssetsConstant.icUnBarSelected),
                          SizedBox(width: 5),
                          Image.asset(AssetsConstant.icUnBarSelected),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Text(
                    'Which country do you want to send money to?',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.screenTitle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /* Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter', contentPadding: EdgeInsets.all(10),
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showPicker();
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),*/
                const SizedBox(
                  height: 20,
                ),
                /*   Expanded(
                  child:
                      Consumer<DashBoardProvider>(builder: (_, provider, __) {
                    PartnerDestinationCountryModel? countryList =
                        provider.countryDestinationList;
                    print(provider.whichTypeCountryMode);
                    mCountryList = countryList;

                    return provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: countryList == null
                                ? 0
                                : countryList
                                    .response[0].destinationCurrency.length,
                            itemBuilder: (context, index) {
                              return getWidget(
                                  provider,
                                  countryList!
                                      .response[0].destinationCurrency[index],
                                  'destination');
                            },
                          );
                  }),
                ),*/
              ],
            ),
          );
        }),
      ),
    );
  }

 /* @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    for (var item in mCountryList!.response[0].destinationCurrency) {
      if (item.countryName
          .toLowerCase()
          .contains(_searchController.text.toString().toLowerCase())) {
        matchQuery.add(item.countryName);
      }
    }
    return ListView.builder(
      itemCount: mCountryList == null
          ? 0
          : mCountryList!.response[0].destinationCurrency.length,
      itemBuilder: (context, index) {
        return getWidget(
            provider,
            mCountryList!.response[0].destinationCurrency[index],
            'destination');
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    for (var item in mCountryList!.response[0].destinationCurrency) {
      if (item.countryName
          .toLowerCase()
          .contains(_searchController.text.toString().toLowerCase())) {
        matchQuery.add(item.countryName);
      }
    }
    return ListView.builder(
      itemCount: mCountryList == null
          ? 0
          : mCountryList!.response[0].destinationCurrency.length,
      itemBuilder: (context, index) {
        return getWidget(
            provider,
            mCountryList!.response[0].destinationCurrency[index],
            'destination');
      },
    );
  }
*/

  Future<void> showPicker() async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    final picked = await countryPicker
        .showPicker(fullScreen: false, context: context, pickerMaxHeight: 520)
        .whenComplete(() {
      Navigator.pop(context);
      /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Selected country not available in the list'),
      ));*/
    });
    // Null check
    if (picked != null) print(picked);
    child:
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text('', style: const TextStyle(color: Colors.white)),
    );
    setState(() {
      countryCode = picked!;
      if (provider.countryDestinationList != null) {
          for (var res in provider
              .countryDestinationList!
              .response!
              .destinationCurrency!) {
            if (res.countryCode ==
                CountryISOMapping().getCountryISO3(
                    countryCode.code)) {
              provider.destinationCurrency =
                  res.currencySupported![0].currency!;
              provider.destinationCountry =
                  res.countryName!;
              provider.selectCountryCodeByUser(
                  res.countryCode!);
              Navigator.pushNamed(context, RouterConstants.addNewRecipientRoute,
                  arguments: {
                    Constants.showDestinationCountry: res.countryCode,
                    Constants.currency: res.currencySupported![0].currency,
                    Constants.beneMobileNumberDialCode: res.mobileCode
                  });
              print(
                  'flag====Currency==== ${res.currencySupported![0].currency}');
            }
          }
        }
      provider.sourceCountryName = provider
          .countryDestinationList!.response!.sourceCurrency!.countryName!;
      //  Navigator.pop(context, data.currencySupported[0].currency);
    });
  }
}
