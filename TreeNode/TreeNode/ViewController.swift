//
//  ViewController.swift
//  TreeNode
//
//  Created by etiantian on 2020/4/29.
//  Copyright © 2020 etiantian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let root = TreeNode(value: 1)
        let node1 = TreeNode(value: 3)
        let node2 = TreeNode(value: 5)
        
        let node3 = TreeNode(value: 7)
        let node4 = TreeNode(value: 9)
        let node5 = TreeNode(value: 11)
        let node6 = TreeNode(value: 13)
        root.left = node1
        root.right = node2
        
        node1.left = node3
        node1.right = node4
        
        node2.left = node5
        node2.right = node6
        
        TreeNode.postTraverse(root: root)
    }


}

class TreeNode: NSObject {
    
    var value: Int!
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: Int) {
        self.value = value
    }
    
    static func traverse(root: TreeNode?) -> Void {
        guard root != nil else {
            return
        }
        print("当前值:\(root?.value)")
        traverse(root: root?.left)
        traverse(root: root?.right)
    }
    
    static func midTraverse(root: TreeNode?) -> Void {
        guard root != nil else {
            return
        }
        
        midTraverse(root: root?.left)
        print("当前值:\(root?.value)")
        midTraverse(root: root?.right)
    }
    
    static func postTraverse(root: TreeNode?) -> Void {
        guard root != nil else {
            return
        }
        postTraverse(root: root?.left)
        postTraverse(root: root?.right)
        print("当前值:\(root?.value)")
    }
}

