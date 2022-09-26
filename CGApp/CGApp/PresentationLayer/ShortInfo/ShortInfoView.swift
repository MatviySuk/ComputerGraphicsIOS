//
//  ShortInfoView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct ShortInfoView: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var description: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(title)
                        .font(.largeTitle)
                    Text(description)
                        .font(.body)
                        .lineSpacing(8)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(role: .cancel, action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        })
                    }
                }
            }
        }
    }
}

struct ShortInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShortInfoView(
            title: "Lorem Ipsum",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris consequat felis ut ornare elementum. Cras in nibh vehicula mauris semper suscipit sed quis risus. Ut porta ullamcorper odio, pellentesque ultrices ligula mattis sed. Sed consequat finibus fermentum. Praesent ac diam quis lectus egestas dignissim. Proin vel quam vitae mi semper euismod id facilisis ligula. Nunc et tempus massa, sed vestibulum sem. Quisque laoreet in magna eu vulputate. Aliquam id est lacus. In tempus dignissim tortor. Integer sit amet ultricies tellus. Morbi vehicula quam sit amet augue gravida dignissim. Curabitur a eros risus."
        )
    }
}
