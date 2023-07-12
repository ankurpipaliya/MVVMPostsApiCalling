
import Foundation
import UIKit


extension UICollectionView {
    func safeScroll(indexPath:IndexPath,position:UICollectionView.ScrollPosition,animated:Bool) {
        
        let section = self.numberOfSections - 1
        let row = self.numberOfItems(inSection: section) - 1
        guard section >= 0,row >= 0 else {
            return
        }
        guard indexPath.section <= section,indexPath.row < self.numberOfItems(inSection: indexPath.section) else {
            return
        }
        self.scrollToItem(at: indexPath, at: position, animated: true)
    }
    
    
    func scrollToBottom(animated:Bool = true) {
        let section = self.numberOfSections - 1
        let row = self.numberOfItems(inSection: section) - 1
        self.safeScroll(indexPath: IndexPath(row: row, section: section), position: .bottom, animated: animated)
    }
    
    func scrollToTop(animated:Bool = true) {
        self.safeScroll(indexPath: IndexPath(row: 0, section: 0), position: .top, animated: animated)
    }
}
