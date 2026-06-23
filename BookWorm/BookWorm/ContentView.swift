//
//  ContentView.swift
//  BookWorm
//
//  Created by Tarun on 23/06/26.
//

import SwiftUI
import SwiftData

struct PushButtonView: View {
    
    let title: String
//    @State var isOn: Bool
    @Binding var isOn: Bool // instead of @state we using, @binding because this can hold changes in this view and the changes can be used in other views.problem here is we are toggling "isOn", but this change is not appearning in ContenView so we use @Binding.
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white:0.6), Color(white: 0.4)]
    
    var body: some View{
        Button(title){
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors: offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    
    //Appstorage related
    @AppStorage("notes") private var notes = "" // does not store any secure information.
    
    //SwiftData varaibles
//    @Environment(\.modelContext) var modelContext
//    @Query var students: [Student]
    
    //MainApp
    @Environment(\.modelContext) var modelContext
//    @Query var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book] //sorting books
//    @Query(sort: \Book.rating, order: .reverse) var books: [Book] //sorting books
    
    @State private var showingAddScreen = false
    
    var body: some View {
//        Toggle("Remember me", isOn: $rememberMe)
//        VStack{
//            PushButtonView(title: "Remember me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
        
        //MARK: AppStorage
//        NavigationStack{
////            TextEditor(text: $notes)
//            TextField("Enter your text:", text: $notes, axis: .vertical)
//                .textFieldStyle(.roundedBorder)
//                .navigationTitle("Notes")
//                .padding()
//        }
        
        //MARK: SwiftData usage
//        NavigationStack{
//            List(students) { student in
//                Text(student.name)
//            }
//            .navigationTitle("Class Room")
//            .toolbar {
//                Button("Add"){
//                    let firstNames = ["Tarun", "Varun", "Pavan", "Kumar", "Kasi"]
//                    let lastNames = ["Uggina","Dubasi","Marisa","Karnam"]
//                    
//                    let chosenFirstname = firstNames.randomElement()!
//                    let chosenLastname = lastNames.randomElement()!
//                    
//                    let student = Student(id: UUID(), name: "\(chosenFirstname) \(chosenLastname)")
//                    modelContext.insert(student) // asking to store the student object in storage.
//                }
//            }
//        }
        
        //MARK: Actual project starts now
        NavigationStack{
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Book Worm")
            .navigationDestination(for: Book.self){ book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
