//
//  ActivatedCollectionViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 24/10/20.
//

import UIKit



class ActivatedCollectionViewController: UICollectionViewController {

    //MARK: Vars
    var itemArray: [Item] = []
    var documentId: [String] = []


    private let sectionInsects = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    private let itemsPerRow: CGFloat = 2


    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
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


    //MARK: - Navigation

    private func showItemView(_ item: Item) {

        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemViewA") as! RedeemedItemViewController
        
        itemVC.item = item
      
        
        self.navigationController?.pushViewController(itemVC, animated: true)


    }



    //MARK: - Download items

    private func loadItems() {

        var activatedItems: [Item] = []
        // note: it is working correctly, but item view take one more refresh to disappear

        downloadItemFromFirebase { (allItems) in
            self.itemArray = allItems

            for id in self.documentId{

                let index = self.findIndex(id: id, itemArray: self.itemArray)

                guard index != nil else {return}

                activatedItems.append(self.itemArray[index!])


            }
            self.itemArray = activatedItems

            print(self.itemArray)
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
                let indexOfItem = itemArray.firstIndex{$0 === item}
                return indexOfItem
                }
        }
    return nil
    }


}


    //MARK: - Collection View UI Adjustment
extension ActivatedCollectionViewController: UICollectionViewDelegateFlowLayout {

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


