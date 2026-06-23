//
//  AddBookView.swift
//  BookWorm
//
//  Created by Tarun on 23/06/26.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["fantasy", "Horror", "Romance", "Mystery", "Kids", "Poetry", "Thriller"]
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    TextField("Write a review", text: $review)
                    
//                    Picker("Rating", selection: $rating){
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
                    RatingView(rating: $rating)
                }
                
                Section{
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
