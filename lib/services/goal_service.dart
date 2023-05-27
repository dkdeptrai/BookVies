import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/models/goal_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalService {
  Future<void> addGoal({required Goal goal}) async {
    try {
      if (goal.type == GoalType.reading.name) {
        final doc = readingGoalsRef.doc();
        goal.id = doc.id;
        await doc.set(goal.toMap());
      } else {
        final doc = watchingGoalsRef.doc();
        goal.id = doc.id;
        await doc.set(goal.toMap());
      }
    } catch (error) {
      print("Add goal error: $error");
    }
  }

  Future<Goal?> getReadingGoal() async {
    try {
      final snapshot = await readingGoalsRef
          .where("status", isEqualTo: GoalStatus.inProgress.name)
          .get();

      return Goal.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    } catch (error) {
      print("Get reading goal error: $error");
      return null;
    }
  }

  Future<Goal?> getWatchingGoal() async {
    try {
      final snapshot = await watchingGoalsRef
          .where("status", isEqualTo: GoalStatus.inProgress.name)
          .get();

      return Goal.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
    } catch (error) {
      print("Get watching goal error: $error");
      return null;
    }
  }

  Future<void> updateReadingGoal({required String type}) async {
    try {
      late final DocumentSnapshot doc;
      if (type == GoalType.reading.name) {
        final snapshot = await readingGoalsRef
            .where("status", isEqualTo: GoalStatus.inProgress.name)
            .get();
        doc = snapshot.docs.first;
      } else {
        final snapshot = await watchingGoalsRef
            .where("status", isEqualTo: GoalStatus.inProgress.name)
            .get();
        doc = snapshot.docs.first;
      }

      final Goal goal = Goal.fromMap((doc.data() as Map<String, dynamic>));
      if (goal.finishedAmount == goal.amount - 1) {
        await doc.reference.update({
          "finishedAmount": goal.finishedAmount + 1,
          "status": GoalStatus.finished.name,
        });
      } else {
        await doc.reference.update({
          "finishedAmount": goal.finishedAmount + 1,
        });
      }
    } catch (error) {
      print("Update watching goal error: $error");
    }
  }
}
