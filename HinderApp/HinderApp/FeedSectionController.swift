/*
 FeedSectionController, will controll our views that use a feed,
 like events, groups, etc
 */

import UIKit
import IGListKit


class FeedSectionController: ListSectionController {
    
    var event: Event!
    var delegate: EventClickedDelegate
    
    init(event: Event, delegate: EventClickedDelegate) {
        self.event = event
        self.delegate = delegate
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }

    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        if self.section == 0 {
            return CGSize(width: context.containerSize.width, height: FeedCellHeight+34)
        }
        else {
        return CGSize(width: context.containerSize.width, height: FeedCellHeight)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        // TODO: if first section, add "My Events" header
        let cellClass: AnyClass = self.section == 0 ? FeedEventCellWithHeader.self : FeedEventCell.self
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        
        if let cell = cell as? FeedEventCell {
            cell.label.text =  event.name
            cell.setEvent(event: event)
        } else if let cell = cell as? FeedEventCellWithHeader {
         cell.label.text = event.name
            cell.setEvent(event: event)
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
       // message = object as? Message
    }
    
    override func didSelectItem(at index: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "EventPageViewController") as! EventPageViewController
        vc.setEvent(event: event)
        delegate.changeToVC(vc: vc)
    }
}

