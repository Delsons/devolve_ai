//
//  TermoViewController.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/29/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import UIKit

class TermoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Customizando navbar
        self.navigationItem.title = "Termo de Uso"
        // Remove the title of the back button
        
        let barButton = UIBarButtonItem()
        barButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent;
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

}
