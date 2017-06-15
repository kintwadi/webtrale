//
// WARNING: this is either trale-msg.g or a Java file generated from it !!!
//

package gralej.parsers;

import gralej.om.IEntity;
import gralej.om.IFeatureValuePair;
import gralej.om.IList;
import gralej.om.ITree;
import gralej.om.IRelation;
import gralej.om.IVisitable;
import gralej.om.IneqsAndResidue;

import java.util.Map;
import java.util.LinkedList;
import java.util.TreeMap;

import tomato.GrammarHandler;
import tomato.Token;

import static gralej.Globals.LRS_PREFIX;

@SuppressWarnings("unchecked")
public class TraleMsgHandler extends GrammarHandler {
    static class L<T> extends LinkedList<T> {
        L<T> a(T el) { add(el); return this; }
    }
    
    static class Pair<T,V> {
        final T _1;
        final V _2;
        Pair(T first, V second) { _1 = first; _2 = second; }
    }
    
    OM.Flags _flags;
    
    Map<Integer,IEntity> _id2ent  = new TreeMap<Integer,IEntity>();
    Map<Integer,IEntity> _tag2ent = new TreeMap<Integer,IEntity>();
    
    ITree _tree;

    L<OM.Tag> _tags = new L<OM.Tag>();
    L<Pair<OM.Tree,Integer>> _trees = new L<Pair<OM.Tree,Integer>>();
    
    TraleMsgHandlerHelper _helper = new TraleMsgHandlerHelper();

    private void bindRefs() {
        for (OM.Tag tag : _tags)
            tag.setTarget(_tag2ent.get(tag.number()));
        
        for (Pair<OM.Tree,Integer> p : _trees)
            p._1.setContent(_id2ent.get(p._2));
    }
    
    static String S(Object o) {
        return ((Token)o).content().toString();
    }
    
    static int N(Object o) {
        return Integer.parseInt(S(o));
    }
    
