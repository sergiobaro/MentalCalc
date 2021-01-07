import SwiftUI

struct QuizScoreView: View {

  @Binding var correct: Int
  @Binding var attemps: Int

  var body: some View {
    HStack {
      VStack {
        Text("Correct:")
          .font(.caption)
        Text("\(correct)")
          .font(.title)
      }
      VStack {
        Text("Attempts:")
          .font(.caption)
        Text("\(attemps)")
          .font(.title)
      }
    }
  }
}

struct QuizScoreView_Previews: PreviewProvider {
  static var previews: some View {
    QuizScoreView(correct: .constant(99), attemps: .constant(99))
  }
}
