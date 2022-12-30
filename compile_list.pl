% compile_list.pl

% compile the list

% A=[[a,b],1]

% number array: index 0: [2 (number array length)]
% index 1:[0 (list code), 2 (number array index), 1 (number code), 1 (value), 4 (end code)]
% index 2: [2 (string code),1 (string array index), 2 (string code),2 (string array index), 4 (end code)]

% string array: index 0: [2 (array length)] 1:[a], 2: [b]

% also: 3-atom code

% length of array lists in array

% first item is item 0 in N and 0 in S


% compile_list([[a,b],1],N,S),writeln(N),writeln(S).


:- dynamic number_index/1.
:- dynamic string_index/1.

compile_list(List, Number_array, String_array) :-

retractall(number_index(_)),
assertz(number_index(0)),
retractall(string_index(_)),
assertz(string_index(-1)),

 compile_list(0, List, [], Number_array1, [], String_array1),
 
 % add ends, sort and findall lists, array lengths
 %trace,
 %findall(Number_array2,(member(List1,Number_array1),append(List1,[4],Number_array2)),Number_array3),
 
 sort(Number_array1,Number_array4),
 %trace,
 findall(List1,(member([_,List1],Number_array4)),Number_array5),
 
  findall(Number_array2,(member(List1,Number_array5),append(List1,[4],Number_array2)),Number_array51),
%trace,
 findall(L,(member(List1,Number_array51),length(List1,L)),L2),
 sort(L2,L3),
 (L3=[]->MaxN=0;append(_,[MaxN],L3)),

 length(Number_array51,Number_array5_length),
 
 append([[Number_array5_length,MaxN]],Number_array51,Number_array),


%(String_array1=[]->String_array2=[];)
 findall(List1,(member([_,List1],String_array1)),String_array2),


 findall(L,(member(List1,String_array2),string_length(List1,L)),L4),
 sort(L4,L5),
 (L5=[]->MaxS=0;append(_,[MaxS],L5)),

 
 length(String_array2,String_array2_length),
 
 append([String_array2_length,MaxS],String_array2,String_array),
 
!.


compile_list1(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-
%trace,
List1=[],

%is_list(Item),

number_index(Number_index1),
Number_index2 is Number_index1+1,

retractall(number_index(_)),
assertz(number_index(Number_index2)),

(member([Index,Array1],Number_array1)->
(append(Array1, [], Array2),
delete(Number_array1,[Index,_],Number_array3),
append(Number_array3,[[Index,Array2]],Number_array4));

(append([], [], Array2),
%delete(Number_array1,[Index,_],Number_array2),
append(Number_array1,[[Index,Array2]],Number_array4))),

Number_array4=Number_array2,
String_array1=String_array2,!.

compile_list1(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-

compile_list(Index, List1, Number_array1, Number_array2, String_array1, String_array2),!.

%compile_list(Number_index2, Item, Number_array4, Number_array5, String_array1, String_array3),

%compile_list1(Index, List2, Number_array5, Number_array2, String_array3, String_array2).


compile_list(_, [], Number_array, Number_array, String_array, String_array) :- !. 

compile_list(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-

List1=[Item | List2],

is_list(Item),

number_index(Number_index1),
Number_index2 is Number_index1+1,

retractall(number_index(_)),
assertz(number_index(Number_index2)),

(member([Index,Array1],Number_array1)->
(append(Array1, [0,Number_index2], Array2),
delete(Number_array1,[Index,_],Number_array3),
append(Number_array3,[[Index,Array2]],Number_array4));

(append([], [0,Number_index2], Array2),
%delete(Number_array1,[Index,_],Number_array2),
append(Number_array1,[[Index,Array2]],Number_array4))),

compile_list1(Number_index2, Item, Number_array4, Number_array5, String_array1, String_array3),

compile_list(Index, List2, Number_array5, Number_array2, String_array3, String_array2).



compile_list(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-

List1=[Item | List2],

number(Item),

(member([Index,Array1],Number_array1)->
(append(Array1, [1,Item], Array2),
delete(Number_array1,[Index,_],Number_array3),
append(Number_array3,[[Index,Array2]],Number_array4));

(append([], [1,Item], Array2),
%delete(Number_array1,[Index,_],Number_array2),
append(Number_array1,[[Index,Array2]],Number_array4))),

%compile_list(Number_index2, Item, Number_array4, Number_array5, String_array1, String_array3),

compile_list(Index, List2, Number_array4, Number_array2, String_array1, String_array2).


compile_list(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-

List1=[Item | List2],

string(Item),

(member([String_index2,Item],String_array1)->
(String_array1=String_array3%true%append(String_array1,[String_index2,Array2],Number_array4))
);
(string_index(String_index1),
String_index2 is String_index1+1,

retractall(string_index(_)),
assertz(string_index(String_index2)),

append(String_array1,[[String_index2,Item]],String_array3)
)),


(member([Index,Array1],Number_array1)->
(append(Array1, [2,String_index2], Array2),
delete(Number_array1,[Index,_],Number_array3),
append(Number_array3,[[Index,Array2]],Number_array4));

(append([], [2,String_index2], Array2),
%delete(Number_array1,[Index,_],Number_array2),
append(Number_array1,[[Index,Array2]],Number_array4))),

%compile_list(Number_index2, Item, Number_array4, Number_array5, String_array1, String_array3),

compile_list(Index, List2, Number_array4, Number_array2, String_array3, String_array2).


compile_list(Index, List1, Number_array1, Number_array2, String_array1, String_array2) :-

List1=[Item | List2],

atom(Item),

(member([String_index2,Item],String_array1)->
(String_array1=String_array3%true%append(String_array1,[String_index2,Array2],Number_array4))
);
(string_index(String_index1),
String_index2 is String_index1+1,

retractall(string_index(_)),
assertz(string_index(String_index2)),

append(String_array1,[[String_index2,Item]],String_array3)
)),


(member([Index,Array1],Number_array1)->
(append(Array1, [3,String_index2], Array2),
delete(Number_array1,[Index,_],Number_array3),
append(Number_array3,[[Index,Array2]],Number_array4));

(append([], [3,String_index2], Array2),
%delete(Number_array1,[Index,_],Number_array2),
append(Number_array1,[[Index,Array2]],Number_array4))),

%compile_list(Number_index2, Item, Number_array4, Number_array5, String_array1, String_array3),

compile_list(Index, List2, Number_array4, Number_array2, String_array3, String_array2).

