import SwiftUI

struct MainView: View {

  @ObservedObject var controller: MainController

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  var body: some View {
    NavigationView {
      VStack {
        LazyVGrid(columns: columns, spacing: 10) {
          ForEach(controller.options) { option in
            SelectableButtonView(action: {
              self.controller.select(option: option)
            }) {
              Text(option.title)
            }
          }
        }
        .padding()

        NavigationLink(
          destination: QuizView(controller: QuizController(generator: controller.generator)),
          label: {
            Text("Start")
              .font(.title)
          })
          .disabled(controller.startDisabled)

        Spacer()
      }
      .navigationTitle("Mental Calc")
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(controller: MainController())
  }
}

struct SelectableButtonView<Label>: View where Label: View {

  private let action: () -> Void
  private let label: () -> Label

  @State var buttonStyle = SelectableButtonStyle()

  init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
    self.action = action
    self.label = label
  }

  var body: some View {
    Button(action: {
      self.buttonStyle.isSelected = !self.buttonStyle.isSelected
      self.action()
    }) {
      self.label()
    }
    .buttonStyle(buttonStyle)
  }
}

struct SelectableButtonStyle: ButtonStyle {

  var isSelected: Bool = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .foregroundColor(.black)
      .font(.title)
      .padding(.vertical, 20)
      .background(
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .fill(isSelected ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
      )
  }
}
