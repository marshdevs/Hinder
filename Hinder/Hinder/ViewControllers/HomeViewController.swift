import UIKit
import IGListKit

class FeedViewController: UIViewController {
  
  let collectionView: IGListCollectionView = {
    let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    view.backgroundColor = UIColor.black
    return view
  }()
  lazy var adapter: IGListAdapter = {
    return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
  }()


  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    adapter.collectionView = collectionView
    adapter.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - IGListAdapterDataSource
extension FeedViewController: IGListAdapterDataSource {
  
  func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
    //objects for ListAdapter
  }
  
  func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
  // sectionControllerForObject
  }
  func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
}
