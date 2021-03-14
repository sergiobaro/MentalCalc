 import SwiftUI

 struct FullTable: View {

  @ObservedObject var controller: FullTableController

  private let columns = [
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
  ]

  var body: some View {
    ScrollView(.horizontal) {
      LazyVGrid(columns: columns) {

        ForEach(controller.items) { item in
          Text(item.text)
            .frame(width: 50.0, height: 50.0, alignment: .center)
            .foregroundColor(item.highlight ? Color.white : Color.black)
            .background(item.highlight ? Color.gray : Color.clear)
            .border(Color.black, width: 0.5)
        }
      }
      .border(Color.black)
      .padding([.horizontal], 5)

      Spacer()
    }
  }
 }

 struct FullTable_Previews: PreviewProvider {
  static var previews: some View {
    FullTable(controller: FullTableController())
  }
 }
