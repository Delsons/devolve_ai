//
//  ListTableViewController.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/13/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    // MARK: - Coredata
    var emprestimos:[EmprestimoMO] = []
    var fetchResultController: NSFetchedResultsController<EmprestimoMO>!

    //MARK: - SearchBar
    var searchController:UISearchController!
    var searchResults:[EmprestimoMO] = []
    

    //MARK: - Class
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.hidesBarsOnSwipe = true
        let logo = UIImage(named: "logo_nav_iphone")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        
        //Search bar
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        
        if searchController.isActive {
            return searchResults.count
        } else {
            return emprestimos.count
        }
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ObjectTableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
            indexPath) as! ObjectTableViewCell
        // Configure the cell...
        //cell.textLabel?.text = objectNames[indexPath.row]
        //cell.imageView?.image = UIImage(named: "restaurant.jpg")
        
        
        // Determine if we get the restaurant from search result or the original
        
        let emprestimo = (searchController.isActive) ? searchResults[indexPath.row]
            : emprestimos[indexPath.row]
        
        
        
        //cell.imageView?.image = nil
        //cell.bgImage?.image = UIImage(data: emprestimos[indexPath.row].imagem as! Data)
        //cell.nameLabel.text = "Emprestado para " + emprestimos[indexPath.row].name!
        //cell.tituloLabel.text = emprestimos[indexPath.row].titulo
        
        
        //cell.imageView?.image = nil
        cell.bgImage?.image = UIImage(data: emprestimo.imagem as! Data)
        cell.nameLabel.text = "Emprestado para " + emprestimo.name!
        cell.tituloLabel.text = emprestimo.titulo
        
        
        let dateformatter = DateFormatter()
        
        //dateformatter.dateFormat = "dd/MM/yyyy h:mm a Z"
        dateformatter.dateFormat = "dd/MM/yyyy"
        
        cell.dataLabel.text = "Data do empréstimo: " + dateformatter.string(from: emprestimo.date as! Date)

        
        cell.descricaoLabel.text = emprestimo.detalhe
        
        
        
        //tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)

        
        
        return cell
    }
    

    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?",
                                           preferredStyle: .actionSheet)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        // Display the menu
        self.present(optionMenu, animated: true, completion: nil)
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            emprestimos.remove(at: indexPath.row)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        /*
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at " + self.emprestimos[indexPath.row].name!
            
            if let imageToShare = UIImage(data: self.emprestimos[indexPath.row].imagem as! Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        })
        */
        
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let emprestimoToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(emprestimoToDelete)
                
                appDelegate.saveContext()
            }
            
        })
        
        //shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        //return [deleteAction, shareAction]
        return [deleteAction]
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
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    
    //#Mark Search
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

    
    
    func filterContent(for searchText: String) {
        searchResults = emprestimos.filter({ (emprestimo) -> Bool in
            if let name = emprestimo.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    
    
    
    
    
    
    //#Mark Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailViewController" {
            if tableView.indexPathForSelectedRow != nil {
                let index:Int = (tableView.indexPathForSelectedRow?.row)!
                
                let destinationController = segue.destination as! DetailViewController
                searchController.isActive = false
                
                //destinationController.nome = ((searchController.isActive) ? searchResults[ index].name : emprestimos[ index].name)!
                //print(destinationController.nome)
                
                let emprestimo = (searchController.isActive) ? searchResults[index]
                    : emprestimos[index]
                
                destinationController.emprestimo.nome = emprestimo.name
                destinationController.emprestimo.imageData = emprestimo.imagem
                destinationController.emprestimo.titulo = emprestimo.titulo
                destinationController.emprestimo.date =  emprestimo.date
                destinationController.emprestimo.descricao = emprestimo.detalhe
                destinationController.emprestimo.phoneNumber = emprestimo.phone


                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                var contador:Int = 0
                
                for itens in emprestimos {
                    
                    if (itens.name == emprestimo.name) {
                        print(itens.name)
                        contador = contador + 1

                    }
                }
                
                
                
                destinationController.contador = contador
                
                
                
            }
        }
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
