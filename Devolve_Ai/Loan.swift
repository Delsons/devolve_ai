//
//  Emprestimo.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/22/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import Foundation
import CoreData


class Emprestimo : NSObject {
    
    func create(emprestimo:Emprestimo) ->  Bool {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            emprestimo = EmprestimoMO(context: appDelegate.persistentContainer.viewContext)
            emprestimo.name = nome
            emprestimo.phone = phoneNumberLabel.text
            emprestimo.titulo = tituloUITextField.text
            emprestimo.detalhe = descricaoTextField.text
            emprestimo.date = Date() as NSDate?
            emprestimo.id = 1
            
            // Core Data Exercise - Solution
            
            
            if let emprestimoImage = imageView.image {
                if let imageData = UIImagePNGRepresentation(emprestimoImage) {
                    emprestimo.imagem = NSData(data: imageData)
                }
            }
            
            print("Saving data to context ...")
            appDelegate.saveContext()
            
        }
    }
    
}
