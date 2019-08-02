//// Created for CoreDataTest and Roundwall Software in 2019
// Using Swift 5.0
// Running on macOS 10.15

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: Dummy.defaultFetchRequest())
    var fetchedResults: FetchedResults

    var body: some View {
        VStack {
            Button("More!") {
                let dummy = Dummy(context: self.managedObjectContext)
                dummy.id = UUID()
                dummy.value = UUID().uuidString

                try! self.managedObjectContext.save()
            }
            List(fetchedResults) { item in
                Row(item: item)
            }
        }
    }
}

struct Row: View {
    let item: Dummy

    var body: some View {
        Text.init(verbatim: item.value ?? "missing")
    }
}

extension Dummy: Identifiable {
    static func defaultFetchRequest() -> NSFetchRequest<Dummy> {
        let request = NSFetchRequest<Dummy>(entityName: "Dummy")
        request.sortDescriptors = [ NSSortDescriptor(key: "value", ascending: true) ]
        return request
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
