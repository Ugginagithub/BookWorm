//
//  RatingView.swift
//  BookWorm
//
//  Created by Tarun on 23/06/26.
//

import SwiftUI


//Custom rating view modifier
struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self){ number in
                Button {
                    rating = number
                }label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image{
        if number > rating {
            offImage ?? onImage
        }else{
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(1))
}
