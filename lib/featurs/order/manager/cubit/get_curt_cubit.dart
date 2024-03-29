import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../Core/servers/data_base_methouds.dart';

part 'get_curt_state.dart';

class GetCurtCubit extends Cubit<GetCurtState> {
  GetCurtCubit() : super(GetCurtInitial());

 reedCart()async{
  var data = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('curt');

     if(data.doc()!=null){
     DataBaseMethouds().getCart();

       emit(GetCurtSuccess());
     }else{
       emit(GetCurtError());
     }
  }

  
 }


