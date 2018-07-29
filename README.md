# WTreeNode
  A very simple yet powerful *object oriented* Maxscript wrapper to "System.Windows.Forms.TreeNode"(s).
  
```maxscript
-- Define a simple rollout
try(DestroyDialog SimpleRollout)catch()
rollout SimpleRollout "SimpleRollout" height:200 width:350 (

  -- Define a TreeView named tv as the only ui element of this rollout
  dotnetcontrol tv "System.Windows.Forms.TreeView" height:200

  -- Add a tree struct on rollout open 
  on SimpleRollout open do (
      local t1 = WTreeNode title:"1st node" parent:tv subnodes:#(
          (WTreeNode title:"Im a subnode" subNodes:#()),
          (WTreeNode title:"Im another!" subNodes:#(
          	 (WTreeNode title:"Im a subsub" subNodes:#())
          ))
        )
      t1.init() -- This inits the .net treeview(s), including all its children recursively
      t1.add()  -- This adds every node recursively to its parent .Nodes array
  )
)
createdialog SimpleRollout
```

Check example.ms