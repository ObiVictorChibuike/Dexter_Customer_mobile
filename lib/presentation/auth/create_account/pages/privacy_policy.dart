import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/customer/widget/animated_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back, color: Colors.black, size: 20,)),
            title: Text("Privacy & Cookie Policy", style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20, fontWeight: FontWeight.w700,),
            ),
          ),
          body: AnimatedColumn(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              Text("Welcome to DEXTER!", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
A Website and Mobile Application developed, 
owned and operated by Dexter Pro Limited 
(hereinafter referred to as “the Company”) 
with a mission to render customised services 
to Customers in the Marine and Information 
Technology Sectors. It operates as a SaaS 
(Software as a Service) and E-commerce platform 
giving customers the critical functionality 
they need to connect with consumers, 
advertise and offer their products and services,
 accept payments, and grow their business. 
              """, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: black),),
              Text("1.	INTRODUCTION", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
1.1	This Terms and Conditions Agreement 
(the “Agreement”) is offered to Customers 
conditioned on the acceptance without 
modification of the Terms, Conditions, 
notices and Policies contained herein.

1.2	The following terminology applies 
to these Terms and Conditions, Privacy 
Statement and Disclaimer notice, and any 
or all Agreements: 
“Customers”, “You”, “Your”, or “Users” 
refers to the person accessing this 
platform and accepting the Company’s terms and conditions. 
“The Company”, is “Ourselves”, “We”, and “Us”.
”Party”, or “Parties”, refers to both the 
Customer and Ourselves, or either the 
Customer and Ourselves. 
“Services”, is “Dexter”, “Platform”, and 
“Website and Mobile Application”. 
All terms refer to the offer, acceptance 
and consideration of payment necessary to 
undertake the process of Our assistance to you in 
the most appropriate manner, whether through 
formal meetings of a fixed duration, or by 
any other means, with the express purpose 
of meeting your needs in terms of providing 
the Company’s declared Services, in accordance
 with and subject to applicable State laws. 
 Any use of the above terminology or other words 
 in the singular, plural, capital letters and/or 
 plural, and/or these terms, is considered 
 interchangeable and therefore a reference to them.
 
1.3	By accessing Dexter (clicking on the 
accept button at the end of the Agreement acceptance form), 
you agree, whether personally or on behalf of an 
entity, to be bound by the Terms and Conditions of 
this Agreement. When You undertake any activity on 
this platform, You agree to accept these Terms and 
Conditions.

1.4	Please read this entire Agreement carefully
 before accepting its Terms. In using Dexter, 
 You are deemed to have read, understood and 
 agreed to the following Terms and Conditions 
 set forth herein. Any website as well as any 
 other media form, media channel, mobile website 
 or mobile application related, incidental documents, 
 and links otherwise connected thereto mentioned 
 shall be accepted jointly with these Terms. 
 You agree to use the platform only in strict 
 interpretation and acceptance of these Terms, 
 and any actions or commitments made without 
 regard to these Terms shall be at your own risk. 

1.5	The services we offer are very diverse, 
so sometimes additional terms or product requirements
 may apply. Additional terms will be available with 
 the relevant services, and those additional 
 terms become part of your agreement with 
 us if you use those services.
              """, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: black),),
              Text("2.	ELIGIBLE USER", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
2.1	You may use the Platform only 
if you are at least (18) years of age 
and can form a binding contract with us, 
and only in compliance with this Agreement 
and all applicable local, State, national, 
and international laws, rules and regulations.

2.2	You may access Dexter via website 
or mobile application. We grant you a 
revocable, non-exclusive, non-transferrable, 
limited right to install, access and use 
on wireless electronic devices owned or 
controlled by You, in accordance with the 
Terms and Conditions contained herein. 
Unauthorised Users are strictly prohibited
 from accessing or attempting to access, 
 directly or indirectly, the Platform.
  Any such unauthorised use is strictly 
  forbidden and shall constitute a violation 
  of applicable national and state laws.

2.3	We may, in our sole discretion, refuse to offer access to or use of the Platform to any person or entity, and change our eligibility criteria at any time. This provision is void where prohibited by law and the right to access the platform is revoked in such jurisdictions.
              """),
              Text("3.	REGISTRATION AND SUBSCRIPTION", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
3.1	You will be required to register for a non-transferable account with Dexter using a username or email address and password. You agree to keep your password and payment details confidential. You, Your employees or a third party will be responsible for all disclosure and use of your account and password. Dexter is not liable for any loss or damage arising from any unauthorised use of your account. We however, reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable, or is in breach of these terms and conditions. You will be refunded in respect of this action.

3.2	During the Term and in accordance with this Agreement, Dexter grants you (your employees and all other designated users) access and use of the Platform, whether by full subscription, free trial or promotion, and each may include updates, cloud-based and support services, applications or documentation which are subject to the terms of this Agreement as applicable. Dexter owns  exclusively all rights; intellectual property, modifications, extensions, script and other derivative works on the Platform

3.3	In connection with Your use of the Platform and subject to this terms and conditions, You may download pages from our website for caching in a web browser, print pages from our website for your own personal and non-commercial use provided that such printing is not systematic or excessive, stream audio and video files from our website using the media player on our website, and we may send You service announcements, administrative messages, and other information. You may opt out of some of those communications. 

3.4	You shall pay Dexter the annual and/or monthly fees (“Fees”) specified on the Platform, in accordance with the timing and currency specified.  Unless required by applicable law, all payments by you to Dexter under this Agreement are non-refundable and made via the payment method chosen by you or as otherwise agreed in writing by the parties. You shall undertake any additional actions reasonably requested by Dexter to implement any automated Fee payment process. Any amounts past due shall accrue interest at a rate which is the lesser of: one and a half percent (1.5%) per month or the maximum rate allowable by law. Any assessment of late fees shall be without prejudice to Dexter’s right to suspend your access to the Platform. Any applicable goods and services or sales taxes will be added to Fees owing pursuant to this Agreement.

3.5	You acknowledge and agree that by registering, you are obligated to pay all of the Fees identified on our website/application (as applicable), and this Agreement, for the duration of the Current Term, and that any software subscription discounts or hardware discounts offered to you and/or identified are contingent upon the foregoing. Similarly, you acknowledge and agree that, by renewing your subscription, whether implicitly or explicitly, you are obligated to pay all of the Fees due under the renewed contract at the then-current prices for the duration of the Renewal Term. You further acknowledge and agree that any discounts offered under the initial registration shall not carry over or pertain to the Renewal Term, unless otherwise agreed to in writing.

3.6	You must notify us of any fee dispute within fifteen (15) days of the invoice date, and once resolved, you agree to pay these fees within fifteen (15) days. We may suspend or terminate your services if you do not pay undisputed fees, and you agree to reimburse us for all reasonable costs or expenses incurred in collecting the amounts.

              """),
              Text("4.	YOU AGREE AND CONFIRM", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
4.1	You will not access or use this Platform for any purpose other than that for which we make the Platform available. The Platform may not be used in connection with any commercial endeavours except those that are specifically endorsed or approved by us.

4.2	That you will use the services provided by Our Platform, its affiliates and contracted companies for lawful purposes only and comply with all applicable laws and regulations while using the Platform.

4.3	That you will provide authentic and true information in all instances where such information is requested of you. We reserve the right to confirm and validate the information and other details provided by you at any point in time. If upon confirmation your details are found not to be true (wholly or partly), we have the right in our sole discretion to reject the registration and debar You from using the services of Our Platform and/or other affiliated websites/links without prior intimation whatsoever.

4.4	That you are accessing the services made available by this Platform and transacting at your sole risk and are using your best and prudent judgment before entering into any dealings through this Platform.

4.5	It is possible that the other Users (including unauthorised/unregistered users or “hackers”) may post or transmit offensive or obscene materials on the Platform and that You may be involuntarily exposed to such offensive or obscene materials. It also is possible for others to obtain personal information about you due to your use of the Platform, and that the recipient may use such information to harass or injure you. We do not approve of such unauthorised uses, but by using the Platform, you acknowledge and agree that we are not responsible for the use of any personal information that you publicly disclose or share with others on the Platform. Please carefully select the type of information that you publicly disclose or share with others on the Platform.


4.6	 You agree to not post or transmit any unlawful, threatening, abusive, libellous, defamatory, obscene, vulgar, ponographic, profane or indecent information or description/images/text/graphic of any kind, including without limitation any transmissions constituting or encouraging conduct that would constitute a criminal offence, give rise to civil liability or otherwise violate any State, national, or international law.

4.7	You agree not to, without permission from us, systematically retrieve data or other content from the platform to create or compile, directly or indirectly, a collection, compilation, database, or directory.

4.8	You agree not to collect usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretences.

4.9	You agree to not post or transmit any information, software, or other material which violates or infringes the rights of others, including material which is an invasion of privacy or publicity rights or which is protected by copyright, trademark or other proprietary right, or derivative works with respect thereto, without first obtaining permission from the owner or right holder.

4.10	You agree to not alter, damage or delete any Content or other communications that are not your own Content or to otherwise interfere with the ability of others to access Our Platform.

4.11	You agree not to, and shall not allow any User or third party to,: 
a)	decompile, disassemble, reverse engineer or attempt to reconstruct or discover any source code, underlying ideas, algorithms, file formats or programming or interoperability interfaces of the Products, by any means whatsoever; 
b)	distribute viruses or other harmful or malicious computer code via or onto the Platform; 
c)	engage in any conduct that disrupts or impedes a third party’s use and enjoyment of the Platform; 
d)	remove any product identification, copyright or other notices from the Platform; 
e)	sell, lease, lend, assign, sublicense, grant access or otherwise transfer or disclose the products or services in whole or in part, to any third party; 
f)	modify or incorporate into or with other software or create a derivative work of any part of the services, unless agreed to in writing by Dexter; 
g)	use the output or other information generated by the Platform for any purpose other than as contemplated by this Agreement; 
h)	use the Platform for any use other than for your internal business use;
i)	use unauthorised modified versions of the Platform, including without limitation, for the purpose of building a similar or competitive product or service or for the purpose of obtaining unauthorised access to the Platform;
j)	 use the Platform in any way that is contrary to applicable state, federal, and foreign laws, including without limitation those relating to fiscal laws excise and import laws and VAT regulations, as well as anti-fraud. privacy, data protection, electronic communications and anti-spam legislation. Dexter retains all title to, and except as expressly licensed herein, all rights to the Platform, all copies, derivatives and improvements thereof, and all related materials.

