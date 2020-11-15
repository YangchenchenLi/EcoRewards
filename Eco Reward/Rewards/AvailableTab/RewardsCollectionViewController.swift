//
//  RewardsCollectionViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 22/10/20.
//

import UIKit



class RewardsCollectionViewController: UICollectionViewController {
    
    //MARK: Vars
    var itemArray: [Item] = []
    var documentId: [String] = []
    
    
    private let sectionInsects = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    
    // Only allow 2 item cells displayed on the screen
    private let itemsPerRow: CGFloat = 2
    
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let action = #selector(RewardsCollectionViewController.refreshControlDidStart(sender:event:))
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: action, for: .valueChanged)
        
        loadActivated()
        loadItems()
        
        
        configureRefreshControl()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.collectionView.beginRefreshing()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collectionView.endRefreshing()
        }
    }
    


    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RewardsCollectionViewCell
        
        cell.generateCell(itemArray[indexPath.row])
        
        return cell
    }
    
    
    //MARK: - CollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)

        showItemView(itemArray[indexPath.row])
    }
    
    
    //MARK: - Navigation to item cell view
    
    private func showItemView(_ item: Item) {
        
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
        
        itemVC.item = item
 
        self.navigationController?.pushViewController(itemVC, animated: true)
        
    }
    
    
    
    
    
    //MARK: - Download items
    private func loadItems() {
        // note: it is working correctly, but item view take one more refresh to disappear
        
        downloadItemFromFirebase { (allItems) in
            
            self.itemArray = allItems

            for id in self.documentId{
                let index = self.findIndex(id: id, itemArray: self.itemArray)
                guard index != nil else {return}
                self.itemArray.remove(at: index!)
            }
 
            self.collectionView.reloadData()

        }
        
        
    }
    
    private func loadActivated() {
        findActivatedItem { (allId) in
            self.documentId = allId
            self.collectionView.reloadData()
            
        }
    }
    
    private func findIndex(id: String, itemArray: Array<Item>) -> Int? {
        for item in itemArray {
            if item.id == id {
                //print(documentId)
                let indexOfItem = itemArray.firstIndex{$0 === item}
                return indexOfItem
            }
        }
        return nil
    }

    //MARK: - Handle the data refresh
    
    func configureRefreshControl () {
        // Add the refresh control to your UIScrollView object.
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
                                                    #selector(handleRefreshControl),
                                                 for: .valueChanged)
    }
    
    
    @objc func handleRefreshControl() {
        // Update your content…
        loadActivated()
        loadItems()
        
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    
    
    @objc func refreshControlDidStart(sender: UIRefreshControl?, event: UIEvent?) {
        print(#function)
    }
}






// MARK: - Define the layout of the item cell displayed on screen
extension RewardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    // Cell layout will be adjusted automatically according to the user screen size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsects.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let withPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: withPerItem, height: withPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsects
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsects.left
    }
    
}


// MARK: - Automatically refresh the collection view
public extension UICollectionView {
    
    func beginRefreshing() {
        // Make sure that a refresh control to be shown was actually set on the view
        // controller and the it is not already animating. Otherwise there's nothing
        // to refresh.
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        
        // Start the refresh animation
        refreshControl.beginRefreshing()
        
        // Make the refresh control send action to all targets as if a user executed
        // a pull to refresh manually
        refreshControl.sendActions(for: .valueChanged)
        
        // Apply some offset so that the refresh control can actually be seen
        let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
        setContentOffset(contentOffset, animated: true)
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
