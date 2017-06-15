
function build_struct_info(id) {
  var s = new Object();

  s.id = id;
  s.holder = document.getElementById("struct-" + id);
  s.node = first_child_of_class(s.holder, "tree-node");
  if (s.node == null) {
    s.node = first_child_of_class(s.holder, "fs-otab");
  }
  s.is_tree = s.node.className == "tree-node";
  if (s.is_tree) {
    var ls = new Array();
    s.fs_tree_root = build_fs_tree(s.holder, ls);
    s.fs_tree_nodes = ls;
    s.fs_visible = false;
    for (var i = 0; i < ls.length; ++i) {
      var tree_node_content = ls[i].content.rows[1].cells[0];
      tree_node_content.style.display = "none";
    }
  }
  
  return s;
}

function show_struct(id) {
    // niko.
    // show the structures again.
    document.getElementById("structureViewHolder").style.visibility = "visible";
    
    // neu.
    document.getElementById("canvas").style.visibility = "visible";
    
  var s = _structs[id];
  if (s == null) {
    s = build_struct_info(id);
    _structs[id] = s;
  }

  var viewHolder = document.getElementById("structureViewHolder");
  if (_current_struct != null) {
    // put back the old view
    _current_struct.holder.appendChild(viewHolder.lastChild);
  }
  // set the new view
  viewHolder.appendChild(s.node);
  _current_struct = s;
  
  update();
}

function update() {
  if (_current_struct.is_tree) {
    _layout.layout();
    draw_tree_edges();
  }
  else {
    document._js_draw.clear();
    var node = _current_struct.node;
    var t = _layout._off_top;
    var l = _layout._off_left;
    set_position(node, t, l, 2);
    
    var w = 2 * l + node.clientWidth;
    var h = 2 * t + node.clientHeight;
    
    resize_view(w, h);
  }
}

function expand_collapse(e) {
  var targ;
  if (!e) var e = window.event;
  
  if (e.target)
    targ = e.target;
  else if (e.srcElement)
    targ = e.srcElement;
  if (targ.nodeType == 3) // defeat Safari bug
    targ = targ.parentNode;

  var feat = targ;
  var val = feat.parentNode.cells[1];
  if (val.style.display == "" || val.style.display == "block") {
    val.style.display = "none";
    feat.style.color = "gray";
  }
  else {
    val.style.display = "";
    feat.style.color = "black";
  }
  
  update();
}

function draw_tree_edges() {
  var graphics = document._js_draw;
  graphics.clear();
  graphics.setColor("darkgray");
  draw_edges(_current_struct.fs_tree_root, graphics);
  graphics.paint();
}

function draw_edges(node, graphics) {
  var x1 = Math.round(node.x + node.width() / 2);
  var y1 = Math.round(node.y + node.height());
  
  for (var child = node.firstChild; child != null; child = child.nextSibling) {
    var x2 = Math.round(child.x + child.width() / 2);
    var y2 = child.y;
    graphics.drawLine(x1, y1, x2, y2);
    draw_edges(child, graphics);
  }
}

function dump_object(o) {
  var s = "";
  for (p in o) s += p + "=" + o[p] + "<br>";
  var w = window.open("about:blank");
  w.document.write(s);
  w.document.close();
  w.show();
}

function first_child_of_class(parentNode, className) {
  //alert(parentNode + " class: " + className);
  for (var node = parentNode.firstChild; node != null; node = node.nextSibling) {
    if (node.className == className) {
      return node;
    }
  }
  return null;
}

function all_children_of_class(parentNode, className) {
  var a = new Array();
  for (var node = parentNode.firstChild; node != null; node = node.nextSibling) {
    if (node.className == className) {
      a.push(node);
    }
  }
  return a;
}

function fs_tree_to_string(u, s) {
  s += "('" + u.label + "'";
  for (var v = u.firstChild; v != null; v = v.nextSibling) {
    s = fs_tree_to_string(v, s);
  }
  s += ")";
  return s;
}

function FsTreeNode(label, content) {
  this.label = label;
  this.content = content;
  this.firstChild = null;
  this.nextSibling = null;
  
  this.prependChild = function(node) {
    node.nextSibling = this.firstChild;
    this.firstChild = node;
  }
  
  this.toString = function() {
    return fs_tree_to_string(this, "");
  }
  
  this.width = function() {
    return this.content.clientWidth;
  }
  
  this.height = function() {
    return this.content.clientHeight;
  }
  
  this.setPosition = function(x, y) {
    x = Math.round(x);
    y = Math.round(y);
    //alert("position of node '" + label + "': " + x + "," + y + "\nw/h: " + this.width() + "/" + this.height() + "\nclassName: " + this.content.className + "\n...style.display: " + this.content.style.display);
    this.x = x;
    this.y = y;
    set_position(this.content, x, y, 2);
  }
}