4.12	You must follow any policies made available to you within the Platform. Do not misuse our services. We may suspend or stop providing our services to you if you do not comply with Our terms or policies or if we are investigating suspected misconduct.

              """),
              Text("5.	 WARRANTIES, REPRESENTATION AND UNDERTAKINGS", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
 
By using the platform You represent and warrant that:
5.1	You have legal capacity to enter into this Agreement and all obligations narrated under this Agreement are valid, binding and enforceable in law against You;	

5.2	registration information you submit will be true, accurate, current, and complete, and you will maintain the accuracy of such information and promptly update such registration information as necessary; 

5.3	there are no proceedings pending against you, which may have a material adverse effect on your ability to perform and meet the obligations under this Agreement;

5.4	you shall, at all times, ensure compliance with all Dexter policies, applicable laws and regulations, and the requirements applicable to your business, the use of this Services and for the purposes of this Agreement including but not limited to excise and import duties, etc. you further declare and confirm that you have paid and shall continue to discharge all your obligations towards statutory authorities;
<
5.5	you have legal capacity and adequate rights under relevant laws including but not limited to various intellectual property legislation(s) to enter into this Agreement with the Company and perform the obligations contained herein and that you have not violated/infringed any intellectual property rights of any third party.

5.6	where you or any of your Users imports lists into the platform for the purpose of sending electronic communication (e.g., email, text messages), or otherwise collect electronic addresses for the purpose of sending electronic messages, then you warrant that each person on such list has previously opted-in to receive promotional electronic communications from you (where applicable) and that the content of such communications by you will comply with applicable laws and regulations.

5.7	where you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the platform (or any portion thereof).

5.8	Dexter and you (each a “Receiving Party”) shall each retain in confidence all information received from the other party (the “Disclosing Party”) pursuant to or in connection with this Agreement, the product and/or services, that the Disclosing Party identifies as being proprietary and/or confidential or that, by the nature of the circumstances surrounding the disclosure, ought in good faith to be treated as proprietary and/or confidential (“Confidential Information”), and will make no use of such Confidential Information except as necessary to fulfil their respective obligations under this Agreement. Each party shall treat the terms and conditions of this Agreement as confidential; however, either party may disclose such information in confidence to its legal and financial consultants as required in the ordinary course of that party’s business. Notwithstanding the foregoing, the restrictions set forth above will not apply to (i) information previously known to the Receiving Party without reference to the Disclosing Party’s Confidential Information, (ii) information which is or becomes publicly known through no wrongful act of the Receiving Party, (iii) information that is independently developed by the Receiving Party without reference to the Disclosing Party’s Confidential Information, or (iv) information required to be disclosed pursuant to applicable law by enforceable orders of the court or other governmental authority. The foregoing shall also not prevent Dexter from using your Data on an aggregate and deidentified basis. You shall ensure that your Users fully comply with the terms of this Section and shall be responsible for any damages suffered by Dexter as a result of a User’s failure to do so.

              """),
              Text("6.	INTELLECTUAL PROPERTY RIGHTS", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
6.1	All Dexter’s source code, databases, functionality, software, website designs, audio, video, text, photographs, product names, service marks and logos are trademarks or registered trademarks are owned or controlled by Us. Nothing contained on Dexter should be interpreted as granting, by implication, estoppels, or otherwise, any license or right to use Dexter or any materials displayed on the platform, through the use of framing or otherwise, except: (a) as expressly permitted by these Terms and Conditions; or (b) with the prior written consent of Dexter. You shall not attempt to override or circumvent any of the usage rules or restrictions on Dexter.

6.2	You expressly authorise us to use your trademarks/copyrights/designs/ logos and other intellectual property owned and/or licensed by you for the purpose of reproduction on Dexter and at such other places as the Company may deem necessary. It is expressly agreed  and clarified that except as specified agreed in this Agreement, each Party shall retain all right, title and interest in their respective trademarks and logos and that nothing contained in this Agreement, nor the use of the trademarks/ logos in the publicity, advertising, promotional or other material in relation to the Platform shall be construed as giving to any Party any right, title or interest of any nature whatsoever to any of the other Party’s trademarks and/or logos.

6.3	Our website and other Platforms, and the information and materials that it contains, are our property and our licensors, and are protected from unauthorised copying reproduction, aggregation, republishing, uploading, posting, public display, encoding, translation, transmission, distribution, selling, licensing, exploitation for any commercial purpose whatsoever, and dissemination by copyright law, trademark law, international conventions, unfair competitions laws and other intellectual property laws. 

6.4	The Content and the Marks are provided on the Platform “AS IS” for your information and personal use only. Except as otherwise expressly granted to you in writing, we do not grant You any other express or implied right or license to our services. Our Content, copyrights or intellectual property rights.

6.5	The third party registered and unregistered trademarks or service marks on our platform are the property of the respective owners and we do not endorse and are not affiliated with any of the holders of any such rights and as such we cannot grant any license to exercise such rights.

6.6	Where you are eligible to use the platform, you are granted a limited license to access and use the platform and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. 
              """),
              Text("7.	DATA", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: black),),
              Text("""
7.1	“Data” means any and all identifiable information about you or your Users and their affiliates generated or collected by us or you, including but not limited to the User’s name, email, addresses, services availed, phone numbers, and the User’s preferences and tendencies, for processing in connection with this Agreement. You agree that it will only use the Data in complying with its obligations in this Agreement.

7.2	You represent, warrant, and covenant that you will not resell or otherwise disclose any Data to any third party, in whole or in part, for any purpose whatsoever.

7.3	You may select the Personal Data you input into the Platform at your sole discretion; Dexter has no control over the nature, scope, origin, and/or the means by which you acquire Personal Data processed by this Platform. Dexter will comply, and will ensure that your personnel comply, with the requirements of applicable privacy laws and regulations governing your Personal Data in Dexter’s possession or under our control. You are solely responsible for ensuring that it complies with any legal, regulatory or similar restrictions applicable to the types of data you elect to process with this Platform. You remain responsible for properly handling and processing notices regarding Personal Data of your clients and Users.

7.4	The Platform grants you the ability to independently backup and archive your Data. Accordingly, you are responsible for performing regular backups of your Data. Nevertheless, Dexter will regularly perform backups of your Data stored on the platform. Dexter will assist you in recovering and restoring your Data to the platform to the extent commercially feasible. You understand and agree that Dexter is not responsible for any loss or corruption of your Data or other software.

7.5	You shall be directly responsible to your users for any misuse of their Personal Data and Dexter shall bear no liability to your users in respect of any misuse of their Personal Data.

7.6	Dexter uses and protects your Data, including information transmitted via this platform, in accordance with Dexter’s Privacy Policy, located at https://www.Dexter.com/......./privacy-policy/ (the “Privacy Policy”). In addition to the permissions granted in the Privacy Policy, You allow Dexter to use and share non-personal data with third parties to build anonymous data profiles, provide segmented marketing information, create aggregate statistical reports, and improve current and new products and services. Dexter shall process all personal data obtained through the platform and related services in accordance with the terms of our privacy policy.

7.7	The Privacy Policy is incorporated into this Agreement by reference and form part of this Agreement, meaning that by entering into this Agreement, you are agreeing to the terms in that agreement.  
              """),
              Text("""
              8.	 PRODUCTS AND SERVICES

8.1	We will make every effort to display as accurately as possible the colours, features, specifications, and details of the products and/or services available on the Platform. However, we do not guarantee that the colours, features, specifications, and details of such products and/or services will be accurate, complete, reliable, current, or free of other errors, and your electronic display may not accurately reflect the actual colours and details of the products. 

8.2	All products/services are subject to availability, and we cannot guarantee that products will be in stock. We reserve the right to discontinue any product at any time for any reason. Prices for all products are subject to change.

8.3	You warrant that products sold via the Platform have good title and you are the sole legal and beneficial owner of the products and/or have the right to supply the products in accordance with this Agreement. The products are not subject to any third party rights or restrictions including third party intellectual property rights and/or any criminal insolvency or tax investigation or proceedings.

9.	PURCHASES

9.1	Where you wish to procure any product or service (the “Purchase”) made available through this Platform, You may be asked to supply certain information relevant to Your Purchase. 

9.2	We accept any binding procurement on your behalf but Dexter is not a party to the transaction between you and the consumer. Dexter only provides the Platform for you and the consumer to connect. Except if Dexter has its own product or service indicated on the Platform. Purchases will be binding when the consumer confirms a purchase via the Platform.


9.3	You and your consumer agree to provide current, complete, and accurate purchase and account information for all Purchases made via the Platform. And further agree to promptly update account and payment information, including email address, payment method, and payment card expiration date, so that we can complete your transactions and contact you as needed. All relevant taxes will be added to the price of Purchases as deemed required by us in compliance with the applicable laws, including all delivery charges, packaging charges, handling charges, administrative charges, insurance costs, other ancillary costs and charges where applicable which will only be payable by the consumer if this is expressly and clearly stated in the Purchase listing. Prices may change at any time.

9.4	You agree that Purchases, essentially products, must be of satisfactory quality, fit and safe for any purpose specified in and conform in all material respects to the Purchase listing and any other description of the Purchase supplied or performed by you.

9.5	You agree to ensure your consumer pay all charges at the prices then in effect for their Purchases and any applicable shipping fees, and you must be authorised to charge their chosen payment provider for any such amounts upon placing their order. 

9.6	Where the order is subject to recurring charges, then you must have consent to charge their payment method on a recurring basis without requiring their prior approval for each recurring charge, until such time as you cancel the applicable order. We reserve the right to correct any errors or mistakes in pricing, even if we have already requested or received payment.

9.7	We reserve the right to refuse any order placed through the Platform. We may, in our sole discretion, limit or cancel quantities purchased per person or per order. These restrictions may include orders placed by or under the same customer account, the same payment method, and/or orders that use the same billing or shipping address. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers, or distributors. 

9.8	We operate an anti-fraud and anti-money laundering compliance program and reserve the right to perform due diligence checks on all users of the Platform. You agree to provide to us all such information documentation and access to your business premises as we may require:
a)	in order to verify your adherence to and performance of your obligations under these terms and conditions;
b)	for the purpose of disclosures pursuant to a valid order by a court or other governmental body; or
c)	as otherwise required by law or applicable regulation.
10.	RETURN/REFUNDS POLICY

