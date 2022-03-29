import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';

class Terms extends StatelessWidget {
  Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_heading2.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          child: Column(
            children: [
              buildText.bigTitle("Terms & Conditions"),
              breaker(80),
              ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.1,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      buildText.heading2Text("1. General"),
                      breaker(20),
                      buildText.heading3Text(general),
                      breaker(10),
                      buildText.heading3Text(disclaimer),
                      breaker(40),
                      buildText.heading2Text(
                          "2. Description of Website and Service"),
                      breaker(20),
                      buildText.heading3Text(descWebsiteService),
                      breaker(40),
                      buildText.heading2Text(
                          "3. Registration, Submission of Content"),
                      breaker(20),
                      buildText.heading3Text(register),
                      breaker(40),
                      buildText.heading2Text(
                          "4. Your Representations and Warranties"),
                      breaker(20),
                      buildText.heading3Text(warranties),
                      breaker(40),
                      buildText.heading2Text("5. Inappropriate Use"),
                      breaker(20),
                      buildText.heading3Text(inappropriateUse),
                      breaker(40),
                      buildText.heading2Text("6. Indemnification of Handsfree"),
                      breaker(20),
                      buildText.heading3Text(indemnification),
                      breaker(40),
                      buildText.heading2Text("7. License to Apps"),
                      breaker(20),
                      buildText.heading3Text(license),
                      breaker(40),
                      buildText.heading2Text(
                          "8. Third-Party Links, Sites, and Services"),
                      breaker(20),
                      buildText.heading3Text(services),
                      breaker(40),
                      buildText.heading2Text(
                          "9. NO REPRESENTATIONS OR WARRANTIES BY HANDSFREE"),
                      breaker(20),
                      buildText.heading3Text(representations),
                      breaker(40),
                      buildText.heading2Text(
                          "10. LIMITATION ON TYPES OF DAMAGES/LIMITATION OF LIABILITY"),
                      breaker(20),
                      buildText.heading3Text(liability),
                      breaker(40),
                      buildText.heading2Text("11. Termination"),
                      breaker(20),
                      buildText.heading3Text(termination),
                      breaker(40),
                      buildText.heading2Text(
                          "12. Proprietary Rights in Service Content and Activity Materials"),
                      breaker(20),
                      buildText.heading3Text(materials),
                      breaker(40),
                      buildText.heading2Text("13. Trademarks"),
                      breaker(20),
                      buildText.heading3Text(trademarks),
                      breaker(40),
                      buildText.heading2Text("14. Privacy"),
                      breaker(20),
                      buildText.heading3Text(privacy),
                      breaker(40),
                      buildText.heading2Text("15. Promotion Code Terms"),
                      breaker(20),
                      buildText.heading3Text(promotion),
                      breaker(40),
                      buildText.heading2Text(
                          "16. Notice for Claims of Copyright Violations and Agent for Notice"),
                      breaker(20),
                      buildText.heading3Text(copyright),
                      breaker(40),
                      buildText.heading2Text(
                          "17. Governing Law and Arbitration; No Class Action"),
                      breaker(20),
                      buildText.heading3Text(law),
                      breaker(40),
                      buildText.heading2Text("18. Language"),
                      breaker(20),
                      buildText.heading3Text(language),
                      breaker(40),
                      buildText.heading2Text("19. Miscellaneous"),
                      breaker(20),
                      buildText.heading3Text(miscellaneous),
                      breaker(30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }

  String general =
      "Handsfree websites (“Websites”) and mobile applications (“Apps”) and related services (together with the Websites, the “Service”) are operated by Handsfree, Inc. (“Handsfree,” “us,” or “we”). Access and use of the Service is subject to the following Terms and Conditions of Service (“Terms and Conditions”). By accessing or using any part of the Service, you represent that you have read, understood, and agree to be bound by these Terms and Conditions including any future modifications. Handsfree may amend, update or change these Terms and Conditions. If we do this, we will post a notice that we have made changes to these Terms and Conditions on the Websites for at least 7 days after the changes are posted and will indicate at the bottom of the Terms and Conditions the date these terms were last revised. Any revisions to these Terms and Conditions will become effective the earlier of (i) the end of such 7-day period or (ii) the first time you access or use the Service after such changes. If you do not agree to abide by these Terms and Conditions, you are not authorized to use, access or participate in the Service.";
  String disclaimer =
      "PLEASE NOTE THAT THESE TERMS AND CONDITIONS CONTAIN A MANDATORY ARBITRATION OF DISPUTES PROVISION THAT REQUIRES THE USE OF ARBITRATION ON AN INDIVIDUAL BASIS TO RESOLVE DISPUTES IN CERTAIN CIRCUMSTANCES, RATHER THAN JURY TRIALS OR CLASS ACTION LAWSUITS. VIEW THESE TERMS HERE.";
  String descWebsiteService =
      "The Service allows users to access and use a variety of educational services, including learning or practicing a language. Handsfree may, in its sole discretion and at any time, update, change, suspend, make improvements to or discontinue any aspect of the Service, temporarily or permanently.";
  String register = """
  a. Registration
  In connection with registering for and using the Service, you agree (i) to provide accurate, current and complete information about you and/or your organization as requested by Handsfree; (ii) to maintain the confidentiality of your password and other information related to the security of your account; (iii) to maintain and promptly update any registration information you provide to Handsfree, to keep such information accurate, current and complete; and (iv) to be fully responsible for all use of your account and for any actions that take place through your account.

  b. Course Contributor Submissions
  If you are or become a Course Contributor, you may offer to translate or have translated certain existing courses into other languages and you may offer to contribute new courses to the Service, as agreed between you and Handsfree on a case-by-case basis. Subject to any guidelines posted on the Service, you may perform any such translations or create any such courses in accordance with your own schedule and using your own facilities and resources. You are not required to become a Course Contributor and you may cease your activities as a Course Contributor at any time. You acknowledge that you do not desire and will not receive compensation for your activities as a Course Contributor or for our use of any Course Contributor Materials (as defined below) you submit. Any translation of an existing Handsfree course you submit or have submitted and any new language course you submit or have submitted as a Course Contributor (collectively, “Course Contributor Materials”) are owned by you (subject of course to us retaining ownership of the existing Handsfree course you translated). By submitting any Course Contributor Material, you grant us a fully paid up, royalty-free, perpetual, sublicensable license to reproduce, display, perform, modify, create derivative works of, distribute and otherwise use such Course Contributor Material in any manner.

  c. General Content
  As a condition of submitting any ratings, reviews, information, data, text, photographs, audio clips, audiovisual works, translations, flashcards or other materials on the Services (“Content”), you hereby grant to Handsfree a royalty free, perpetual, irrevocable, worldwide, nonexclusive, transferable, and sublicensable license to use, reproduce, copy, adapt, modify, merge, distribute, publicly display, create derivative works from, incorporate such Content into other works; sublicense through multiple tiers the Content, and acknowledge that this license cannot be terminated by you once your Content is submitted to the Services. You represent that you own or have secured all legal rights necessary for the Content submitted by you to be used by you, Handsfree, and others as described and otherwise contemplated in these Terms and Conditions. You understand that other users will have access to the Content and that neither they or Handsfree have any obligation to you or anyone else to maintain the confidentiality of the Content.

  """;
  String warranties =
      """You represent and warrant to Handsfree that your access and use of the Service will be in accordance with these Terms and Conditions and with all applicable laws, rules and regulations of the United States and any other relevant jurisdiction, including those regarding online conduct or acceptable content, and those regarding the transmission of data or information exported from the United States and/or the jurisdiction in which you reside. You further represent and warrant that you have created or own any material you submit via the Service (including Translation Materials, Course Contributor Materials, Activity Materials, and Content) and that you have the right, as applicable, to grant us a license to use that material as set forth above or the right to assign that material to us as set forth below.
    ent and warrant that (1) you are not organized under the laws of, operating from, or otherwise ordinarily resident in a country or territory that is the target or comprehensive U.S. economic or trade sanctions (i.e., an embargo) or (2) identified on a list of prohibited or restricted persons, such as the U.S. Treasury Department’s List of Specially Designated Nationals and Blocked Persons, or (3) otherwise the target of U.S. sanctions.""";
  String inappropriateUse =
      "You will not upload, display or otherwise provide on or through the Service any content that: (i) is libelous, defamatory, abusive, threatening, harassing, hateful, offensive or otherwise violates any law or infringes upon the right of any third party (including copyright, trademark, privacy, publicity or other personal or proprietary rights); or (ii) in Handsfree’s sole judgment, is objectionable or which restricts or inhibits any other person from using the Service or which may expose Handsfree or its users to any harm or liability of any kind.";
  String indemnification =
      "You agree to defend, indemnify and hold harmless Handsfree and its directors, officers, employees, contractors, agents, suppliers, licensors, successors and assigns, from and against any and all losses, claims, causes of action, obligations, liabilities and damages whatsoever, including attorneys' fees, arising out of or relating to your access or use of the Service, any false representation made to us (as part of these Terms and Conditions or otherwise), your breach of any of these Terms and Conditions, or any claim that any translation we provide to you is inaccurate, inappropriate or defective in any way whatsoever.";
  String license =
      "Subject to the terms of these Terms and Conditions, Handsfree grants you a non-transferable, non-exclusive license to download, install, and use one copy of each App in object code form only on an interactive wireless device that you own or control. You may not derive or attempt to derive the source code of all or any portion of any App, permit any third party to derive or attempt to derive such source code, or reverse engineer, decompile, disassemble, or translate any App or any part thereof. Handsfree and its licensors own and shall retain all intellectual property rights and other rights in and to the Apps, and any changes, modifications, or corrections thereto. The following terms and conditions apply to you only if you are using the Apps from the Apple App Store. To the extent the other terms and conditions of these Terms and Conditions are less restrictive than, or otherwise conflict with, the terms and conditions of this paragraph, the more restrictive or conflicting terms and conditions in this paragraph apply, but solely with respect to Apps from the Apple App Store. You acknowledge and agree that these Terms and Conditions are solely between you and Handsfree, not Apple, and that Apple has no responsibility for the Apps or content thereof. Your use of any App must comply with the App Store Terms of Service. You acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the Apps. In the event of any failure of any App to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price, if any, for the App to you; to the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the Apps, and any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty will be solely governed by these Terms and Conditions. You and Handsfree acknowledge that Apple is not responsible for addressing any claims of you or any third party relating to the Apps or your possession and/or use of any App, including, but not limited to: (i) product liability claims; (ii) any claim that an App fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection or similar legislation. You and Handsfree acknowledge that, in the event of any third-party claim that any App or your possession and use of that App infringes that third party’s intellectual property rights, Handsfree, not Apple, will be solely responsible for the investigation, defense, settlement and discharge of any such intellectual property infringement claim to the extent required by these Terms and Conditions. You must comply with applicable third party terms of agreement when using any App. You and Handsfree acknowledge and agree that Apple, and Apple’s subsidiaries, are third party beneficiaries of these Terms and Conditions as they relate to your license of the Apps, and that, upon your acceptance of these Terms and Conditions, Apple will have the right (and will be deemed to have accepted the right) to enforce these Terms and Conditions against you as a third party beneficiary thereof.";
  String purchases = "";
  String services =
      """The Service may contain links to third-party websites, advertisers, services, special offers, or other events or activities that are not owned or controlled by Handsfree. We do not endorse or assume any responsibility for any such third-party sites, information, materials, products, or services. If you access any third party website, service, or content from Handsfree, you understand that these Terms and Conditions and our Privacy Policy do not apply to your use of such sites. You expressly acknowledge and agree that Handsfree shall not be responsible or liable, directly or indirectly, for any damage or loss arising from your use of any third-party website, service, or content.

The Service may include advertisements, which may be targeted to the Content or information on the Service, or other information. The types and extent of advertising by Handsfree on the Service are subject to change. In consideration for Handsfree granting you access to and use of the Service, you agree that Handsfree and its third party providers and partners may place such advertising in connection with the display of content or information submitted by you or others.""";
  String representations =
      "THE SERVICE, INCLUDING ALL IMAGES, AUDIO FILES AND OTHER CONTENT THEREIN, AND ANY OTHER INFORMATION, PROPERTY AND RIGHTS GRANTED OR PROVIDED TO YOU BY DUOLINGO ARE PROVIDED TO YOU ON AN “AS IS” BASIS. DUOLINGO AND ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES OF ANY KIND WITH RESPECT TO THE SERVICE, EITHER EXPRESS OR IMPLIED, AND ALL SUCH REPRESENTATIONS AND WARRANTIES, INCLUDING WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT, ARE EXPRESSLY DISCLAIMED. WITHOUT LIMITING THE GENERALITY OF THE FOREGOING, DUOLINGO DOES NOT MAKE ANY REPRESENTATION OR WARRANTY OF ANY KIND RELATING TO ACCURACY, SERVICE AVAILABILITY, COMPLETENESS, INFORMATIONAL CONTENT, ERROR-FREE OPERATION, RESULTS TO BE OBTAINED FROM USE, OR NON-INFRINGEMENT. ACCESS AND USE OF THE SERVICE MAY BE UNAVAILABLE DURING PERIODS OF PEAK DEMAND, SYSTEM UPGRADES, MALFUNCTIONS OR SCHEDULED OR UNSCHEDULED MAINTENANCE OR FOR OTHER REASONS. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES, SO THE ABOVE EXCLUSION MAY NOT APPLY TO YOU.";
  String liability =
      "IN NO EVENT WILL DUOLINGO BE LIABLE TO YOU OR ANY THIRD PARTY CLAIMING THROUGH YOU (WHETHER BASED IN CONTRACT, TORT, STRICT LIABILITY OR OTHER THEORY) FOR INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES ARISING OUT OF OR RELATING TO THE ACCESS OR USE OF, OR THE INABILITY TO ACCESS OR USE, THE SERVICE OR ANY PORTION THEREOF, INCLUDING BUT NOT LIMITED TO THE LOSS OF USE OF THE SERVICE, INACCURATE RESULTS, LOSS OF PROFITS, BUSINESS INTERRUPTION, OR DAMAGES STEMMING FROM LOSS OR CORRUPTION OF DATA OR DATA BEING RENDERED INACCURATE, THE COST OF RECOVERING ANY DATA, THE COST OF SUBSTITUTE SERVICES OR CLAIMS BY THIRD PARTIES FOR ANY DAMAGE TO COMPUTERS, SOFTWARE, MODEMS, TELEPHONES OR OTHER PROPERTY, EVEN IF DUOLINGO HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. DUOLINGO’S LIABILITY TO YOU OR ANY THIRD PARTY CLAIMING THROUGH YOU FOR ANY CAUSE WHATSOEVER, AND REGARDLESS OF THE FORM OF THE ACTION, IS LIMITED TO THE AMOUNT PAID, IF ANY, BY YOU TO DUOLINGO FOR THE SERVICE IN THE 12 MONTHS PRIOR TO THE INITIAL ACTION GIVING RISE TO LIABILITY. THIS IS AN AGGREGATE LIMIT. THE EXISTENCE OF MORE THAN ONE CLAIM HEREUNDER WILL NOT INCREASE THIS LIMIT.";
  String termination =
      "Handsfree may terminate your access and use of the Service immediately at any time, for any reason, and at such time you will have no further right to use the Service. You may terminate your Handsfree account at any time by following the instructions available through the Service. The provisions of these Terms and Conditions relating to the protection and enforcement of Handsfree’s proprietary rights, your representations and warranties, disclaimer of representations and warranties, release and indemnities, limitations of liability and types of damages, ownership of data and information, governing law and venue, and miscellaneous provisions shall survive any such termination.";
  String materials =
      "All content available through the Service, including designs, text, graphics, images, information, software, audio and other files, and their selection and arrangement (the 'Service Content'), are the proprietary property of Handsfree or its licensors. No Service Content may be modified, copied, distributed, framed, reproduced, republished, downloaded, scraped, displayed, posted, transmitted, or sold in any form or by any means, in whole or in part, other than as expressly permitted in these Terms and Conditions. You may not use any data mining, robots, scraping or similar data gathering or extraction methods to obtain Service Content. As between you and Handsfree, all data, information and materials generated from your access and use of the educational activities made available on or through the Service, including translated content generated by you (collectively, the “Activity Materials”), shall be exclusively owned by Handsfree, and you shall not have any right to use such Activity Materials except as expressly authorized by these Terms and Conditions. Activity Materials will not include Translation Materials. By using the Service, you hereby assign to Handsfree any and all rights, title and interest, including any intellectual property rights or proprietary rights, in the Activity Materials. All rights of Handsfree or its licensors that are not expressly granted in these Terms and Conditions are reserved to Handsfree and its licensors.";
  String trademarks =
      "“Handsfree” and all other trademarks, service marks, graphics and logos used in connection with the Service are trademarks or service marks of Handsfree or their respective owners, and certain of them are registered with the United States Patent and Trademark Office. Access and use of the Service does not grant or provide you with the right or license to reproduce or otherwise use the Handsfree name or any Handsfree or third-party trademarks, service marks, graphics or logos.";
  String privacy =
      "Use of the Service is also governed by our Privacy Policy, a copy of which is located at www.duolingo.com/privacy. By using the Service, you consent to the terms of the Privacy Policy";
  String promotion =
      """Handsfree Promotion Codes (each a “Promotional Code”) are made available by Handsfree (either directly or through a partner) subject to the Terms and Conditions of Service (“Terms and Conditions”). Each Promotional Code is made available in connection with a form of an auto-renewing periodic subscription (as defined in the Terms and Conditions).

The Promotional Code.
Each Promotional Code provides access to Handsfree Plus: A. at the price advertised; and B. beginning the moment that you confirm your acceptance of the Promotional Code by submitting valid payment details that are accepted by Handsfree (the “Promotional Period”); and C. in some circumstances, subject to an overall limit of allowed redemptions of that Promotional Code. By submitting your payment details, you (i) confirm your acceptance of the Promotional Code advertised; (ii) accept and agree to these Promotional Code Terms; and (iii) acknowledge and agree to the Terms and Conditions.

Eligibility.
In order to be eligible for a Promotional Code, users must satisfy all of the following conditions (each an “Eligible User”): A. Unless you are subscribing to a Promotional Code that is advertised as available to current subscribers, you must not be a current subscriber. B. Provide Handsfree with a valid and current payment method that is approved by Handsfree. C. Additional eligibility requirements (if any) as advertised from time-to-time in connection with a Promotional Code. Eligible Users may accept a Promotional Code once - previous users may not redeem the offer again.

Availability.
A Promotional Code must be accepted before the applicable expiration date advertised, if any. Except where prohibited by law, Handsfree reserves the right to modify, suspend or terminate a Promotional Code at any time and for any reason, in which case we will not honour subsequent Promotional Code enrollments.

Duration and cancellation.
Unless you cancel your subscription before the end of the Promotional Period, you will automatically become a recurring subscriber and your Handsfree Plus subscription will continue to automatically renew for additional periods equal to the expiring subscription term, unless you cancel before the end of the relevant subscription term pursuant to Handsfree’s terms and conditions. The payment method you provided will automatically be charged for the then-current subscription price. If you cancel during the Promotional Period, you will lose access to Handsfree Plus and you understand and agree that you will receive no refund or exchange of any kind, including for any unused virtual currency or other Virtual Item, any Content or data associated with your use of the Service, or for anything else.""";
  String copyright =
      """If you are a copyright owner and have a good faith belief that any material available through the Service infringes upon your copyrights, you may submit a copyright infringement notification to Handsfree pursuant to the Digital Millennium Copyright Act by providing us with the following information in writing:

an electronic or physical signature of the copyright owner or the person authorized to act on behalf of the owner of the copyright interest;
a description of the copyrighted work that you claim has been infringed;
a description of where the material that you claim is infringing is located on the Service, with enough detail that we may find it on the Service;
your address, telephone number, and email address;
a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; and
a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or are authorized to act on the copyright owner's behalf.

Please consult your legal counsel for further details or see 17 U.S.C. §512(c)(3). Handsfree’s Agent for Notice of claims of copyright infringement can be reached as follows:

By mail: 5900 Penn Avenue, Pittsburgh PA 15206, USA
By email: abuse@duolingo.com

Governing Law and Arbitration""";
  String law =
      """These Terms and Conditions, its subject matter and Handsfree’s and your respective rights under these Terms and Conditions, as well as and any claim, cause of action or dispute (“claim”) arising out of or related to these Terms and Conditions, shall be governed by and construed under the laws of the Commonwealth of Pennsylvania, United States of America, excluding the conflict of law provisions of that or any other jurisdiction, regardless of your country of origin or where you access the Service. ANY DISPUTE OR CLAIM RELATING IN ANY WAY TO THESE TERMS AND CONDITIONS OR THE SERVICE WILL BE RESOLVED BY BINDING ARBITRATION, RATHER THAN IN COURT, except for Handsfree’s right to seek injunctive relief as set forth below. Unless otherwise expressly required by applicable law, each party shall bear its own attorneys’ fees without regard to which party is deemed the prevailing party in the arbitration proceeding.

If you do not want to arbitrate disputes with Handsfree and you are an individual, you may opt out of this arbitration agreement by sending an email to legal@duolingo.com within 30 days of the day you first access or use the Service.

If you intend to seek arbitration you must first send written notice to Handsfree’s Administration Office of your intent to arbitrate (“Notice”). The Notice to Handsfree should be sent by any of the following means: (i) electronic mail to legal@duolingo.com; or (ii) sending the Notice by U.S. Postal Service certified mail to Handsfree, Inc., Attention: Legal, 5900 Penn Ave; Pittsburgh, PA 15206. The Notice must (x) describe the nature and basis of the claim or dispute; and (y) set forth the specific relief sought; and (z) set forth your name, address and contact information. If we intend to seek arbitration against you, we will send any notice of dispute to you at the contact information we have for you.

The arbitration will be conducted before a neutral single arbitrator in the County of Allegheny in the Commonwealth of Pennsylvania, whose decision will be final and binding, and the arbitral proceedings will be governed by JAMS under its Comprehensive Arbitration Rules and Procedures (the “JAMS Rules”) as modified by these Terms and Conditions. The JAMS Rules are available at www.jamsadr.com. All issues are for the arbitrator to decide, including the scope of this arbitration clause, but the arbitrator is bound by the terms of these Terms and Conditions. If you initiate arbitration, your arbitration fees will be limited to the filing fee set forth in the JAMS Rules. We will reimburse all other JAMS filing, administration and arbitrator fees paid by you, unless the arbitrator determines that the arbitration was frivolous or brought for an improper purpose, in which case the payment of all such fees shall be governed by the JAMS Rules. The arbitration will be conducted in the English language. Judgment on the award rendered by the arbitrator may be entered in any court of competent jurisdiction. For any claim where the potential award is reasonably likely to be \$10,000 or less, either you or Handsfree may elect to have the dispute resolved through non-appearance-based arbitration.

To the fullest extent permitted by applicable law, YOU AND DUOLINGO EACH AGREE THAT ANY DISPUTE RESOLUTION PROCEEDING WILL BE CONDUCTED ONLY ON AN INDIVIDUAL BASIS AND NOT IN A CLASS, CONSOLIDATED OR REPRESENTATIVE ACTION. If for any reason a claim proceeds in court rather than in arbitration, YOU AND DUOLINGO EACH WAIVE ANY RIGHT TO A JURY TRIAL. If a court of competent jurisdiction finds the foregoing arbitration provisions invalid or inapplicable, you and Handsfree agree that all claims arising out of or related to these Terms and Conditions must be resolved exclusively by a state or federal court located in the County of Allegheny in the Commonwealth of Pennsylvania, and you and Handsfree each agree to submit to the exercise of personal jurisdiction of such courts for the purpose of litigating all such claims. Notwithstanding the above, you agree that Handsfree shall still be allowed to apply for and obtain injunctive remedies (or an equivalent type of urgent legal relief) in any jurisdiction.""";
  String language =
      "This agreement was originally written in English (US). To the extent any translated version of this agreement conflicts with the English version, the English version controls.";
  String miscellaneous =
      "These Terms and Conditions constitute the entire agreement between Handsfree and you concerning the subject matter hereof. In the event that any of the Terms and Conditions are held by a court or other tribunal of competent jurisdiction to be unenforceable, such provisions shall be limited or eliminated to the minimum extent necessary so that these Terms and Conditions shall otherwise remain in full force and effect. A waiver by Handsfree or you of any provision of these Terms and Conditions or any breach thereof, in any one instance, will not waive such term or condition or any subsequent breach thereof. Handsfree may assign its rights or obligations under these Terms and Conditions without condition. These Terms and Conditions will be binding upon and will inure to the benefit of Handsfree and you, and Handsfree's and your respective successors and permitted assigns.";
}
