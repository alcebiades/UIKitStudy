//
//  Contato.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 31/01/21.
//

import Foundation

@objcMembers class Contact: NSObject, NSCoding {
    
    // MARK: - Atributos
    var id: Int = -1
    let name: String
    let address: String
    let phone: String
    
    // MARK: - Init
    init(name: String, address: String, phone: String) {
        self.name = name
        self.address = address
        self.phone = phone
    }
        
    // MARK: - Metodos
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(address, forKey: "address")
        coder.encode(phone, forKey: "phone")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeInteger(forKey: "id")
        name = coder.decodeObject(forKey: "name") as! String
        address = coder.decodeObject(forKey: "address") as! String
        phone = coder.decodeObject(forKey: "phone") as! String
    }
}

