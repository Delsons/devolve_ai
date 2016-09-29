//
//  ConfigTableViewController.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/29/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//



import UIKit
import CoreData

class ConfigTableViewController: UITableViewController {

    
    
    //MARK: - Class:
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        
        //Customizando navbar
        self.navigationItem.title = "Configurações"
        // Remove the title of the back button
        

        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 4

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if indexPath.row == 0 {

            let cellIdentifier = "HeaderCell"
            let headerCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
                indexPath) as! HeaderTableViewCell

            headerCell.imagem.image = UIImage(named: "logo_login_iphone")
            return headerCell

            
        } else {
        
            let cellIdentifier = "configCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
                indexPath) as! ConfigTableViewCell
            // Configure the cell...
            //cell.textLabel?.text = objectNames[indexPath.row]
            //cell.imageView?.image = UIImage(named: "restaurant.jpg")
            
            
            if indexPath.row == 1 {
                cell.imgOpcao.image = UIImage(named: "icon_como_funciona_iphone")
                cell.opcao.text = "Como funciona"
                
            } else {
                
                if indexPath.row == 2 {
                    cell.imgOpcao.image = UIImage(named: "icon_termos_iphone")
                    cell.opcao.text = "Termos de uso"
                    
                }  else {
                    
                    if indexPath.row == 3 {
                        cell.imgOpcao.image = UIImage(named: "icon_politicas_iphone")
                        cell.opcao.text = "Políticas de privacidade"
                        
                    }
                }
            }
            
            return cell
        }
        
        
    }
    
    
    
    
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let destination = UIViewController() // Your destination
        //navigationController?.pushViewController(destination, animated: true)
        
        
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Como")
            navigationController?.pushViewController(destination, animated: true)
        } else {
            if indexPath.row == 2 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "Termo")
                navigationController?.pushViewController(destination, animated: true)
            } else {
                if indexPath.row == 3 {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "Politica")
                    navigationController?.pushViewController(destination, animated: true)
                }
            }
            
        }
        
        
        
     }
    

    
    

    
    
    
    
    
}
