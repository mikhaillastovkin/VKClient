//
//  FriendsCollectionViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 22.06.2021.
//

import UIKit

class FriendsCollectionViewController: UIViewController {

    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    var fotoArray = [Items]()
    var userID = String()
    var indexS = 0

    let nwl = NetworkLayer()
    
    let reuseIdentifierXibCollectionViewCell = "reuseIdentifierXibCollectionViewCell"
    let segueFromCollectionToGallaryIdentofier = "SegueFromCollectionToGallary"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.friendsCollectionView.reloadData()
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(pressBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    @objc func pressBackButton() {        
        performSegue(withIdentifier: "unwindToFriends", sender: fotoArray)
    }

    
    override func viewDidLoad() {
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib(nibName: "XibCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierXibCollectionViewCell)

        loadPhoto()

        }

    func loadPhoto() {
        nwl.getFoto(for: userID) { [weak self] photos in

            guard let self = self else { return }

            for photo in photos {
                photo.sizes.map { $0.width == 75 }
                }

            self.fotoArray = photos
            self.friendsCollectionView.reloadData()
            }



        }
    }


extension FriendsCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierXibCollectionViewCell, for: indexPath) as? XibCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(image: fotoArray[indexPath.row], indexOfPicture: indexPath.item)
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
