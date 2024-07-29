// Copyright © 2022 MMCore. All rights reserved.

import UIKit

extension UITableView {
    final func register<T: UITableViewCell>(classCellType: T.Type) {
        let cellID = String(describing: classCellType)
        self.register(classCellType, forCellReuseIdentifier: cellID)
    }
    
    final func register<T: UITableViewCell>(nibCellType: T.Type) {
        let cellID = String(describing: nibCellType)
        let nib = UINib.init(nibName: cellID, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellID)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let cellID = String(describing: cellType)
        let bareCell = self.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellID) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    
}
