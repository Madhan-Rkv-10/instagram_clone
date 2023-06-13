import '../../../features/home/post/models/comment_response_model.dart';
import '../../../features/home/post/models/post_and_coment_request_model.dart';
import 'file_type.dart';

extension Sorting on Iterable<Comment> {
  ///sorting based on DateTime
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);
              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
