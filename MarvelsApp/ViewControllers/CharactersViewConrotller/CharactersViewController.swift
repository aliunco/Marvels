//
//  CharactersViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharactersViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = CharactersDatasource()
    private var selectedCell: CharacterCollectionViewCell?
    private var customInteractor: CustomInteractor?
    @IBOutlet weak private var favCharacterWrapperView: UIView!
    @IBOutlet weak private var favCharacterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heros"
        
        dataSource.register(collectionView: collectionView)
        dataSource.delegate = self
        dataSource.getMoreItems()
        collectionView.collectionViewLayout = GridCollectionViewFlowLayout()
        collectionView.delegate = self
        self.navigationController?.delegate = self
        
        favCharacterWrapperView.layer.cornerRadius = 50
        favCharacterWrapperView.clipsToBounds = true
        if Character.shared == nil {
            favCharacterWrapperView.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let thumbnail = Character.shared?.thumbnail?.getUrl() {
            self.favCharacterWrapperView.isHidden = false
            self.favCharacterImageView.il.setImage(url: thumbnail, placeholer: #imageLiteral(resourceName: "placeholder"))
        }
    }
    
    @IBAction func textFieldEditingChange(_ sender: UITextField) {
        dataSource.query = sender.text
    }
    
    @IBAction func favCharacterButtonTapped(_ sender: Any) {
        guard let characterID = Character.shared?.id else { return }
        self.gotoDetail(characterID: characterID)
    }
    
    
    private func gotoDetail(characterID: Int) {
        guard let detailView = CharacterDetailViewController.loadFromNib() else { return }
        detailView.characterID = "\(characterID)"
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


//custom transition animation
//TODO: refactor this code to be more reuseable for other views
extension CharactersViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let selectedImageFrame = self.selectedCell?.imageView.frame else { return nil }
        guard let selectedImageView = self.selectedCell?.imageView else { return nil }
        
        let a = self.selectedCell?.convert(selectedImageFrame, to: collectionView)
        let selectedFrame = collectionView.convert(a!, to: collectionView.superview!)
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: selectedFrame, image: selectedImageView.image)
        default:
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: selectedFrame, image: selectedImageView.image)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
}

extension CharactersViewController: CharactersDatasourceDelegate {
    func listHasBeenUpdated(newItems: [Character]) {
        
        if collectionView.visibleCells.count <= dataSource.items.count {
            collectionView.reloadData()
            return
        }
        
        if newItems.count < 2 {
            collectionView.reloadData()
            return
        }
        
        var newIndexPathes = [IndexPath]()
        for index in 0...newItems.count - 1 {
            let newIndex = collectionView.visibleCells.count + index
            newIndexPathes.append(IndexPath(item: newIndex, section: 0))
        }
    
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: newIndexPathes)
        }, completion: nil)
        
    }
    
    func startLoading() {
        collectionView.reloadData()
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as? CharacterCollectionViewCell
        if dataSource.items.count > indexPath.row, let characterID = dataSource.items[indexPath.row].id {
            gotoDetail(characterID: characterID)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dataSource.items.count - 2  {
            dataSource.getMoreItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return dataSource.isInProgress ? CGSize(width: collectionView.frame.width, height: 50) : .zero
    }
    
}
