//
//  AddView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @State var type: String = "quote"
    @State var pickerData: PhotosPickerItem?
    @State var quote: String = ""
    @State var quoteAuthor: String = ""
    @State var category: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Typ")) {
                    Picker(selection: $type, label: Text("Typ")) {
                        Text("Zitat").tag("quote")
                        Text("Bild").tag("image")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if (type == "quote") {
                    Section(header: Text("Zitat")) {
                        TextEditor(text: $quote)
                        TextField("Author", text: $quoteAuthor)
                    }
                } else if (type == "image") {
                    Section(header: Text("Bild")) {
                        // TODO
                        PhotosPicker("Bild wählen", selection: $pickerData, matching: .images)
                    }
                }
                
                Section(header: Text("Kategorie")) {
                    TextField("Post Kategorie", text: $category)
                }
                
                Button(action: {
                    // TODO
                }) {
                    Text("Veröffentlichen")
                }
            }
            .navigationBarTitle("Post hinzufügen", displayMode: .inline)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
