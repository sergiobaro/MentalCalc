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
        HStack {
          Text("Select tables:")
          Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)

        LazyVGrid(columns: columns, spacing: 10) {
          ForEach(controller.options) { option in
            SelectableButtonView(action: {
              self.controller.select(option: option)
            }) {
              Text(option.title)
            }
          }
        }
        .padding(.horizontal, 20)

        HStack {
          Spacer()

          NavigationLink(
            destination: QuizView(controller: QuizController(generator: controller.generator)),
            label: {
              Text("Quiz")
                .font(.title)
            })

          Spacer()

          NavigationLink(
            destination: ShuffledView(controller: ShuffledController(generator: controller.generator)),
            label: {
              Text("Shuffled")
                .font(.title)
            })

          Spacer()
        }
        .padding()

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
