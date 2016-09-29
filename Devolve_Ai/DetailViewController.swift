//
//  DetailViewController.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/14/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var contador:Int = 0

    var emprestimo:Loan = Loan()
    
    @IBOutlet weak var itens: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var descricao: UITextView!
    
    @IBOutlet weak var qtd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true

        definesPresentationContext = true
        self.navigationItem.title = "Emprestado"
        
        nome.text = emprestimo.nome
        imagem.image = UIImage(data: emprestimo.imageData as! Data)
        titulo.text = emprestimo.titulo
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        data.text = "Data do empréstimo: " + dateformatter.string(from: emprestimo.date as! Date)

        descricao.text = emprestimo.descricao
        
        qtd.text = String(contador)
        
        if (contador == 1) {
            itens.text = "item emprestado"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func call(_ sender: AnyObject) {
        var editedPhoneNumber = ""
        if emprestimo.phoneNumber != "" {
            
            for i in emprestimo.phoneNumber!.characters {
                
                switch (i){
                case "0","1","2","3","4","5","6","7","8","9" : editedPhoneNumber = editedPhoneNumber + String(i)
                default : print("Removed invalid character.")
                }
            }
            
            let phone = "tel://" + editedPhoneNumber
            let url = NSURL(string: phone)
            if let url = url {
               UIApplication.shared.openURL(url as URL)
            } else {
                print("There was an error")
            }
        } 
        
    }
}
