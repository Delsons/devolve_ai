//
//  Emprestimo.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/22/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Loan : NSObject, NSFetchedResultsControllerDelegate {
    
    var tableView: UITableView!
    var emprestimo:EmprestimoMO!
    var emprestimos:[EmprestimoMO] = []
    
    var nome:String?
    var phoneNumber:String?
    var titulo:String?
    var descricao:String?
    var imageData:NSData?
    var contactImageData:NSData?
    var date:NSDate?
    
    var fetchResultController: NSFetchedResultsController<EmprestimoMO>!
    
    init(nome: String, phoneNumber: String, titulo: String, descricao: String, imageData: NSData, date:Date, contactImageData: NSData) {
        self.nome = nome
        self.phoneNumber = phoneNumber
        self.titulo = titulo
        self.descricao = descricao
        self.imageData = imageData
        self.contactImageData = contactImageData

    }
    
    
    override init() {
        
    }
    
    
    func create(loan:Loan) ->  Bool {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            emprestimo = EmprestimoMO(context: appDelegate.persistentContainer.viewContext)
            emprestimo.name = nome
            emprestimo.phone = phoneNumber
            emprestimo.titulo = titulo
            emprestimo.detalhe = descricao
            emprestimo.date = Date() as NSDate?
            emprestimo.id = 1
            emprestimo.imagem = imageData
            emprestimo.contactImageData = contactImageData

            print("Saving data to context ...")
            appDelegate.saveContext()
            
            return true
        
        }
        
        return false
    }
    
    
    
    
    
    func fetch(loan:Loan) ->  [EmprestimoMO] {

        // Fetch data from data store
        let fetchRequest: NSFetchRequest<EmprestimoMO> = EmprestimoMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "phone", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    emprestimos = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        return emprestimos
    }
    
    
    func delete(loan:Loan, indexPath:IndexPath) ->  Bool {
        

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            let restaurantToDelete = self.fetchResultController.object(at: indexPath)
            context.delete(restaurantToDelete)
            
            appDelegate.saveContext()
            return true
        }
        
        
        
        return false
    }
    
    
    
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            emprestimos = fetchedObjects as! [EmprestimoMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    
    
    
}
