%
########################
## Root ################
########################
datapackage
  ->  _NEWDATA windowtitle structures
  .
########################
## Sequences ###########
########################
structures
  ->  structure | structure structures .
structs
  ->	| struct structs .
trees
  ->  | tree trees .
featvals
  ->  | featval featvals .
flags
  ->  | flag flags
  .
########################
## Structures ##########
########################
structure
  ->  struct | reentr | tree
  .
struct
  ->  struc
  | ref 
  | function 
  | relation 
  | list 
  | set 
  | any 
  | disjunction 
  | conjunction
  .
tree
  ->  _BEGIN_TREE flags id label arclabel linkid trees _RPAR .
reentr
  ->  _BEGIN_REENTR flags id tag struct _RPAR .
struc
  ->  _BEGIN_STRUC flags id type featvals _RPAR .
featval
  ->  _BEGIN_FEATVAL flags id feature struct _RPAR
   |  _BEGIN_FEATVAL flags id feature _RPAR
   .
disjunction
  ->  _BEGIN_DISJ flags id struct struct structs _RPAR . 
conjunction
  ->  _BEGIN_CONJ flags id struct struct structs _RPAR .
list
  ->  _BEGIN_LIST flags id structs tail _RPAR .
tail
  ->  | _BEGIN_TAIL flags id struct _RPAR .
set
  ->  _BEGIN_SET flags id structs rest _RPAR .
rest
  ->  | _BEGIN_REST flags id struct _RPAR .
function
  ->	_BEGIN_FUNCT flags id type functor structs _RPAR .
relation
  ->	_BEGIN_REL flags id functor structs _RPAR .
type
  ->	_LPAR flags id name _RPAR .
ref
  ->  _BEGIN_REF flags id target _RPAR .
any
  ->  _BEGIN_ANY flags id value _RPAR
  .
########################
# Values ###############
########################
feature     ->  _STRING .
functor     ->  _STRING .
windowtitle ->  _STRING .
label       ->	_STRING .
arclabel    -> | _STRING .
id          ->	_INT.
linkid      ->	_INT.
name        -> _STRING .
value       -> _STRING .
tag         -> _INT .
target      -> _INT .

flag        -> hidden | different | struckout 
            | multiline | expanded .
hidden      -> _PLUS .
different   -> _STAR .
struckout   -> _MINUS .
multiline   -> _PIPE .
expanded	  -> _LT .
