//
//  MyView.swift
//
//  Created by Pedro Peres on 06/01/2017.
//
//

import UIKit

class MyView: UIView {
    fileprivate let test: CGFloat = CGFloat() 

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for MyView.swift")
    }
    
//------------------------------------------------------------------------------------------------------------------
    // MARK: - Setup
//------------------------------------------------------------------------------------------------------------------
    
    fileprivate func setupView() {
    }

//------------------------------------------------------------------------------------------------------------------
    // MARK: - Actions
//------------------------------------------------------------------------------------------------------------------    
    
    public func updateLabels() {
    }

       
//------------------------------------------------------------------------------------------------------------------
    // MARK: - Constraints
//------------------------------------------------------------------------------------------------------------------
    
}