10.1	All sales are final and no refund will be issued. Please review our Return Policy posted on the Platform prior to making any purchases. 

10.2	Dexter will manage returned products by your consumers and you agree to accept same in accordance with our Return Policy. The Return Policy may be reviewed in accordance with the applicable laws.

10.3	Dexter will issue refunds on your behalf to your consumers only on returned products that failed to be delivered and you agree that we will act for you in accordance with our Refund Policy. Any other refunds will be subject to your terms and conditions of sale. Refunds will be according to the product price, local and/or international shipping fees (as stated on the refunds policy), and by way of mobile money transfer, bank transfers, or such other methods as specified. Our Refunds Policy may be reviewed in accordance with the applicable laws.

11.	SALES, PROMOTIONAL OFFER, PRICING
Sales, promotions and other special discounted pricing offers are temporary and, upon the renewal of your Subscription, any such discounted pricing offers may expire. We reserve the right to discontinue or modify any sales and special promotional offers in our sole discretion.
12.	TAX AND WITHHOLDING
You are responsible for all applicable sales, services, value added, products and services, withholding, tariffs, and similar taxes (collectively “Taxes”) if imposed by any government entity, or collecting agency based on the products and/or services offered on the Platform. Except those Taxes based on our net income, or for which you have provided an exemption certificate. Additionally, if you do not satisfy your Tax obligations, you agree that you will be required to reimburse us for any Taxes paid on your behalf, and we may take steps to collect Taxes we have paid on your behalf. In all cases, you will pay the amounts due under this Agreement to us in full without any right of set-off or deduction.

