
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

  -- Variable: _node
  -- The actual Forms.TreeNode
  _node,

  -- Variable: _index
  -- The node index
  _index=-1,

  -- Function: add
  -- Adds this node to the parent .Nodes array by calling parent.Nodes.Add(this._node)
  fn add = (
    _index = parent.Nodes.Add(_node)
  ),

  -- Function: remove
  -- Removes this node from the parent .Nodes array by calling parent.Nodes.RemoveAt(this._index)
  fn remove = (
    parent.Nodes.RemoveAt(_index)
  ),

  -- Function: processSubs
  -- Recursivly call init then add on all childrens
  fn processSubs = (
    for i=1 to subNodes.count do (
      snode = subNodes[i]
      snode.parent = this._node
      snode.init()
      snode.add()
    )
  ),

  -- Function: init
  -- Inits this treeview object, passing this WTreeNode as the .tag. Processes subs automaticaly.
  fn init = (
    _node = dotnetobject "System.Windows.Forms.TreeNode" title
    _node.tag = dotNetMXSValue this

    dotNet.setLifetimeControl _node #dotNet
    processSubs()
  )

)