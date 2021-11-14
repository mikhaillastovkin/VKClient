//
//  FriendsCollectionViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit
import RealmSwift

class FriendsCollectionViewController: UIViewController {

    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    var fotoArray: Results<RealmPhoto>?
    var notifationToken: NotificationToken?

    var userID = String()
    var indexS = 0

    let nwl = NetworkLayer()
    
    let reuseIdentifierXibCollectionViewCell = "reuseIdentifierXibCollectionViewCell"
    let segueFromCollectionToGallaryIdentofier = "SegueFromCollectionToGallary"
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.friendsCollectionView.reloadData()
//        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(pressBackButton))
//        self.navigationItem.setLeftBarButton(backButton, animated: false)
//    }
    
//    @objc func pressBackButton() {        
//        performSegue(withIdentifier: "unwindToFriends", sender: fotoArray)
//    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifationToken?.invalidate()
    }


    override func viewDidLoad() {
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib(nibName: "XibCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierXibCollectionViewCell)

        loadPhoto()

        }

    func loadPhoto() {
        nwl.getFoto(for: userID)
        fotoArray = try? RealmService.load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(format: "user = '\(userID)'"))
        notifationToken = fotoArray?.observe { [weak self] changes in
            switch changes {
            case .initial(let objects):
                if objects.count > 0 {
                    self?.friendsCollectionView.reloadData()
                }
            case let .update(results, deletions, insertions, modifications):
                self?.friendsCollectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
}


extension FriendsCollectionViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierXibCollectionViewCell, for: indexPath) as? XibCollectionViewCell,
              let unFotoArray = fotoArray?[indexPath.row]
        else { return UICollectionViewCell()}
        
        cell.configure(image: unFotoArray, indexOfPicture: indexPath.item)
        cell.delegate = self
        
        return cell
        
    }
}


extension FriendsCollectionViewController: XibCollectionViewCellDelegate {
    func pressLikeButton(isLikeOn: Bool, indexOfPicture: Int) {

    }

//    func pressLikeButton(isLikeOn: Bool, indexOfPicture: Int) {
//        fotoArray[indexOfPicture].isLikeOn = isLikeOn
//        if isLikeOn {
//            fotoArray[indexOfPicture].countLikes += 1
//        }
//        else {
//            fotoArray[indexOfPicture].countLikes -= 1
//        }
//    }
}


extension FriendsCollectionViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexS = indexPath.item
        print(indexS)
        performSegue(withIdentifier: segueFromCollectionToGallaryIdentofier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueFromCollectionToGallaryIdentofier,
           let dst = segue.destination as? FriendsFotoGallaryViewController {
//            dst.fotoGalleryArray = fotoArray
            dst.startIndex = indexS
        }
    }
    
}
