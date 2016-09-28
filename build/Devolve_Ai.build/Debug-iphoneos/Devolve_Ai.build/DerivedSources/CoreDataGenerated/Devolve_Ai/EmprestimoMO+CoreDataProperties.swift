//
//  EmprestimoMO+CoreDataProperties.swift
//  
//
//  Created by Delson Silveira on 9/27/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension EmprestimoMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmprestimoMO> {
        return NSFetchRequest<EmprestimoMO>(entityName: "Emprestimo");
    }

    @NSManaged public var contactImageData: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var detalhe: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagem: NSData?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var titulo: String?

}
