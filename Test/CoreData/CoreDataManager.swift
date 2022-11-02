//
//  CoreDataManager.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import CoreData

final class CoreDataManager {
  lazy var persistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: "Test")
    persistentContainer.loadPersistentStores { _, error in
      print(error?.localizedDescription ?? "")
    }
    return persistentContainer
  }()
  
  static let shared = CoreDataManager()
  
  func incrementSeen(for title: String) {
    let request = NSFetchRequest<ScreenShown>(entityName: "ScreenShown")
    let predicate = NSPredicate(format: "inspirationTitle == %@", title)
    request.predicate = predicate
    persistentContainer.performBackgroundTask { [weak self] context in
      do {
        let seen = try context.fetch(request)
        guard let firstSeen = seen.first else {
          self?.saveShownScreen(with: title, times: 1)
          return
        }
        firstSeen.timesShown += 1
        try context.save()
      } catch {
        print("error incrementing")
        print(error)
      }
    }
  }
  
  func fetchSeen() -> [ScreenShown] {
    do {
      let fetchRequest = NSFetchRequest<ScreenShown>(entityName: "ScreenShown")
      let seen = try persistentContainer.viewContext.fetch(fetchRequest)
      return seen
    } catch {
      print(error)
      print("error fetching")
      return []
    }
  }
  
  private func saveShownScreen(with title: String, times: Int32) {
    persistentContainer.performBackgroundTask { context in
      let seen = ScreenShown(context: context)
      seen.inspirationTitle = title
      seen.timesShown = times
      
      do {
        try context.save()
      } catch {
        print("error saving")
        print(error)
      }
    }
  }
  
  private init() {}
}
