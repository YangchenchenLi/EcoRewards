//
//  ViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 17/10/20.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class MeViewController: UIViewController {
    
    
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }

    @objc func refresh(_ sender: AnyObject) {
        
        configureUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func configureTableView() {
        
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        //tableView.frame.size = tableView.contentSize
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    
    func configureUI() {
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        //navigationItem.title = "Settings"
    }

}


extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // define number of section in the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count

    }
    
    // define how many rows in each table section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /* when initialization with a raw value, it's optional.
           So use a guard statement to unwrap it, if it fail,
           just return a value of 0
        */
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section {
        case .Account: return AccountOptions.allCases.count
        case .Settings: return SettingsOptions.allCases.count
        }
 
    }

    
    // define the header for each table section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        
        // activate the programmatic constraint
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    // define the height for each section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    // define rendering properties in each table section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell() }
       
        switch section {
        case .Account:
            let account = AccountOptions(rawValue: indexPath.row)
            cell.textLabel?.text = account?.description
        case .Settings:
            let settings = SettingsOptions(rawValue: indexPath.row)
            cell.textLabel?.text = settings?.description
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = SettingsSection(rawValue: indexPath.section)
        let account = AccountOptions(rawValue: indexPath.row)
        let setting = SettingsOptions(rawValue: indexPath.row)
        
        switch section {
        case .Account:
            switch account?.description {
            case "My Journey":
                performSegue(withIdentifier: "myjourney", sender: self)
            case "My Ranking":
                performSegue(withIdentifier: "myranking", sender: self)
            case "My Earning History":
                performSegue(withIdentifier: "myearninghistory", sender: self)
            default:
                print("None")
            }
        case .Settings:
            switch setting?.description {
            //case "Settings":
            //    performSegue(withIdentifier: "settings", sender: self)
            case "About":
                performSegue(withIdentifier: "about", sender: self)
            case "Sign Out":
                performSegue(withIdentifier: "signout", sender: self)
            default:
                print("None")
        }
        case .none:
            print("None")
        }

        
        //performSegue(withIdentifier: "logout", sender: self)
        
        
        //let vc = storyboard?.instantiateViewController(identifier: "logout") as! LogOutViewController
        //present(vc, animated: true)
    }
    


}