13.	YOUR CONTENT
13.1	Our Platform contains information, text, writings, links, graphics, photos or videos, audios, graphics, comments, suggestions or other materials (“Content”) including content created, submitted or posted by you or through your account (“Your Content”) which may be viewable by other users of the platform and through third party websites. you retain full ownership of all your Content and any intellectual or proprietary rights associated with it, and you are responsible for the Content that you post to the Platform, including its legality, reliability, and appropriateness. 

13.2	By posting your Content to the Platform, you grant Us the worldwide, royalty-free, perpetual, non-exclusive, irrevocable, transferrable, sub-licensable right and license, to host, use, copy, modify, adapt, disclose, prepare derivative works or incorporate other works, publicly perform, publicly display, reproduce, archive, cache, store, translate, reformat, transmit and distribute your Content on and through the Platform including any name, username, voice or likeness provided now known or later developed for any purpose, commercial, advertising, or otherwise. You retain any and all of your rights to any Content you submit, post or display on or through the Platform and You are responsible for protecting those rights. You agree that this license includes the right for Us to make Your Content available to other users of the Platform, including syndication, broadcast, distribution or publication by other companies, organisation, or individuals who partner with Dexter who may also use Your Content subject to these Terms.
13.3	You represent and warrant that the Content is Yours (You own it) or you have the right to use it and grant Us the rights and license as provided in these Terms, and the posting of Your Content on or through the Platform does not violate the privacy rights, publicity rights, copyrights, contract rights or any other rights of any person.
13.4	Any ideas, suggestions, and feedback about Dexter or our services that you provide to us are entirely voluntary, and you agree that Dexter may use such ideas, suggestions, and feedback without compensatory or obligation to you.
13.5	You agree that you irrevocably waive any claims and assertions of moral rights or attribution with respect to Your Content to the extent permitted by applicable law. 
14.	CONTENT RESTRICTIONS
14.1	Dexter is not responsible for the content of the Platform's users. You expressly understand and agree that you are solely responsible for the Content and for all activity that occurs under your account, whether done so by You or any third party using Your account.
14.2	You may not transmit any Content that is unlawful, offensive, upsetting, intended to disgust, threatening, libellous, defamatory, obscene or otherwise objectionable. Examples of such objectionable Content include, but are not limited to, the following:
a)	unlawful or promoting unlawful activity;
b)	defamatory, discriminatory, or mean-spirited content, including references or commentary about religion, race, sexual orientation, gender, national/ethnic origin, or other targeted groups;
c)	spam, machine – or randomly – generated, constituting unauthorised or unsolicited advertising, chain letters, any other form of unauthorised solicitation, or any form of lottery or gambling;
d)	installing any viruses, worms, malware, trojan horses, or other content that is designed or intended to disrupt, damage, or limit the functioning of any software, hardware or telecommunications equipment or to damage or obtain unauthorised access to any data or other information of a third person.
e)	infringing on any proprietary rights of any party, including patent, trademark, trade secret, copyright, right of publicity or other rights;
f)	impersonating any person or entity including Dexter and its employees or representatives;
g)	violating the privacy of any third person;
h)	false, inaccurate or misleading information and features.

