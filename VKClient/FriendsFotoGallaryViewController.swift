//
//  FriendsFotoGallaryViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 15.07.2021.
//

import UIKit

class FriendsFotoGallaryViewController: UIViewController {
    
    
    @IBOutlet weak var galleryView: UIView!
    var fotoGalleryArray = [Foto]()
    var startIndex = 0
    var interactiveAnimator: UIViewPropertyAnimator!
    
    var mainImage = UIImageView()
    var secondImage = UIImageView()
    
    var isLeftSwipe = false
    var isRightSwipe = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        galleryView.addGestureRecognizer(recognizer)
        
        
        
        
        mainImage.frame = galleryView.bounds
        mainImage.image = fotoGalleryArray[startIndex].foto
        mainImage.contentMode = .scaleAspectFit
        secondImage.frame = galleryView.bounds
        secondImage.contentMode = .scaleAspectFit
        galleryView.addSubview(mainImage)
        galleryView.addSubview(secondImage)
        galleryView.bringSubviewToFront(mainImage)
        
        
    }
    
    
    @objc func onPan(_ recognaizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning {
            return
        }
        
    
        
        switch recognaizer.state {
            case .began:
                interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                             curve: .linear,
                                                             animations: { [weak self] in
                                                                self?.mainImage.transform = .identity
                                                             })
                interactiveAnimator?.startAnimation()
                interactiveAnimator.pauseAnimation()
                
            case .changed:
                var translation = recognaizer.translation(in: self.view)
                print (translation)
                
                if translation.x < 0 {
                    if startIndex < fotoGalleryArray.count - 1 {
                        interactiveAnimator.stopAnimation(true)
                        startIndex += 1
                        secondImage.image = fotoGalleryArray[startIndex].foto
                        secondImage.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                        interactiveAnimator.addAnimations { [weak self] in
                            self?.mainImage.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                            self?.secondImage.transform = .identity
                        }
                        interactiveAnimator.addCompletion({ [weak self] _ in
                            self?.mainImage.image = self?.secondImage.image
                            self?.mainImage.transform = .identity
                            self?.galleryView.bringSubviewToFront(self!.mainImage)

                        })
                    interactiveAnimator.startAnimation()
                    } else {
                        if startIndex == fotoGalleryArray.count - 1 {
                            interactiveAnimator.stopAnimation(true)
                            startIndex = 0
                            secondImage.image = fotoGalleryArray[startIndex].foto
                            secondImage.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                            interactiveAnimator.addAnimations { [weak self] in
                                self?.mainImage.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                                self?.secondImage.transform = .identity
                            }
                            interactiveAnimator.addCompletion({ [weak self] _ in
                                self?.mainImage.image = self?.secondImage.image
                                self?.mainImage.transform = .identity
                                self?.galleryView.bringSubviewToFront(self!.mainImage)

                            })
                        interactiveAnimator.startAnimation()
                            
                        }
                    }
                    
                }
                if translation.x > 0 {
                    if startIndex < fotoGalleryArray.count - 1 {
                        interactiveAnimator.stopAnimation(true)
                        startIndex += 1
                        secondImage.image = fotoGalleryArray[startIndex].foto
                        secondImage.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                        interactiveAnimator.addAnimations { [weak self] in
                            self?.mainImage.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                            self?.secondImage.transform = .identity
                    }
                        interactiveAnimator.addCompletion({ [weak self] _ in
                            self?.mainImage.image = self?.secondImage.image
                            self?.mainImage.transform = .identity
                            self?.galleryView.bringSubviewToFront(self!.mainImage)

                        })
                    interactiveAnimator.startAnimation()
                    } else {
                        if startIndex == fotoGalleryArray.count - 1 {
                            interactiveAnimator.stopAnimation(true)
                            startIndex = 0
                            secondImage.image = fotoGalleryArray[startIndex].foto
                            secondImage.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                            interactiveAnimator.addAnimations { [weak self] in
                                self?.mainImage.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                                self?.secondImage.transform = .identity
                            }
                            interactiveAnimator.addCompletion({ [weak self] _ in
                                self?.mainImage.image = self?.secondImage.image
                                self?.mainImage.transform = .identity
                                self?.galleryView.bringSubviewToFront(self!.mainImage)

                            })
                        }
                        interactiveAnimator.startAnimation()                    }
                    
                }
                
                
                      

            default:
                return
        


        }
        

    }

}
