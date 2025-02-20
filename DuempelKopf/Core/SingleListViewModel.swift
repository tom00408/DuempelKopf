import SwiftUI
import SwiftData

class SingleListViewModel: ObservableObject {
    
    @Published var list: List
    
    init(list: List) {
        self.list = list
    }
    
    func deleteList(context: ModelContext, dismiss: DismissAction) {
        context.delete(list)
        do {
            try context.save()
        } catch {
            print("Fehler beim Löschen der Liste: \(error)")
        }
        dismiss()
    }
}