14.3	Dexter reserves the right, but not the obligation, to screen, edit or monitor any Content or determine whether or not it is appropriate and complies with this Terms. We may, in our sole discretion, refuse, delete or remove Your Content at any time and for any reason including for a violation of these Terms, our Privacy Policy, or if you otherwise create liability for us. Dexter further reserves the right to make formatting and edits and change the manner of any Content. Dexter can also limit or revoke the use of the Platform if you post such objectionable Content. Though Dexter cannot control all content posted by users and/or third parties on the Platform, you agree to use the Platform at your own risk. You understand that by using the Platform You may be exposed to content that you may find offensive, indecent, incorrect or objectionable, and You agree that under no circumstances will Dexter be liable in any way for any content, including any errors or omissions in any content, or any loss or damage of any kind incurred as a result of your use of any content.
15.	CONTENT BACKUPS
15.1	Although regular backups of Content are performed, Dexter does not guarantee there will be no loss or corruption of data.
15.2	Corrupt or invalid backup points may be caused by, without limitation, Content that is corrupted prior to being backed up or which changes during the time a backup is performed.
15.3	Dexter will provide support and attempt to troubleshoot any known or discovered issues that may affect the backups of Content. But you acknowledge that Dexter has no liability related to the integrity of Content or the failure to successfully restore Content to a usable state.
15.4	You agree to maintain a complete and accurate copy of any Content in a location independent of the Platform.
16.	REVIEWS

16.1	We may provide you areas on the Platform to leave reviews or ratings which must comply with the following: 

a)	have a firsthand experience with the individual/entity being reviewed; 
b)	no offensive, profane, or abusive, racist, or hate language, discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability, and references to illegal activity; 
c)	 you should not be affiliated with competitors if posting negative reviews, or make any conclusions as to the legality of conduct; 
d)	you may not post any false or misleading statements, or organise a campaign encouraging others to post reviews, whether positive or negative.

16.2	We may accept, reject, or remove reviews in our sole discretion. We have absolutely no obligation to screen reviews or to delete reviews, even if anyone considers reviews objectionable or inaccurate. Reviews are not endorsed by us, and do not necessarily represent our opinions or the views of any of our affiliates or partners. 

16.3	We do not assume liability for any review or for any claims, liabilities, or losses resulting from any review. By posting a review, you hereby grant to us a perpetual, non-exclusive, worldwide, royalty-free, fully-paid, assignable, and sub-licensable right and license to reproduce, modify, translate, transmit by any means, display, perform, and/or distribute all content relating to reviews.

17.	TERM OF AGREEMENT

17.1	Unless otherwise agreed to in writing, the “Initial Term” means the duration specified on the via the confirmation email, beginning on the date of registration (the “Subscription Start Date”). If the Subscription Start Date is not explicitly nor implicitly identified, the Subscription Start Date shall be the date you execute, where applicable, unless otherwise agreed to in writing. Some software products or services may be made available to you on a date prior to the Subscription Start Date. If you use such software product or service to process taxable business transactions before such specified Subscription Start Date, then the Subscription Start Date will thereby be amended to such earlier date.

