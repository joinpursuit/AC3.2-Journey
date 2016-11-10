//
//  YelpResultsTableViewController.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BusinessResultsTableViewController: UITableViewController, UISearchBarDelegate {

    var businessResults: [Business] = []
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        
       // getSearchResults()
        
    }


    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return businessResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessResultTableViewCell.Identifier, for: indexPath) as! BusinessResultTableViewCell

        // Configure the cell...
        let business = businessResults[indexPath.row]
        
        cell.businessNameLabel.text = business.name
        cell.businessAddressLabel.text = "\(business.street), \(business.city),\(business.zipcode)"
        

        return cell
    }
 

    
    
    //MARK:- Search delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchResults(for: searchBar.text!)
    }
    
    
    
    //MARK:- Utitilies
    
    //gets the search result for a specific term
    func getSearchResults(for searchterm:String = "pizza"){
        
        let yellowPageEndPoint = "http://pubapi.yp.com/search-api/search/devapi/search?searchloc=91203&term=\(searchterm)&format=json&sort=distance&radius=5&listingcount=10&key=1fhn2vk8wv"
        
        ApiRequestManager.manager.getData(apiUrl: yellowPageEndPoint) { (data) in
            guard let validData = data else { return }
            // dump(validData)
            
            if let validBusiness = BusinessFactory.manager.getBusinessData(from: validData){
                //dump(validBusiness)
                self.businessResults = validBusiness
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    
    
    //Adds searchbar to navigation controller
    func createSearchBar(){
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Business..."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        //self.tableView.tableHeaderView = searchBar
        
        
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

 

}