function do_build_fs_tree(node, fs_tree_nodes) {
  var content = first_child_of_class(node, "tree-node-table");
  var label = content.rows[0].cells[0].innerHTML;
  var u = new FsTreeNode(label, content);
  fs_tree_nodes.push(u);
  
  var subs = all_children_of_class(node, "tree-node");
  subs.reverse();
  
  for (var i = 0; i < subs.length; ++i) {
    var v = do_build_fs_tree(subs[i], fs_tree_nodes);
    u.prependChild(v);
  }
  
  return u;
}

function build_fs_tree(holder, fs_tree_nodes) {
  var root = first_child_of_class(holder, "tree-node");
  return do_build_fs_tree(root, fs_tree_nodes);
}

function resize_view(w, h) {
  var svh = document.getElementById("structureViewHolder");
  svh.style.width  = w + "px";
  svh.style.height = h + "px";
}

function set_position(element, x, y, z) {
  var style = element.style;
  style.position = "absolute";
  style["z-index"] = z;
  style.top  = y + "px";
  style.left = x + "px";
}

function TreeLayout(offset_top, offset_left, min_hdist, min_vdist) {
  this._off_top = offset_top;
  this._off_left = offset_left;
  this._min_hdist = min_hdist;
  this._min_vdist = min_vdist;
  
  this.layout = function() {
    if (!_current_struct.is_tree)
      return;
    var next_x = this._layout(_current_struct.fs_tree_root, this._off_left, this._off_top);
    var max_y = 0;
    
    for (var i = 0; i < _current_struct.fs_tree_nodes.length; ++i) {
      var node = _current_struct.fs_tree_nodes[i];
      var t = node.y + node.height();
      if (t > max_y)
        max_y = t;
    }
    
    resize_view(next_x + this._off_left, max_y + this._off_top);
    
    for (var i = 0; i < _current_struct.fs_tree_nodes.length; ++i) {
      var node = _current_struct.fs_tree_nodes[i];
      node.setPosition(node.x, node.y);
    }
  }
  
  this._layout = function(node, x, y) {
    node.y = y;
    
    if (node.firstChild == null) {
      node.x = x;
      return x + node.width();
    }
    else {
      var next_x = x;
      var next_y = y + node.height() + this._min_vdist;
      var last_child;
      for (var child = node.firstChild; child != null; child = child.nextSibling) {
        if (child != node.firstChild) next_x += this._min_hdist;
        next_x = this._layout(child, next_x, next_y);
        last_child = child;
      }
      
      var m = node.firstChild.x + node.firstChild.width() / 2
            + (last_child.x + last_child.width() / 2 - (node.firstChild.x + node.firstChild.width() / 2)) / 2;
      node.x = m - node.width() / 2;
      
      var n = node.x + node.width();
      if (n > next_x)
        next_x = n;
      //alert("node.label/node.x/x:" + node.label + "/" + node.x + "/" + x);
      if (node.x < x) {
        var offsetX = x - node.x;
        //node.x = x;
        next_x += offsetX;
        this._move(node, offsetX, 0);
      }
      
      return next_x;
    }
  }
  
  this._move = function(node, offsetX, offsetY) {
    node.x += offsetX;
    node.y += offsetY;
    
    for (var child = node.firstChild; child != null; child = child.nextSibling) {
      this._move(child, offsetX, offsetY);
    }
  }
}

function expand_collapse_tag(tag) {
  if (tag._reentr) {
    if (tag._is_expanded) {
      tag._content.innerHTML = ""; //"&nbsp;";
      tag._is_expanded = false;
    }
    else {
      //if (tag.innerHTML == "0") {
        //alert(tag._reentr.innerHTML);
      //}
      tag._content.innerHTML = tag._reentr.innerHTML;
      tag._is_expanded = true;
    }
    update();
  }
  else {
    var reentr_id = "reentr-" + _current_struct.id + "-" + tag.innerHTML;
    // niko.
    reentr_id = reentr_id.replace(/\s/g, "");
    
    tag._reentr = document.getElementById(reentr_id);
    
    if (!tag._reentr) {
      alert("Failed to expand tag because reentrancy with id '" + reentr_id + "' does not exist");
    }
    else {
      //tag._content = tag.parentNode.parentNode.parentNode.parentNode.parentNode.cells[1];
      tag._content = tag.parentNode.parentNode.cells[1];
      tag._is_expanded = false;
      expand_collapse_tag(tag);
    }
  }
}

