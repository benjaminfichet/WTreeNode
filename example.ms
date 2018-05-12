-- Source WTreeNode
(
	local thisdir = (getFilenamePath(getThisScriptFilename()))
	filein (thisdir + @"WTreeNode.ms")
)


-- Define a simple rollout
try(DestroyDialog SimpleRollout)catch()
rollout SimpleRollout "SimpleRollout" height:200 width:350 (

  -- Define a TreeView named tv as the only ui element of this rollout
  dotnetcontrol tv "System.Windows.Forms.TreeView" height:200

  -- Add a tree struct on rollout open 
  on SimpleRollout open do (
      local t1 = WTreeNode title:"OnOpen node" parent:tv subnodes:#(
          (WTreeNode title:"Im a subnode" subNodes:#()),
          (WTreeNode title:"Im another!" subNodes:#())
        )

      t1.init() -- recursive inits the tree nodes
      t1.add()  -- recursive appends them to the ui
  )
)

-- Create the rollout
createdialog SimpleRollout





-- Add a tree struct outside of the rollout
t2 = WTreeNode title:"Exterior node" parent:SimpleRollout.tv \
  subNodes:#(
    (WTreeNode title:"Sub exterior"), 
    (WTreeNode title:"Sub exterior 2" subNodes:#(
            (WTreeNode title:"Subsub exterior!")
        )
    )
  )

t2.init()
t2.add()
t2.setText "TestText"



-- And another one
newNode = WTreeNode title:"Exterior nodexxxx" parent:t2.subNodes[1]
newNode.init()
newNode.add()
