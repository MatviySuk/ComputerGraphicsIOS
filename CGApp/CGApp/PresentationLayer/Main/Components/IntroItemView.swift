//
//  IntroItemView.swift
//  CGApp
//
//  Created by Matviy Suk on 23.09.2022.
//

import SwiftUI

struct IntroItemView: View {
    let icon: Image
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 40) {
                icon
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.accentColor)

                        
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                
                Text(description)
                    .font(.system(size: 13, weight: .regular))
            }
        }
    }
}

struct IntroItemView_Previews: PreviewProvider {
    static var previews: some View {
        IntroItemView(icon: Image(systemName: "xmark"), title: "Loem", description: "Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem v Lorem Lorem Lorem Lorem Lorem Lorem vv v vLorem Lorem LoremLorem Lorem Lorem")
    }
}
