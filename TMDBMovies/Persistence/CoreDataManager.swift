//
//  CoreDataManager.swift
//  TMDBMovies
//
//  Created by user258285 on 3/1/25.
//

import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "TMDBMovies")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Error al cargar CoreData: \(error)")
            }
        }
    }

    /// Obtener el usuario de CoreData
    func getCurrentUser() -> UserEntity? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Error obteniendo usuario: \(error)")
            return nil
        }
    }

    /// 💾 Guardar usuario en CoreData
    func saveUser(email: String, uid: String) {
        let context = persistentContainer.viewContext
        let user = UserEntity(context: context)
        user.email = email
        user.uid = uid

        do {
            try context.save()
            print("✅ Usuario guardado en CoreData")
        } catch {
            print("❌ Error guardando usuario en CoreData: \(error)")
        }
    }

    /// ❌ Eliminar usuario de CoreData (Logout)
    func deleteUser() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()

        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                context.delete(user)
            }
            try context.save()
            print("✅ Usuario eliminado de CoreData")
        } catch {
            print("❌ Error eliminando usuario: \(error)")
        }
    }
}

