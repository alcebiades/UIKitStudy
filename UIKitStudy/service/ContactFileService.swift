//
//  ContactFileService.swift
//  UIKitStudy
//
//  Created by Alcebiades Santana on 08/02/21.
//

import Foundation

class ContactFileService {
    
    func saveContactList(listContactToSave: [Contact]) {
        
        var index: Int = 0
        
        for item in listContactToSave {
            item.id = index
            index += 1
        }
        
        if let directory = getPathDirectory() {
            
            print("M=saveContactList, I=Inicia o salvamento dos contatos")
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: listContactToSave, requiringSecureCoding: false)
                try data.write(to: directory)
                
                print("M=saveContactList, I=Os contatos foram salvos com sucesso")
                
            } catch {
                print("M=saveContactList, I=Erro ao tentar salvar os contatos, Error -> \(error.localizedDescription)")
            }
        }
    }
    
    func loadContacts() -> [Contact]{
        
        if let directory = getPathDirectory() {
        
            print("M=loadContacts, I=Iniciando o carregamento dos contatos")
            
            do {
                let data = try Data(contentsOf: directory)
                let listContact = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Contact]
                
                print("M=loadContacts, I=Contatos carregados com sucesso")
                
                return listContact
                
            } catch {
                print("M=loadContacts, I=Erro ao tentar carregar os contatos, Error -> \(error.localizedDescription)")
            }
        }
        return [Contact]()
    }
    
    func getPathDirectory() -> URL? {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = directory.appendingPathComponent("uikit_study_contacts")
            print("M=getPathDirectory, I=Obtendo o caminho do arquivo de contatos, path -> \(path)")
            return path
        }
        return nil
    }
}
