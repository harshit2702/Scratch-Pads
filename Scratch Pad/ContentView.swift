//
//  ContentView.swift
//  Scratch Pad
//
//  Created by Harshit Agarwal on 28/12/23.
//

import SwiftUI
import SwiftData
import PencilKit

//@Model
//class Pad{
//    var id = UUID()
//    var name: String
//    var drawingData: Data?
//    var date: Date
//    
//    init(id: UUID = UUID(), name: String = "", drawingData: Data? = nil, date: Date = Date.now) {
//        self.id = id
//        self.name = name
//        self.drawingData = drawingData
//        self.date = date
//    }
//}
//@Environment(\.modelContext) var modelContext
//@Query var pads: [Pad]
//@State private var updatedPads: [Pad] = []
//@State private var isAddingPad = false // To control sheet presentation
@Model
class Draw{
    var drawingData: Data
    
    init(drawingData: Data) {
        self.drawingData = drawingData
    }
}
struct PadListView: View  {
    
//    @AppStorage("Hello") private var drawingData: Data?
    @State private var drawing = PKDrawing()
    @State private var textState: String = "none"
    
    @Environment(\.modelContext) var modelContext
    @Query var draw: [Draw]

    var body: some View {
        NavigationView{
            VStack{
                PKCanvasViewWrapper(drawing: $drawing, showToolPicker: .constant(true), saveAction: saveDrawing)//savedrawing should be of type (PKDrawing) -> Void
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .navigationBarTitle("Scratch Pad", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        // Save button action
                        saveDrawing(drawing: drawing)
                    }, label: {
                        Text("Save")
                    }))
                    .toolbar{
                        Button("load"){
                            load()
                        }
                    }
            }
        }
        .onAppear {
            load()
        }
    }
    
    func load(){
        // Load drawing logic
        if !draw.isEmpty {
            if let data = draw[draw.endIndex - 1].drawingData as Data? {
                do {
                    let loadedDrawing = try PKDrawing(data: data)
                    drawing = loadedDrawing
                } catch {
                    print("Error loading drawing: \(error)")
                    // Handle the error or provide a fallback solution
                }
            }
        } else {
            drawing = PKDrawing()
        }
    }
    
    func saveDrawing(drawing: PKDrawing) {
        // Save drawing logic
        if let data =  drawing.dataRepresentation() as Data? {
//            drawingData = data
            for i in draw.indices {
                modelContext.delete(draw[i])
            }
            modelContext.insert(Draw(drawingData: data))
        }
    }
}


//
//struct AddPadView: View {
//    @Environment(\.modelContext) var modelContext
//    @Binding var isAddingPad: Bool
//    @Binding var updatedPads: [Pad]
//    @State private var newPadName = ""
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("New Pad")) {
//                    TextField("Enter pad name", text: $newPadName)
//                }
//            }
//            .navigationBarTitle("Add Pad")
//            .navigationBarItems(trailing: Button("Save") {
//                addNewPad()
//            })
//        }
//    }
//    
//    func addNewPad() {
//        let newPad = Pad(name: newPadName)
//        updatedPads.append(newPad)
//        modelContext.insert(newPad) // Insert the new pad using modelContext
//        
//        isAddingPad = false
//    }
//}
//
//struct CanvasDetailView: View {
//    let padIndex: Int
//    let pads: [Pad]
//    @Binding var updatedPads: [Pad]
//    @State private var drawing = PKDrawing()
//    @Environment(\.modelContext) var modelContext
//    
//    var body: some View {
//        VStack {
//            // Wrap PKCanvasView using UIViewRepresentable
//            PKCanvasViewWrapper(drawing: $drawing, showToolPicker: .constant(true), saveAction: savePadData)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            // Any other SwiftUI views or controls can be added below the canvas
//        }
//        .navigationTitle(pads[padIndex].name)
//        .onAppear {
//            loadDrawing()
//        }
//        .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)) { _ in
//            loadDrawing()
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    save()
//                }
//            }
//        }
//    }
//    
//    func loadDrawing() {
//        guard padIndex >= 0 && padIndex < updatedPads.count else {
//            return // Index is out of range, handle accordingly
//        }
//        
//        if let drawingData = updatedPads[padIndex].drawingData {
//            let drawing = try! PKDrawing(data: drawingData)
//            self.drawing = drawing
//        } else {
//            let newDrawing = PKDrawing()
//            self.drawing = newDrawing
//        }
//    }
//    
//    func savePadData(newDrawing: PKDrawing) {
//        let updatedPad = Pad(name: pads[padIndex].name, drawingData: newDrawing.dataRepresentation(), date: pads[padIndex].date)
//        updatedPads[padIndex] = updatedPad
//        print("Pad saved")
//    }
//    
//    func save() {
//        if let existingPad = updatedPads.first(where: { $0.id == pads[padIndex].id }) {
//            modelContext.delete(existingPad) // Delete existing data
//        }
//        
//        modelContext.insert(updatedPads[padIndex]) // Insert new data
//        print("Pad saved via model")
//    }
//}
//
#Preview {
    PadListView()
}
