//
//  ConstraintGroup.swift
//  Cartography
//
//  Created by Robert Böhnke on 22/01/15.
//  Copyright (c) 2015 Robert Böhnke. All rights reserved.
//

import Foundation

public class ConstraintGroup {
    private var constraints: [Constraint] = []

    @availability(OSX, introduced=10.10)
    @availability(iOS, introduced=8.0)
    public var active: Bool {
        get {
            return constraints.map({ $0.layoutConstraint.active }).reduce(true) { $0 && $1 }
        }
        set {
            for constraint in constraints {
                constraint.layoutConstraint.active = newValue
            }

            for constraint in constraints {
                constraint.view?.car_updateLayout()
            }
        }
    }

    public init() {

    }

    internal func replaceConstraints(constraints: [Constraint], performLayout: Bool) {
        for constraint in self.constraints {
            constraint.uninstall()

            if performLayout {
                constraint.view?.car_updateLayout()
            }
        }

        if performLayout {
            for view in self.constraints.map({ $0.view }) {
                view?.car_updateLayout()
            }
        }

        self.constraints = constraints

        for constraint in self.constraints {
            constraint.install()
        }

        if performLayout {
            for view in self.constraints.map({ $0.view }) {
                view?.car_updateLayout()
            }
        }
    }
}
