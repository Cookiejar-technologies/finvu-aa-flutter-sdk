import 'package:finvu_bank_pfm/core/utilities/constants.dart';
import 'package:finvu_bank_pfm/core/utilities/sizes.dart';
import 'package:finvu_bank_pfm/core/utilities/styleguide.dart';
import 'package:finvu_bank_pfm/presentation/widgets/title_subtitle_element.dart';
import 'package:flutter/material.dart';
import 'app_button.dart';
import 'bank_pill.dart';
import 'border_container.dart';
import 'footer_with_button.dart';

class ConsentDetailsBottomSheet extends StatelessWidget {
  const ConsentDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Sizes.h12,
                Text("Consent Details",
                  style: AppTypography.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDarkGrey
                  ),
                ),
                // Sizes.h16,
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: Constants.bankList.map((e){
                //       return BankPill(
                //         title: e,
                //         isSelected: Constants.bankList.indexOf(e) == 0,
                //         isFirst: Constants.bankList.indexOf(e) == 0,
                //       );
                //     }).toList()
                //   ),
                // ),
                Sizes.h24,
                const TitleSubtitleElement(title: "Purpose", subtitle: "Customer spending patterns, budget or other reportings"),
                Sizes.h16,
                const TitleSubtitleElement(title: "Information Updated", subtitle: "5 Times a Day"),
                Sizes.h16,
                const TitleSubtitleElement(title: "Account Information", subtitle: "Profile, Summary, Transactions"),
                Sizes.h16,
                const TitleSubtitleElement(title: "Account Types", subtitle: "Savings Accounts, Current Accounts"),
                Sizes.h16,
                const TitleSubtitleElement(title: "Details fetched will be from", subtitle: "30 May, 2021 to 30 May, 2031"),
                Sizes.h16,
                const TitleSubtitleElement(title: "Data Store", subtitle: "Until 10 years"),
                Sizes.h16,
                const Row(
                  children: [
                    Expanded(
                      child: TitleSubtitleElement(title: "Consent requested on", subtitle: "30 May 2022"),
                    ),
                    Expanded(
                      child: TitleSubtitleElement(title: "Consent expiry", subtitle: "30 May 2024"),
                    ),
                  ],
                ),
                Sizes.h24,
                FooterWithButton(
                  isE2E: true,
                  showPadding: false,
                  showButton: true,
                  buttonLabel: "Okay",
                  onButtonPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnLinkConfirmationSheet extends StatelessWidget {
  const UnLinkConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: MediaQuery.of(context).size.height*0.75,
        color: Colors.white,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Sizes.h12,
            Text("Are you sure you want to unlink?",
              style: AppTypography.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDarkGrey
              ),
            ),
            Sizes.h16,
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.bgRed,
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber, color: AppColors.red,),
                  Sizes.w12,
                  Expanded(
                    child: Text("You will no longer be able to see other account insights and balances on Canara Mobile app.")
                  ),
                  Sizes.h16,
                ],
              ),
            ),
            Sizes.h24,
            BorderContainer(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("PLEASE LET US KNOW WHAT WENT WRONG",
                    style: AppTypography.h2.copyWith(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Sizes.h12,
                  ...["Accurate information not available", "Security concerns","Some of my accounts are not listed"].map((e) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: Text(e),
                      value: false,
                      onChanged: (v){

                      }
                    );
                  }),
                ],
              )
            ),
            Sizes.h24,
            DarkAppButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Select Unlink stats"),
                      actions: [
                        DarkAppButton(
                          onPressed: (){
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => UnlinkStatus(
                            //     status: UnlinkResStatus.SUCCESS,
                            //     msg: "Accounts de-linked sccessfully!",
                            //   ))
                            // );
                          },
                          label: "Success"
                        ),
                        DarkAppButton(
                          onPressed: (){
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => UnlinkStatus(
                            //     status: UnlinkResStatus.FAILURE,
                            //     msg: "Accounts de-linked failed!",
                            //   ))
                            // );
                          },
                          label: "Failure"
                        )
                      ],
                    );
                  }
                );
              },
              label: "Okay"
            ),
            Sizes.h24
          ],
        ),
      ),
    );
  }
}

