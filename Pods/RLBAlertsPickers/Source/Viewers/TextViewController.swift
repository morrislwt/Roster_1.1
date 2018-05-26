import UIKit

extension UIAlertController {
    
    /// Add a Text Viewer
    ///
    /// - Parameters:
    ///   - text: text kind
    
    public func addTextViewer(text: TextViewerViewController.Kind) {
        let textViewer = TextViewerViewController(text: text)
        set(vc: textViewer)
    }
}

final public class TextViewerViewController: UIViewController {
    
    public enum Kind {
        
        case text(String?)
        case attributedText([AttributedTextBlock])
    }
    
    fileprivate var text: [AttributedTextBlock] = []
    
    fileprivate lazy var textView: UITextView = {
        $0.isEditable = false
        $0.isSelectable = true
        $0.backgroundColor = nil
        return $0
    }(UITextView())
    
    struct UI {
        static let height: CGFloat = UIScreen.main.bounds.height * 0.8
        static let vInset: CGFloat = 16
        static let hInset: CGFloat = 16
    }
    
    
    public init(text kind: Kind) {
        super.init(nibName: nil, bundle: nil)
        
        switch kind {
        case .text(let text):
            textView.text = text
        case .attributedText(let text):
            textView.attributedText = text.map { $0.text }.joined(separator: "\n")
        }
        textView.textContainerInset = UIEdgeInsetsMake(UI.hInset, UI.vInset, UI.hInset, UI.vInset)
        //preferredContentSize.height = self.textView.contentSize.height
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log("has deinitialized")
    }
    
    override public func loadView() {
        view = textView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredContentSize.width = UIScreen.main.bounds.width * 0.618
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.scrollToTop()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize.height = textView.contentSize.height
        
    }
}