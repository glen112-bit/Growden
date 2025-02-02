//
//  SetingsRowView.swift
//  Growden
//
//  Created by Glen on 29-01-25.
//

import SwiftUI

struct SetingsRowView: View {
  let imageName: String
  let title: String
  let tintColor: Color
  
    var body: some View {
      HStack{
        Image(systemName: imageName)
          .imageScale(.small)
          .font(.title)
          .foregroundColor(tintColor)
        
        Text(title)
          .font(.subheadline)
          .foregroundColor(.black)
        }
    }
}

#Preview {
  SetingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
