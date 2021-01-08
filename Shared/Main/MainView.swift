import SwiftUI

struct MainView: View {

  @ObservedObject var controller: MainController

  var body: some View {
    NavigationView {
      List {
        ForEach(controller.options) { option in
          NavigationLink(
            destination: QuizView(controller: QuizController(generator: option.generator)),
            label: {
              Text(option.title)
            })
        }
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
