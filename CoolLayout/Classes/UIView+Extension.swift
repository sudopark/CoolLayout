//
//  UIView+Extension.swift
//  CoolLayout
//
//  Created by sudo.park on 19/10/2019.
//

import UIKit

// MARK: extension for < swift 5.1

extension NSCoding where Self: UIView {

    public static var autoLayout: Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    public init(autoLayout: (Self) -> Void) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        autoLayout(self)
    }
    
    public init(autoLayout: ((Self) -> Void)...) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        autoLayout.forEach {
            $0(self)
        }
    }
    
    public init(autoLayout: [((Self) -> Void)]) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        autoLayout.forEach {
            $0(self)
        }
    }
}


// MARK: - apply decorations

extension NSCoding where Self: UIView {
    
    @discardableResult
    public func apply(_ decorating: (Self) -> Void) -> Self {
        decorating(self)
        return self
    }
    
    @discardableResult
    public func apply(_ decoratings: ((Self) -> Void)...) -> Self {
        decoratings.forEach {
            $0(self)
        }
        return self
    }

    @discardableResult
    public func apply(_ decoratings: [(Self) -> Void]) -> Self {
        decoratings.forEach {
            $0(self)
        }
        return self
    }
    
    @discardableResult
    public func apply(_ decorating: (UIView) -> Void) -> Self {
        decorating(self)
        return self
    }
    
    @discardableResult
    public func apply(_ decoratings: ((UIView) -> Void)...) -> Self {
        decoratings.forEach {
            $0(self)
        }
        return self
    }

    @discardableResult
    public func apply(_ decoratings: [(UIView) -> Void]) -> Self {
        decoratings.forEach {
            $0(self)
        }
        return self
    }
}


// MARK: - extension for active constraints

extension UIView {
    
    fileprivate struct FlagHolder {
        static var flagMap: [Int: Bool] = [:]
    }
    
    var shouldActiveWhenConstraintMade: Bool {
        let key = self.hash
        return FlagHolder.flagMap[key] ?? false
    }
    
    
    public func activate(_ buildConstraint: (UIView) -> Void) {
        let key = self.hash
        FlagHolder.flagMap[key] = true
        buildConstraint(self)
        FlagHolder.flagMap[key] = false
    }
}
