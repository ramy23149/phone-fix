import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/featurs/wallet/data/repos/wallet_repo.dart';
import 'package:food_delivery_app/featurs/wallet/presentaion/manager/add_mony_cubit/add_mony_state.dart';

class AddMonyCubit extends Cubit<AddMonyState> {
  AddMonyCubit(this.walletRepo) : super(AddMonyInitial());
  final WalletRepo walletRepo;

  Future<void> addMony(int amount) async {
    emit(AddMonyLoading());
    var result = await walletRepo.makePayment(amount, 'USD');
    result.fold(
      (falier) => emit(AddMonyFailure(falier.errMasessge)),
      (r) => emit(AddMonySuccess()),
    );
  }
}