function expand_collapse_fs(type) {
  if (type._fs) {
    if (type._fs.style.display == "none")
      type._fs.style.display = "";
    else
      type._fs.style.display = "none";
    update();
  }
  else {
    type._fs = type.parentNode.parentNode.parentNode.rows[1].cells[0];
    expand_collapse_fs(type);
  }
}

function expand_collapse_node(node_label) {
  expand_collapse_fs(node_label);
}

function expand_collapse_feat(feat) {
  var val = feat.parentNode.cells[1];
  if (val.style.display == "none") {
    val.style.display = "";
    feat.style.color = "black";
  }
  else {
    val.style.display = "none";
    feat.style.color = "gray";
  }
  
  update();
}

function body_ondblclick() {
  if (!_current_struct.is_tree)
    return;
  var display_value = "";
  if (_current_struct.fs_visible) {
    display_value = "none";
  }
  _current_struct.fs_visible = !_current_struct.fs_visible;
  var ts = _current_struct.fs_tree_nodes;
  for (var i = 0; i < ts.length; ++i) {
    ts[i].content.rows[1].cells[0].style.display = display_value;
    //dump_object(ts[i].content);
    //break;
  }
  update();
}

function fix_div_roots() {
  var d1 = document.getElementById("structureViewHolder");
  if (d1.firstChild) {
    var s1 = document.getElementById("struct-1");
    if (s1.firstChild == null) {
      s1.appendChild(d1.firstChild);
    }
  }
  var d2 = document.getElementById("canvas");
  d2.innerHTML = "";
}


function drawTo3rdPanel() {
  document.write("Hello from inside myjava.js");
  window.parent.frames[3].document.body.innerHTML = "<h2>Parse Chart</h2>";
}


function showhide_parsechart() {
      
    
    
    var e = document.getElementById("parsechartdiv");
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
      
      
      
      
}

function init_view() {
  fix_div_roots();
  document._js_draw = new jsGraphics("canvas");
  tb_init();
  document.getElementById("structureViewHolder").style.visibility = "visible";
  
  // Niko.
  // If parse chart:
  // Set this to invisilbe:
  var parseChartExists = document.getElementById( 'parseChartTable' );
  var isTypeHierarchy = document.title == 'type_hierarchy';
  
  // Do not show the green individual numbered structures if it's the type hierarchy
  // in the top right or if we have a parse chart.
  if(parseChartExists || isTypeHierarchy) {
       document.getElementById("structureViewHolder").style.visibility = "hidden";
       
       // neu.
        document.getElementById("canvas").style.visibility = "hidden";
       
       // 
      // hide all green analyses.
        document.getElementById("tbuttons").style.display = "none";
      document.getElementById("tbVisibilityControlButton").innerHTML = "&curren;";
  
       //document.getElementById("viewSelector").style.display = "none";
  }
   else {
       
   } 
       
  
}

var __tb_visible    = true;
var __tb_selection  = null;
var __tb_onchange   = null;

function tb_show_hide(event) {
  
    
  var buttons = document.getElementById("tbuttons");
  var visctrl = document.getElementById("tbVisibilityControlButton");
  if (__tb_visible) {
    if (event.ctrlKey == 1) {
      document.getElementById("viewSelector").style.display = "none";
    }
    else {
      buttons.style.display = "none";
      visctrl.innerHTML = "&curren;";
    }
  }
  else {
    buttons.style.display = "inline";
    visctrl.innerHTML = "&times;";
  }
  __tb_visible = !__tb_visible;
  return false;
}

function tb_select(btn) {
    // niko. set visible
    document.getElementById("structureViewHolder").style.visibility = "visible";
    
  if (btn == __tb_selection)
    return;
  if (__tb_selection != null) {
    __tb_selection.style.backgroundColor = btn.style.backgroundColor;
  }
  __tb_selection = btn;
  btn.style.backgroundColor = "black";
  if (__tb_onchange != null)
    __tb_onchange(btn);
}

function tb_init() {
  if (document.getElementById("struct-2") == null) {
    document.getElementById("viewSelectorHolder").style.display = "none";  
    show_struct("1");
  }
  else {
    __tb_onchange = tb_onchange;
    document.getElementById("tbVisibilityControlButton").innerHTML="&times;";
    tb_select(document.getElementById("tbuttons").firstChild);
  }
}

function tb_onchange(e) {
  var id = e.innerHTML;
  show_struct(id);
}

var _structs = new Array();
var _current_struct = null;
// layouts the nodes of _current_struct, if tree
var _layout = new TreeLayout(15, 15, 25, 40);
var __is_IE = window.navigator.userAgent.indexOf("MSIE") != -1;
