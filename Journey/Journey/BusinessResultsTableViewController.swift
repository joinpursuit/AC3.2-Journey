//
//  YelpResultsTableViewController.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessResultsTableViewController: UITableViewController, UISearchBarDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate, CellSubclassDelegate {
    
    // MARK: - Properties
    
    var faveButtonPressed = 0
    
    var businessResults: [Business] = []
    var typeBusinessResults: Business!
    let searchBar = UISearchBar()
    let locationManger = CLLocationManager()
    var searchTerm: String  = "pizza"
    
    var postalCode : String = ""{
        didSet{
            print("Zip code is \(self.postalCode)")
        }
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myDefault = UserDefaults.standard
        myDefault.removeObject(forKey: "favoriteBusinesses")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.8392, green: 0, blue: 0, alpha: 1.0)
        
        //Conforms to delegate method
        self.locationManger.delegate = self
        //Gets user most accurate location
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        //Only use location services when app is in the foreground
        self.locationManger.requestWhenInUseAuthorization()
        //Starts looking for location
        self.locationManger.startUpdatingLocation()
        
        createSearchBar()
        
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh), for: UIControlEvents.valueChanged)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessResultTableViewCell.Identifier, for: indexPath) as! BusinessResultTableViewCell
        
        let business = businessResults[indexPath.row]
        cell.cuisineLabel.text = business.category
        cell.businessNameLabel.text = business.name
        cell.phoneNumberLabel.text = business.phone
        cell.hoursLabel.text = business.hours
        
        let rating = Int(business.rating)
        switch rating{
        case 1:
            cell.starRatingImage.image = #imageLiteral(resourceName: "1star")
        case 2:
            cell.starRatingImage.image = #imageLiteral(resourceName: "2stars")
        case 3:
            cell.starRatingImage.image = #imageLiteral(resourceName: "3stars")
        case 4:
            cell.starRatingImage.image = #imageLiteral(resourceName: "4stars")
        case 5:
            cell.starRatingImage.image = #imageLiteral(resourceName: "5stars")
        default:
            cell.starRatingImage.image = #imageLiteral(resourceName: "1star")
        }
        
        cell.businessAddressLabel.text = "\(business.street), \(business.city),\(business.zipcode)"
        
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - User Default
    
    func favoriteButtonTapped(cell: BusinessResultTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        
        let myDefault = UserDefaults.standard
        
        let sampleDict =
            ["Name": businessResults[indexPath.row].name,
             "Category": businessResults[indexPath.row].category,
             "Address": businessResults[indexPath.row].location,
             "Phone": businessResults[indexPath.row].phone,
             "Hours": businessResults[indexPath.row].hours]
        
        if var favoriteBusiness = myDefault.object(forKey: "favoriteBusinesses") as? [[String:Any]] {
            // if there are already things in user default, new dictionary will be added
            favoriteBusiness.append(sampleDict)
            myDefault.set(favoriteBusiness, forKey: "favoriteBusinesses")
        }
            // if there is nothing in user default
        else {
            myDefault.set([sampleDict], forKey: "favoriteBusinesses")
            alertViewWith(title: "Done!", message: "Favorites Added", preferenceStyle: .actionSheet)
        }
        print(myDefault.object(forKey: "favoriteBusinesses"))
        faveButtonPressed += 1
    }
    
    func removeFromFaves(cell: BusinessResultTableViewCell) {
        let userDefaults = UserDefaults.standard
        
        if var favorite = userDefaults.object(forKey: "favoriteBusinesses") as? [[String: String]]  {
            for (index,business) in favorite.enumerated() {
                if business["name"] == typeBusinessResults.name {
                    favorite.remove(at: index)
                    userDefaults.set(favorite, forKey: "favoriteBusinesses")
                    print(userDefaults.set(favorite, forKey: "favoriteBusinesses"))
                    faveButtonPressed = 0
                }
            }
        }
        if faveButtonPressed == 0 {
//            favoriteButtonTapped(cell: BusinessResultTableViewCell)
//            favoriteButtonTapped(cell: BusinessResultTableViewCell)
//            favoriteButton.setBackgroundImage(UIImage(named: "Pin-50"), for: UIControlState.normal)
        }
//        removeFromFaves(cell: BusinessResultTableViewCell)
//        favoriteButton.setBackgroundImage(UIImage(named: "Pin-52"), for: UIControlState.normal)
    }
    
    // MARK: - Alert View
    
    func alertViewWith(title: String, message: String, preferenceStyle: UIAlertControllerStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferenceStyle)
        let action = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            if alert.title == "Done!" {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK:- Location Delegate
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = manager.location else { return }
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            
            if error != nil {
                print("Location Error ===> \n \(error?.localizedDescription)")
            }
            
            if placemark!.count > 0 {
                let placemark = placemark![0]
                self.locationManger.stopUpdatingLocation()
                self.postalCode = placemark.postalCode!
            }
            
            DispatchQueue.main.async {
                self.getSearchResults(for: self.searchTerm, near: self.postalCode)
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Search delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = (searchBar.text?.replacingOccurrences(of: " ", with: ""))!
        
        getSearchResults(for: searchTerm, near: postalCode)
    }
    
    //MARK:- Utitilies
    //gets the search result for a specific term
    func getSearchResults(for searchterm:String, near zipCode:String){
        
        let yellowPageEndPoint = "http://pubapi.yp.com/search-api/search/devapi/search?searchloc=\(zipCode)&term=\(searchterm)&format=json&sort=distance&radius=5&listingcount=25&key=1fhn2vk8wv"
        print(yellowPageEndPoint)
        
        ApiRequestManager.manager.getData(apiUrl: yellowPageEndPoint) { (data) in
            guard let validData = data else { return }
            // dump(validData)
            
            if let validBusiness = BusinessFactory.manager.getBusinessData(from: validData){
                //dump(validBusiness)
                self.businessResults = validBusiness.sorted{$0.rating > $1.rating}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
        
    }
    
    // MARK: - Search Bar
    //Adds searchbar to navigation controller
    func createSearchBar(){
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Where do you want to start your journey?"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        //self.tableView.tableHeaderView = searchBar
    }
    
    func handleRefresh(){
        self.locationManger.startUpdatingLocation()
        getSearchResults(for: searchTerm, near: postalCode)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let instaVC = segue.destination as? ImagesViewController{
            if segue.identifier == "PopUpID"{
                if let index = tableView.indexPathForSelectedRow {
                    instaVC.buiness = businessResults[index.row]
                }
            }
        }
    }
}
