//
//  AddViewController.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/14/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class AddViewController: UIViewController, CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var imagePicker: UIImagePickerController!
    var imagesDirectoryPath:String!
    
    @IBOutlet weak var tituloUITextField: UITextField!
    @IBOutlet weak var descricaoTextField: UITextField!
    
    
    
    var contactImageData:NSData!
    
    var emprestimo:EmprestimoMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customizando navbar
        self.navigationItem.title = "Adicionar"
        // Remove the title of the back button

        let barButton = UIBarButtonItem()
        barButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent;
        
        
        

        //Arredondando o Botao de Escolha do contato.
        //button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.01
        //button.layer.borderColor = UIColor.blue.cgColor
        // Do any additional setup after loading the view.
        
        
        //Tornando a imagem clicavel
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddViewController.imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        // Tratando o teclado
        tituloUITextField.delegate = self
        descricaoTextField.delegate = self

        //Escondendo o teclado
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        

        //Identificando o path para salvar as imagens
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        imagesDirectoryPath = documentDirectorPath + "/ImagePicker"
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        
    }
    
    
    //Esconde o teclado quanto Return é teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tituloUITextField.resignFirstResponder()
        self.descricaoTextField.resignFirstResponder()
        return true
    }

    
    func imageTapped()
    {
        print("imageTapped")
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.sourceType = .camera
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
        } else {
            self.imagePicker.sourceType = .photoLibrary
        }
        
        
        //imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
     func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = chosenImage //4
        //dismiss(animated:true, completion: nil) //5

        dismiss(animated: true) { () -> Void in
            //self.refreshTable()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //#MARK - Obtendo o contato

    @IBAction func pickContact(_ sender: AnyObject) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contact: CNContact) {
        
        //contacts.forEach { contact in
        //    for number in contact.phoneNumbers {
        
        
         contactImageData = contact.imageData as NSData!
        

        let phoneNumber = contact.phoneNumbers[0].value.stringValue
        //let email = contact.emailAddresses[0].value
        let name = contact.givenName
        
        let familyName = contact.familyName
        
        
        print("name is = \(name)")
        print("familyName is = \(familyName)")
        print("number is = \(phoneNumber)")
        //print("email is = \(email)")
        
        contactLabel.text = "Emprestar para " + name + " " + familyName
        phoneNumberLabel.text = phoneNumber
        
        contactPickerDidCancel(picker)
        
        //    }
        //}
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController){
        print("Cancel Contact Picker")
    }
    
    
    //MARK - Gravando o emprestimo

    @IBAction func emprestar(_ sender: AnyObject) {
        
        var nome:String = (contactLabel.text?.replacingOccurrences(of: "Emprestar para:", with: ""))!
        
        nome = (nome.replacingOccurrences(of: "Emprestar para ", with: ""))
        
        if (imagePicker == nil) {
            showMessage(title: "Aviso", texto: "Por favor, tire uma foto do objeto que está sendo emprestando")
        } else if ( tituloUITextField.text == nil) || (tituloUITextField.text == "") {
            showMessage(title: "Aviso", texto: "Por favor, informe o objeto que está sendo emprestado")
        } else   if  ( descricaoTextField.text == nil) || (descricaoTextField.text == "") {
            showMessage(title: "Aviso", texto: "Por favor, descreva o objeto que está sendo emprestado")
        } else if (nome == "") {
            showMessage(title: "Aviso", texto: "Por favor, selecione o nome da pessoa que pediu o objeto emprestado")
        } else {
        
            
                /*
                // Save image to Document directory
                var imagePath = Date().description
                imagePath = imagePath.replacingOccurrences(of: " ", with: "")
                imagePath = imagesDirectoryPath + "/\(imagePath).png"
                let data = UIImagePNGRepresentation(imageView.image!)
                var success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
                print(success)
                */

            
            
            let imageData: NSData = UIImagePNGRepresentation(UIImage(named:"logo_login_iphone")!)! as NSData
            
            
            if contactImageData == nil {
                contactImageData = imageData
            }
            
            let loan = Loan(nome: nome, phoneNumber: phoneNumberLabel.text!, titulo: tituloUITextField.text!, descricao: descricaoTextField.text!, imageData: NSData(data: UIImagePNGRepresentation(imageView.image!)!), date: Date(), contactImageData:contactImageData)
            
                let result:Bool = loan.create(loan: loan)
                if result {
                    showMessage(title: "Sucesso", texto: "Emprestimo registrado com sucesso")
                    
                    loan.fetch(loan:loan)

                    
                } else {

                    showMessage(title: "Erro", texto: "Ocorreu algo inesperado, por favor tente novamente!")
                }
            
            /*
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
                        
            */
            
        }
        
        
    }
    
    func showMessage(title:String, texto:String) {
        let alertController = UIAlertController(title: title,
                                                message: texto, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:
            UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