    static class NotImplementedException extends RuntimeException {
        public NotImplementedException() {}
        public NotImplementedException(String msg) { super(msg); }
    }
    
%

########################
## Root ################
########################
datapackages: | datapackages datapackage0 .

datapackage0: datapackage _NEWLINE 
        {
            // prepare for the next datapackage
            _tree = null;
            _id2ent.clear();
            _tag2ent.clear();
            _tags.clear();
            _trees.clear();
            return null;
        }
    .

datapackage:
    _NEWDATA windowtitle structure structures0 ineqs residue
        {{
            bindRefs();
            
            String title = S(_[1]);
            L<IRelation> ineqs   = (L<IRelation>)_[4];
            L<IRelation> residue = (L<IRelation>)_[5];

            IneqsAndResidue iqsres = new IneqsAndResidue(ineqs, residue);
            
            if (_tree != null) {
                _helper.adviceResult(title, _tree, iqsres);
                return null;
            }
            IVisitable obj = (IVisitable)_[2];
            if (obj == null)
                throw new NotImplementedException("in datapackage");

            _helper.adviceResult(title, obj, iqsres);

            return null;
        }}
    .

ineqs:
    | _MINUS relations
        { return _[1]; }
    .

residue:
    | _SLASH relations
        { return _[1]; }
    .
    

########################
## Sequences ###########
########################
structures0
 :  | structure structures0 .
structs
 :    { return new L<IEntity>(); } 
  |  structs struct 
        { L<IEntity> ls = (L<IEntity>)_[0];
          ls.add((IEntity)_[1]);
          return ls;
        }
  .
trees
 :    { return new L<ITree>(); }
  |  trees tree
        { L<ITree> ls = (L<ITree>)_[0];
          ls.add((ITree)_[1]);
          return ls;
        }
  .
featvals
 :    { return new L<IFeatureValuePair>(); }
  |   featvals featval
        { L<IFeatureValuePair> ls = (L<IFeatureValuePair>)_[0];
          ls.add((IFeatureValuePair)_[1]);
          return ls;
        }
  .
flags
 :    { return _flags = new OM.Flags(); }
  | flags flag
        { return _flags; }
  .

relations:
    relation
        { return new L<IRelation>().a((IRelation)_[0]); }
    | relations relation
        { return ((L<IRelation>)_[0]).a((IRelation)_[1]); }
    .

########################
## Structures ##########
########################
structure
 :  struct | reentr | tree
  .

struct
 :  struc
  | ref 
  | function 
  | relation 
  | list 
  | set 
  | any 
  | disjunction
  | conjunction
  | table
  .

tree
 :  _BEGIN_TREE flags id label arclabel linkid trees _RPAR
    {
        String label        = S(_[3]);
        int linkid          = N(_[5]);
        L<ITree> children   = (L<ITree>)_[6];
        
        OM.Tree t = new OM.Tree(label, children);
        
        _trees.add(new Pair<OM.Tree,Integer>(t,linkid));
        
        return _tree = t;
    }
  | _BEGIN_TREE flags id label arclabel structure trees _RPAR
    {
        String label        = S(_[3]);
        IEntity content     = (IEntity)_[5];
        L<ITree> children   = (L<ITree>)_[6];
        
        OM.Tree t = new OM.Tree(label, children);
        t.setContent(content);
        
        return _tree = t;
    }
  .

reentr
 :  _BEGIN_REENTR flags id tag struct _RPAR
       {{
          if (_[4] != null) {
            int id  = N(_[2]);
            int tag = N(_[3]);
            IEntity e = (IEntity)_[4];
            
            _id2ent.put(id, e);
            _tag2ent.put(tag, e);
          }
          return null;
       }}
  .

table
 : _LB tableHeading _MINUS tableRows _RB
        { return new OM.Table((String)_[1], (L)_[3]); }
  .

tableHeading
 : | _STRING { return S(_[0]); } .

tableRows
 : tableRow
        { L ls = new L(); ls.add(_[0]); return ls; }
  | tableRows tableRow
        { ((L)_[0]).add(_[1]); return _[0]; }
  .

tableRow
 : _STRING struct
        { return new OM.FeatVal(OM.DEFAULT_FLAGS, S(_[0]), (IEntity)_[1]); }
  .
struc
 :  _BEGIN_STRUC flags id type featvals _RPAR
        {
            OM.TFS tfs = new OM.TFS(
                (OM.Flags)_[1],
                (OM.Type) _[3],
                (L<IFeatureValuePair>)_[4]
                );
            int id = N(_[2]);
            _id2ent.put(id, tfs);
            
            return tfs;
        }
  .

featval
 :  _BEGIN_FEATVAL flags id feature struct _RPAR
        {
            return new OM.FeatVal(
                (OM.Flags)_[1],
                S(_[3]),        // feature
                (IEntity)_[4]   // value
                );
        }
   |  _BEGIN_FEATVAL flags id feature _RPAR 
        { throw new NotImplementedException("value-less feature"); }
  .

disjunction
 :  _BEGIN_DISJ flags id struct struct structs _RPAR
        { throw new NotImplementedException("disjunction"); } . 

conjunction
 :  _BEGIN_CONJ flags id struct struct structs _RPAR
        { throw new NotImplementedException("conjunction"); } . 

list
 :  _BEGIN_LIST flags id structs tail _RPAR
        {
            L<IEntity> structs  = (L<IEntity>)_[3];
            IEntity tail        = (IEntity)_[4];
            
            IList ls = new OM.List((OM.Flags)_[1], structs, tail);
            _id2ent.put(N(_[2]), ls);
            return ls;
        }
  .

tail
 :  | _BEGIN_TAIL flags id struct _RPAR 
            { return _[3]; }
  .

set
 :  _BEGIN_SET flags id structs rest _RPAR
        { throw new NotImplementedException("set"); } .

rest
 :  | _BEGIN_REST flags id struct _RPAR
        { throw new NotImplementedException("rest"); } .

function
 :  _BEGIN_FUNCT flags id type functor structs _RPAR
        { throw new NotImplementedException("function"); } .

relation
 :  _BEGIN_REL flags id functor structs _RPAR
        {
            return new OM.Relation(
                (OM.Flags)_[1],
                S(_[3]),
                (L<IEntity>)_[4]
            );
        }
    .

type
 :
  |   _LPAR flags id name _RPAR
        { return new OM.Type((OM.Flags)_[1], S(_[3])); }
  .

ref
 :  _BEGIN_REF flags id target _RPAR
        {
            OM.Tag tag = new OM.Tag(
                (OM.Flags)_[1],
                N(_[3])     // tag number
                );
            _tags.add(tag);
            _id2ent.put(N(_[2]), tag);
            return tag;
        }
  .

any
 :  _BEGIN_ANY flags id value _RPAR
        {{
            String s = S(_[3]);
            IEntity ent;
            if (s.startsWith(LRS_PREFIX)) {
                s = s.substring(LRS_PREFIX.length());
                ent = LRSExpr.parse(s, _tags);
            }
            else
                ent = new OM.Any(
                    (OM.Flags)_[1],
                    s
                    );
            _id2ent.put(N(_[2]), ent);
            return ent;
        }}
  .

########################
# Values ###############
########################
feature    :  _STRING .
functor    :  _STRING .
windowtitle:  _STRING .
label      :	_STRING .
arclabel   : | _STRING .
id         :	_INT.
linkid     :	_INT.
name       : _STRING .
value      : _STRING .
tag        : _INT .
target     : _INT .

########################
# Flags ################
########################
flag       :
    |   hidden      { _flags.setHidden();       return null; }
    |   different   { _flags.setDifferent();    return null; }
    |   struckout   { _flags.setStruckout();    return null; }
    |   multiline   { _flags.setMultiline();    return null; }
    |   expanded    { _flags.setExpanded();     return null; }
    .

hidden      {}: _PLUS .
different   {}: _STAR .
struckout   {}: _MINUS .
multiline   {}: _PIPE .
expanded    {}: _LT .

%
}
