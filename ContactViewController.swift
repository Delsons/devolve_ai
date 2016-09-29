    //
    //  ContactViewController.swift
    //  Devolve_Ai
    //
    //  Created by Delson Silveira on 9/13/16.
    //  Copyright © 2016 Kongros Interactive. All rights reserved.
    //
    
    import UIKit
    import CoreData
    
    class ContactViewController: UITableViewController, UISearchResultsUpdating {
        
        // MARK: - Coredata
        var contatos:[EmprestimoMO] = []
        var emprestimos:[EmprestimoMO] = []
        var total = [Int]()
        
        var fetchResultController: NSFetchedResultsController<EmprestimoMO>!
        
        //MARK: - SearchBar
        var searchController:UISearchController!
        var searchResults:[EmprestimoMO] = []
        
        
        //MARK: - Class:
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            navigationController?.hidesBarsOnSwipe = true
            
            
            
            
            // Fetch data from data store
            let fetchRequest: NSFetchRequest<EmprestimoMO> = EmprestimoMO.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "phone", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
                do {
                    try fetchResultController.performFetch()
                    if let fetchedObjects = fetchResultController.fetchedObjects {
                        emprestimos = fetchedObjects
                        
                        var contador:Int = 0
                        var posicao:Int = 0
                        contatos = []
                        total = []
                        
                        if emprestimos.count >= 0 {
                            contatos.append(emprestimos[0])
                            print("Posicao:0")
                            print("Contatos.append:\(emprestimos[0].name)")
                            contador = 1
                        }
                        
                        for contato in emprestimos {
                            
                            
                            print("contato: \(contato.phone)")
                            print("emprestimo \(emprestimos[posicao].phone)")
                            print("posicao: \(posicao)")
                            
                            
                            if (posicao + 1) < emprestimos.count {
                                if contato.phone == emprestimos[posicao+1].phone {
                                    contador = contador + 1
                                    posicao = posicao + 1
                                } else {
                                    total.append(contador)
                                    contatos.append(emprestimos[posicao+1])
                                    print("Posicao:\(posicao)")
                                    print("Contatos.append:\(emprestimos[posicao+1].name)")

                                    contador = 1
                                    posicao = posicao + 1
                                }
                                
                            }
                            
                        }
                        total.append(contador)
                        tableView.reloadData()

                        
                    }
                } catch {
                    print(error)
                }
            }
            
            
            
            
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
                return contatos.count
            }
            
            
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ContactTableViewCell {
            let cellIdentifier = "contactCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
                indexPath) as! ContactTableViewCell
            // Configure the cell...
            //cell.textLabel?.text = objectNames[indexPath.row]
            //cell.imageView?.image = UIImage(named: "restaurant.jpg")
            
            
            // Determine if we get the restaurant from search result or the original
            
            let emprestimo = (searchController.isActive) ? searchResults[indexPath.row]
                : contatos[indexPath.row]
            
            
            
            cell.nome.text = emprestimo.name
            cell.itens.text = String(total[indexPath.row])
            cell.contactImageData.image = UIImage(data: emprestimo.contactImageData as! Data)

            cell.contactImageData.layer.cornerRadius = 50.0
            cell.contactImageData.clipsToBounds = true

            
            
            return cell
        }
        
        

        
        

        
        
        

        
        
        //#Mark Search

        
        func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text {
                filterContent(for: searchText)
                tableView.reloadData()
            }
        }
        
        
        
        func filterContent(for searchText: String) {
            searchResults = contatos.filter({ (emprestimo) -> Bool in
                if let name = emprestimo.name {
                    let isMatch = name.localizedCaseInsensitiveContains(searchText)
                    return isMatch
                }
                return false
            })
        }
        
        
        
        
        
        
        

        
        

        
}
