
/* Class: WTreeNode

  A simple but powerful Maxscript wrapper to "System.Windows.Forms.TreeNode"(s).
  ---code
  -- Adding a tree composed of 3 nodes to a treeview.
  t1 = WTreeNode title:"OnOpen node" parent:tv subnodes:#(
      (WTreeNode title:"Im a subnode" subNodes:#()),
      (WTreeNode title:"Im another!" subNodes:#())
    )
  t1.init() -- recursive inits the tree nodes
  t1.add()  -- recursive appends them to the ui
  ---
*/
struct 	WTreeNode (


  -- Variable: title
  -- The treenode text
  title,

  -- Variable: subNodes
  -- The treenode's subs WTreeNode(s)
  subNodes = #(),

  -- Variable: parent
  -- The treenode's parent .net node (Forms.TreeNode or Forms.TreeView)
  parent,

  -- Variable: tnode
  -- The actual Forms.TreeNode
  tnode,

  -- Variable: nindex
  -- The node index
  nindex=-1,

  -- Function: add
  -- Adds this node to the parent .Nodes array by calling parent.Nodes.Add(this.tnode)
  fn add = (
    if classof(this.parent) == WTreeNode then (nindex = parent.tnode.Nodes.Add(this.tnode)) else (nindex = parent.Nodes.Add(this.tnode))
  ),

  -- Function: remove
  -- Removes this node from the parent .Nodes array by calling parent.Nodes.RemoveAt(this.nindex)
  fn remove = (
    if classof(this.parent) == WTreeNode then (parent.tnode.Nodes.RemoveAt(nindex)) else (parent.tnode.Nodes.RemoveAt(nindex))
  ),

  -- Function: processSubs
  -- Recursivly call init then add on all childrens
  fn processSubs = (
    for i=1 to subNodes.count do (
      snode = subNodes[i]
      snode.parent = this
      snode.init()
      snode.add()
    )
  ),


  fn setText t = (
    this.title = t
    this.tnode.text = this.title
  ),


  -- Function: init
  -- Inits this treeview object, passing this WTreeNode as the .tag. Processes subs automaticaly.
  fn init = (
    tnode = dotnetobject "System.Windows.Forms.TreeNode" title
    tnode.tag = dotNetMXSValue this

    dotNet.setLifetimeControl tnode #dotNet
    processSubs()
  )

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


newNode = WTreeNode title:"Exterior node" parent:t2.subNodes[1].tnode
newNode.init()
newNode.add()