17.2	Upon expiration of the Initial Term and unless otherwise stated herein, this Agreement will automatically renew for a duration equal to the Initial Term (each a “Renewal Term”, the “Current Term” being the Initial Term or the then-current Renewal Term (as the case may be); and the Initial Term and all Renewal Terms collectively, the “Term”) until terminated by you or Dexter by delivery of written notice to the other party at least ninety (90) days prior to the end of the Current Term, or such period of notice equal to the Current Term where the Current Term is less than ninety (90) days. If none has been provided, the minimum period of notice required to be given will be thirty (30) days. In the case of services licensed on a trial basis, the Term of this Agreement shall be limited to the duration of the trial period specified on the Platform. Except as otherwise specified herein, you may not terminate this Agreement prior to the expiration of the Term. 

18.	SOFTWARE IN OUR SERVICES

18.1	When a service requires or includes downlodable software, this software may update automatically on your device once a new version or feature is available. Some services may let you adjust your automatic update settings.

18.2	We give you a personal, worldwide, royal-free, non-assignable and non-exclusive licence to use the software provided to you use it as part of the services on this Platform. This licence is for the sole purpose of enabling you to use and enjoy the benefit of this Platform as provided by us, in the manner permitted by these terms. You may not copy, modify, distribute, sell, or lease any part of our services or included software, nor may you reverse engineer or attempt to extract the source code of that software, unless laws prohibit those restrictions or you have our written permission.

19.	MODIFYING OUR SERVICES
We may constantly change and improve our Services and Dexter may add or remove functionalities or features, perform repairs or maintenance, upgrade product or service, suspend or stop a Service altogether. Dexter will endeavour to carry out such work during times that will cause the least disruption to your business. You will cooperate, if necessary, to perform such work. You may be required to take certain actions including, but not limited to, installing certain patches, fixes or updates, upgrading to a new version of a product and/or service or migrating to an alternative product or service. Such Changes may be made for reasons including, but not limited to:  (i) to comply with applicable law or regulation, (ii) for security reasons, (iii) due to changes imposed by a third party supplier, and/or (iv) due to the termination of our relationship with a third party supplier which is material for the provision of the Products.
20.	FEEDBACK
20.1	You assign all materials, rights, title and interest in any Feedback you provide Dexter, including but not limited to questions, comments, suggestions, ideas, plans, notes, drawings, modifications, improvements, original or creative materials or other information regarding Dexter or the products or services, whether such materials are provided in email, feedback forms, or any other format, it will belong exclusively to Dexter, without any requirement to acknowledge or compensate you. If for any reason such assignment is ineffective, you agree to grant Dexter a non-exclusive, perpetual, irrevocable, royalty free, worldwide right and license to use, reproduce, disclose, sub-license, distribute, modify and exploit such Feedback without restriction.
21.	OTHER WEBSITES
21.1	Our Platform may contain links to third-party websites or services that are not owned or controlled by Dexter and the “Third-Party Services” are products, applications, services, software, networks, systems, directories, websites, databases and information from third parties, including from Dexter Pro Limited, that one or more products or services link to, or which you may connect to or enable in conjunction with one or more products or services.
21.2	You may decide to enable, access or use any third-party services and you agree that access and use of such Third-Party Services shall be governed solely by the terms and conditions of such Third-Party Services. We strongly advise you to read the terms and conditions and privacy policies of any third-party websites or services that you visit.
21.3	Dexter has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Dexter will not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such content, products or services available on or through any such websites or services, content or data practices, or any interaction between you and the provider of such Third-Party Services, regardless of whether or not such Third-Party Services are provided by a third party that is a member of a Dexter partner program or otherwise designated by Dexter as “certified”, or “approved” by or “integrated” with Dexter. Any use by you of Third-Party Services shall be solely between you and the applicable third-party provider.
22.	API ACCESS
Your subscription with Dexter includes access to Dexter’s application programming interfaces (the “Dexter APIs”). Your access to and use of the Dexter APIs is governed by the Dexter API License Agreement located at https://developers.lightspeedhq.com/terms (the “API Agreement”), the terms of which are incorporated herein by reference. You acknowledge that the API Agreement provides Dexter with the latitude to limit or revoke your access to the Dexter APIs at any time in its sole discretion. You may engage a third-party developer to integrate into the Dexter APIs on your behalf, provided such third-party developer first enters into the API Agreement with Dexter and Dexter approves such third-party developer’s access in its sole discretion.  When you engage such a third-party developer, you become liable for the acts and omissions of such third-party developer to the same extent you would be liable under the API Agreement if such acts and omissions were those of yours.
23.	ASSIGNMENT AND SUBCONTRACTORS
You may not assign any of your rights or obligations under this Agreement without Dexter’s prior written consent. Dexter may, without your prior consent, assign your rights and obligations under this Agreement. Subject to the foregoing, the provisions of this Agreement shall be binding on and inure to the benefit not only of the parties hereto but also to their successors and permitted assigns. Dexter shall be free to perform all or any part of this Agreement through one or more subcontractors.
29.	EXPORT COMPLIANCE AND OTHER RESTRICTIONS
Products which Dexter may provide or make available to you may be subject to export control and economic sanctions laws. You agree to comply with all such laws and regulations as well as all laws and regulations applicable to your jurisdiction of origin, as they relate to the access and use of the products. You agree not to access this Platform from any jurisdiction in which the provision of the product is prohibited under any applicable laws or regulations (a “Proscribed Country”) or provide access to this Platform to any government, entity or individual located in any Proscribed Country. You represent, warrant, and covenant that (i) you are not a national of, or company registered in, any Proscribed Country; and (ii) you shall not permit third parties to access or use this Platform in violation of any applicable export embargoes, prohibitions or restrictions.
24.	CANCELLATION, SUSPENSION AND TERMINATION
24.1	You may cancel your services on this Platform after giving Dexter a twenty-four (24) hours notice of such cancellation. Where such a notice is not given, Dexter reserves the right to treat such action as a material breach of this Agreement.
24.2	Dexter may suspend your access to this Platform immediately without notice if Dexter, in its sole discretion, believes: (i) such suspension is required by law; (ii) there is a security or privacy risk to you; (iii) you are infringing or violating the rights of third parties, or acting in a manner that is abusive, profane or offensive; (iv) you do not pay our Fees or any invoices in a timely manner; or (v) you are in breach of any material provision of this Agreement, including its license restrictions or confidentiality obligations. Any suspension of your access to this Platform will not limit or waive Dexter’s rights to terminate this Agreement or your access to the products or services.
24.3	Where there is a material breach of this Agreement by either party, the non-breaching party may terminate this Agreement by giving the breaching party written notice specifying the nature of the breach in reasonable detail and the non-breaching party’s intention to terminate (a “Termination Notice”). If the breach has not been cured within the period ending thirty (30) days following delivery of the Termination Notice, then this Agreement shall automatically terminate.
24.4	Notwithstanding the foregoing, Dexter reserves the right, at any time and without notice, to terminate this Agreement if you violate the license restrictions under this Agreement. Upon termination of this Agreement, you must discontinue use of the Platform. But this does not limit your obligation to pay all of the applicable Fees, nor restrict Dexter from pursuing any available remedies, including injunctive relief. 
24.5	You agree that following termination of your account and/or use of this Platform, Dexter may immediately deactivate your account and delete your Data. You further agree that Dexter will not be liable to you nor to any third party for any termination of your access to the Platform or deletion of your Data in accordance with this Agreement. Sections discussing license restrictions, Fees and payment, representation, indemnification, and limitation of liability shall survive termination of this Agreement, along with any other provisions that are intended by their terms to survive.
24.6	Notwithstanding anything to the contrary in the Agreement, should the Agreement be terminated (a) by you prior to completion of the Current Term  for any reason other than breach by Dexter or (b) by Dexter for material breach by you, you will be charged an early termination fee calculated as the sum of: (i) any non-recurring Fees relating to the terminated Agreement(s) which have not been paid to Dexter as of the effective date of termination; and (ii) any recurring Fees under the Agreement that would have otherwise become due during the remainder of the Current Term; and (iii) the difference between the list price (as indicated on our website), and the discounted price (if any) on either software and/or Hardware that the you may have received during or pertaining to the Current Term (collectively, the “Early Termination Fee”). You authorise Dexter to collect the Early Termination Fee, and any applicable taxes due on such fee, according to the same payment methods and/or accounts for collecting amounts under the Agreement, and acknowledge that the Early Termination Fee shall be immediately due and payable in full. The Parties acknowledge and agree that the Early Termination Fee is a genuine and reasonable pre-estimate of the loss and damage suffered by Dexter in the event that you terminate prior to completion of the Current Term and not a penalty.
25.	LIMITATION OF LIABILITY

