import SwiftUI

struct RecordsView: View {

  @ObservedObject var controller: RecordsController

  var body: some View {
    List {
      RecordsHeaderView()
      ForEach(controller.records) { record in
        RecordCellView(record: record)
      }
    }
    .onAppear {
      controller.onAppear()
    }
    .navigationBarTitle("Quiz Records", displayMode: .inline)
  }
}

struct RecordCellView: View {

  let record: RecordViewModel

  var body: some View {
    HStack {
      Text(record.question)
      Spacer()
      Text("\(record.correct)")
        .foregroundColor(.green)
      Spacer()
      Text("\(record.errors)")
        .foregroundColor(.red)
    }
  }
}

struct RecordsHeaderView: View {

  var body: some View {
    HStack {
      Text("Question")
      Spacer()
      Text("Correct")
        .foregroundColor(.green)
      Spacer()
      Text("Errors")
        .foregroundColor(.red)
    }
  }
}

struct RecordsView_Previews: PreviewProvider {
  static var previews: some View {
    RecordsView(controller: RecordsController(storage: RandomStorage()))
  }
}
