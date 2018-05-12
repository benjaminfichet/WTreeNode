
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


  -- Function: setText t
  -- Sets this's tnode text.
   fn setText t = (
    this.title = t
    this.tnode.text = this.title
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


  -- Function: init
  -- Inits this treeview object, passing this WTreeNode as the .tag. Processes subs automaticaly.
  fn init = (
    tnode = dotnetobject "System.Windows.Forms.TreeNode" title
    tnode.tag = dotNetMXSValue this

    dotNet.setLifetimeControl tnode #dotNet
    processSubs()
  )

)