TO THE FULLEST EXTENT PERMISSIBLE BY APPLICABLE LAW; 
25.1	DEXTER’S AGGREGATE LIABILITY UNDER THIS AGREEMENT SHALL BE LIMITED TO THE FEES PAID BY YOU DURING THE THREE-MONTH PERIOD IMMEDIATELY PRECEDING THE DATE THE CLAIM GIVING RISE TO SUCH LIABILITY WAS FIRST ASSERTED. 

25.2	NEITHER PARTY SHALL BE LIABLE FOR ANY INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL, RELIANCE OR PUNITIVE DAMAGES OR LOSS OR IMPUTED PROFITS OR ROYALTIES, LOST DATA OR COST OF PROCUREMENT OF SUBSTITUTE PRODUCTS OR SERVICES, WHETHER FOR BREACH OF CONTRACT, WARRANTY, TORT, STATUTORY REMEDY OR ANY OBLIGATION ARISING THEREFROM OR OTHERWISE AND IRRESPECTIVE OF WHETHER EITHER PARTY HAS ADVISED OR BEEN ADVISED OF THE POSSIBILITY OF ANY SUCH LOSS OR DAMAGE.

25.3	YOU HEREBY WAIVE ANY CLAIM THAT THESE EXCLUSIONS DEPRIVE YOU OF AN ADEQUATE REMEDY. THE PARTIES ACKNOWLEDGE THAT THE PROVISIONS OF THIS SECTION FAIRLY ALLOCATE THE RISKS UNDER THIS AGREEMENT AS BETWEEN THEM. THE PARTIES ACKNOWLEDGE THAT THE LIMITATIONS SET FORTH IN THIS SECTION ARE INTEGRAL TO THE AMOUNT OF FEES CHARGED IN CONNECTION WITH MAKING THIS PLATFORM AVAILABLE TO YOU AND THAT, WERE DEXTER TO ASSUME FURTHER LIABILITY OTHER THAN AS SET FOR HEREIN, SUCH FEES WOULD OF NECESSITY BE SET SIGNIFICANTLY HIGHER.

25.4	DEXTER WILL NOT BE LIABLE OR INDEMNIFY YOU IN ANY WAY FOR ANY DAMAGES RESULTING DIRECTLY OR INDIRECTLY FROM YOUR OMISSION TO INSTALL ANY PATCH, FIX, UPDATE OR UPGRADE, AND/OR  ANY SERVICE CHANGES.

26.	DISCLAIMER

