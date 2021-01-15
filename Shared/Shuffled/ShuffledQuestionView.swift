import SwiftUI
import Generators

struct ShuffledQuestionView: View {

  let question: ShuffledQuestion
  let action: () -> Void

  var body: some View {
    HStack {
      Spacer()
      Text(question.question.questionText)
      Text(question.inputText)
        .frame(width: 100, height: 35)
        .background(
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .stroke(question.borderColor, lineWidth: question.borderWidth)
        )
        .onTapGesture {
          action()
        }
    }
    .padding(.trailing, 20)
    .padding(.vertical, 5)
  }
}

struct ShuffledQuestionView_Previews: PreviewProvider {
    static var previews: some View {
      ShuffledQuestionView(question: .init(question: .init(left: 1, right: 1),
                                           borderWidth: 1,
                                           borderColor: .black,
                                           inputText: ""),
                           action: {})
    }
}
