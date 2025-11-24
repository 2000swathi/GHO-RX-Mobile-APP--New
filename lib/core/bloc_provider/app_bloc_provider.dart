import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/acc_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bankinforepo.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/repository/delete_repository.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/repo/bloc/doctfile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/repo/doct_file_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/bloc/education_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/education_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/insurance_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/bloc/language_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/language_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/bloc/license_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/license_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/list_repository.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/bloc/profile_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/profile_info_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/profile_pic_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/bloc/specialty_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/specialty_repo.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/auth_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/bloc/q_and_a_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/q_and_a_save_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/case_det_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/get_file_id_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/summary/repository/bloc/summary_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/summary/repository/summary_reo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/attestation_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/bloc/attest_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/repository/bloc/final_submission_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/repository/final_submit_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/bloc/open_closed_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/repository/open_closed_repo.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/key_perfomance_repo.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/repository/date_range_repo.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/home_repository.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/bloc/earnings_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/earnings_repo.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/bloc/payment_graph_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/month/bloc/month_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/month/month_repo.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/payment_graph_repo.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/bloc/payment_bloc.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/payment_repo.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/bloc/sendmail_bloc.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/sendmail_repo.dart';
import 'package:ghorx_mobile_app_new/features/splash/bloc/spalsh_event.dart';
import 'package:ghorx_mobile_app_new/features/splash/bloc/splash_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc()..add(SplashStarted()),
        ),

        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
        ),

        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(repository: HomeRepository()),
        ),

        BlocProvider<ListBloc>(
          create: (_) => ListBloc(repository: ListRepository()),
        ),

        BlocProvider<DeleteBloc>(
          create: (_) => DeleteBloc(repository: DeleteProfileRepository()),
        ),

        BlocProvider<OpenClosedBloc>(
          create: (_) => OpenClosedBloc(repository: OpenClosedRepository()),
        ),

        BlocProvider<CaseDetailsBloc>(
          create: (_) => CaseDetailsBloc(repository: CaseDetRepository()),
        ),

        BlocProvider<QAndABloc>(
          create: (_) => QAndABloc(repository: QAndASaveRepo()),
        ),

        BlocProvider<SummaryBloc>(
          create: (_) => SummaryBloc(repository: SummaryReo()),
        ),

        BlocProvider<GetFileIdBloc>(
          create: (_) => GetFileIdBloc(repository: GetFileIDReo()),
        ),

        BlocProvider<AttestBloc>(
          create: (_) => AttestBloc(repository: AttestationRepo()),
        ),

        BlocProvider<FinalSubmissionBloc>(
          create: (_) => FinalSubmissionBloc(repository: SubmitCaseRepo()),
        ),

        BlocProvider<DateRangeBloc>(
          create: (_) => DateRangeBloc(repository: DateRangeRepo()),
        ),

        BlocProvider<SendmailBloc>(
          create: (_) => SendmailBloc(repository: SendEmailRepository()),
        ),

        BlocProvider<KeyPerformanceBloc>(
          create: (_) => KeyPerformanceBloc(repository: KeyPerRepo()),
        ),

        BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(repository: PaymentRepo()),
        ),

        BlocProvider<EarningsBloc>(
          create: (_) => EarningsBloc(repository: EarningsRepo()),
        ),

        BlocProvider<MonthBloc>(
          create: (_) => MonthBloc(repository: MonthRepo()),
        ),

        BlocProvider<PaymentGraphBloc>(
          create: (_) => PaymentGraphBloc(repository: PaymentGraphRepo()),
        ),

        BlocProvider<ProfileInfoBloc>(
          create: (_) => ProfileInfoBloc(repository: ProfileInfoRepo()),
        ),

        BlocProvider<SpecialtyBloc>(
          create: (_) => SpecialtyBloc(repository: SpecialtyRepo()),
        ),

        BlocProvider<AccreditationBloc>(
          create: (_) => AccreditationBloc(repository: AccRepo()),
        ),

        BlocProvider<InsuranceBloc>(
          create: (_) => InsuranceBloc(repository: InsuranceRepo()),
        ),

        BlocProvider<LicenseBloc>(
          create: (_) => LicenseBloc(repository: LicenseRepo()),
        ),

        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc(repository: LanguageRepo()),
        ),

        BlocProvider<BankInfoBloc>(
          create: (_) => BankInfoBloc(repository: Bankinforepo()),
        ),

        BlocProvider<PicBloc>(
          create: (_) => PicBloc(repository: ProfilePicRepo()),
        ),

        BlocProvider<EducationBloc>(
          create: (_) => EducationBloc(repository: EducationRepo()),
        ),

        BlocProvider<DoctfileBloc>(
          create: (_) => DoctfileBloc(repository: DoctFileRepo()),
        ),
      ],
      child: child,
    );
  }
}