26.1	The information contained on this Platform is provided on an “as is” basis. To the fullest extent permitted by law, Dexter:
a)	excludes all representations and warranties with respect to this Platform and its content or that are or may be provided by affiliates and their respective licensors and service providers or any other third party, including with respect to any inaccuracy or omission in this Platform and/or Dexter’s documentation, all implied warranties of merchantability, fitness for a particular purpose, title and non-infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice.; 

b)	excludes any liability for damages arising out of or in connection with your use of this Platform and our subcontractors, we will not be responsible for lost profits, revenues, or data, financial losses or indirect, special, consequential, exemplary, punitive damages or damage caused to your computer, computer software, systems and programs and data relating thereto or any other direct or indirect, consequential or incidental damages;

c)	excludes any undertaking, and makes no representation of any kind that this Platform will meet your requirements, achieve any intended results, be compatible or work with any other software, applications, systems or services, operate without interruption, meet any performance or reliability standards or be error or virus free or that any errors or defects can or will be corrected.

26.	INDEMINIFICATION

26.1	You will indemnify, defend and hold harmless Dexter and our officers, employees, and agents from and against all losses, expenses, liabilities, damages and costs including, without limitation, reasonable legal fees (collectively “Costs”), so far as such Costs are attributable to any breach by you or any User, independent contractor, or affiliate thereof, of any representations, warranties or other obligations set forth in this Agreement.

26.2	Dexter will indemnify, defend and hold harmless you and your officers, employees, agents and affiliates from and against all Costs, so far as such Costs are attributable to the Platform infringing or misappropriating any registered third-party intellectual property right, including trademarks, patents and copyrights if Dexter is notified promptly in writing and given authority, information, and assistance for the defence or settlement of any related proceeding.
<
27.	FORCE MAJEUR
Neither party shall be deemed in default or otherwise liable for any delay in or failure of its performance under this Agreement (other than your payment obligations) by reason of any act of God, fire, natural disaster, accident, act of government, shortage of materials, failure of transportation or communication or of suppliers of products or services, or any other cause to the extent it is beyond the reasonable control of such party.
28.	GOVERNING LAW
This Terms and Your use of the Platform, and any dispute arising from the relationship between the parties to this Agreement, shall be governed by the Laws of the Federal Republic of Nigeria; excluding any laws or conflict of law rules. Your use of the Application may also be subject to other local, state, national, or international laws.

30.	DISPUTES RESOLUTION
30.1	Where you have any concern or dispute about this Platform, you agree to first try to resolve the dispute informally by contacting Dexter.
30.2	Any claim, dispute or controversy (whether in contract or tort, pursuant to statute or regulation, or otherwise, and whether pre-existing, present or future) arising out of or relating to: (i) this Agreement; (ii) the Products, services or equipment provided by Dexter; (iii) oral or written statements, or advertisements or promotions relating to this Agreement or to the Products, services or equipment; or (iv) the relationships that result from this Agreement (collectively the “Claim”) will be determined by arbitration to the exclusion of the courts. Arbitration will be conducted by one arbitrator pursuant to the laws and rules relating to commercial arbitration in effect on the date of the notice in the State or Federation.
30.3	In the event of any controversy or claim arising out of or relating to this Agreement, or the breach or interpretation thereof, the parties agree to submit to the exclusive jurisdiction of and venue of the courts under the applicable governing law. Each party hereby waives all defenses of lack of personal jurisdiction and forum nonconveniens in connection with any action brought in the foregoing courts. The prevailing party in any action or proceeding brought under this Agreement shall be entitled to recover from the other party, in addition to all other relief, its reasonable legal and other experts’ fees and expenses incurred with respect to such action or proceeding.
30.4	You agree to waive any right you may have to commence or participate in any class action or representative proceeding against Dexter related to any Claim and, where applicable, you also agree to opt out of any class or representative proceedings against Dexter.
30.5	Notwithstanding the foregoing provisions, (i) each party retains the right to seek injunctive or other equitable relief in a court of competent jurisdiction to prevent the actual or threatened infringement, misappropriation or violation of a party’s copyrights, trademarks, trade secrets, patents, or other intellectual property rights; and (ii) Dexter reserves the right to collect any outstanding amounts that you owe to Dexter in a court of competent jurisdiction.
31.	SEVERABILITY
Where any provision of these Terms is held to be invalid, illegal or unenforceable in any respect by a court of competent jurisdiction, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect.
32.	WAIVER
Except as provided herein, the failure to exercise a right or to require performance of an obligation under these Terms shall not effect a party's ability to exercise such right or require such performance at any time thereafter nor shall the waiver of a breach constitute a waiver of any subsequent breach.
33.	REVISION OF TERMS AND CONDITIONS
33.1	We reserve the right, at our sole discretion, to modify or replace these Terms at any time including making changes to the Fees and scope of the products and/or services. If a revision is material we will make reasonable efforts to provide at least thirty (30) days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.
33.2	By continuing to access or use our Platform after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, in whole or in part, please stop using the Platform and our services.
33.3	This Agreement, along with the Privacy Policy, …….., constitutes the entire agreement and understanding between the parties with respect to the subject matter hereof and supersedes all prior or contemporaneous written, electronic or oral communications, representations, agreements or understandings between the parties with respect thereto.
34.	NOTICES
34.1	You may address all notices, statements and other communications to Dexter to the following address:

34.2	This does not apply to the service of any proceedings or other documents in any legal action or, where applicable, any arbitration or other method of dispute resolution.
<
34.3	Dexter may provide any and all notices, statements and other communications to you through either email, posting on its website, an in-product message, or by mail or express delivery service.
35.	CONTACT US
For any questions about these Terms and Conditions, you can contact us by:
a)	visiting this page on our website: 
b)	sending us an email: info@
              """)
            ],
          ),
        )
    );
  }
}
