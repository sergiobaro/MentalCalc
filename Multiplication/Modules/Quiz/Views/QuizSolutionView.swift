//
//  QuizSolutionView.swift
//  Multiplication
//
//  Created by Sergio Baro on 23/5/21.
//

import SwiftUI

struct QuizSolutionView: View {
  @Binding var text: String
  var onTap: () -> Void

  var body: some View {
    HStack {
      Text(text)
        .onTapGesture {
          onTap()
        }
    }
  }
}

struct QuizSolutionView_Previews: PreviewProvider {
  static var previews: some View {
    QuizSolutionView(text: .constant("Show solution"), onTap: {})
  }
}
