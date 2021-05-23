import SwiftUI

struct QuizLastQuestionsView: View {
  @Binding var questions: [String]

  var body: some View {
    VStack {
      ForEach(questions, id: \.self) {
        Text($0)
          .font(.body)
          .foregroundColor(.gray)
      }
    }
  }
}

struct QuizLastQuestionsView_Previews: PreviewProvider {
  static var previews: some View {
    QuizLastQuestionsView(questions: .constant(["7 x 6 = 42", "7 x 7 = 49"]))
  }
}
