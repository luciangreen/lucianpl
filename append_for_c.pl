% append_for_c.pl


/*

?- compile_list([1,2],N,S).
N = [[2, 5], [0, 1, 4], [1, 1, 1, 2, 4]],
S = [0, 0].

?- compile_list([3,4],N,S).
N = [[2, 5], [0, 1, 4], [1, 3, 1, 4, 4]],
S = [0, 0].

?- compile_list([1,2,3,4],N,S),writeln(N).
N = [[2,9],[0,1,4],[1,1,1,2,1,3,1,4,4]]
S = [0, 0].

append_iio([[2, 5], [0, 1, 4], [1, 1, 1, 2, 4]],[0, 0],[[2, 5], [0, 1, 4], [1, 3, 1, 4, 4]],[0, 0],N3,S3),uncompile_list(N3,S3,L).

L=[1,2,3,4].
                                   compile_list([1],N1,S1),compile_list([2],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).
L = [1, 2] .

compile_list([1,[2]],N1,S1),compile_list([[3],4],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L),writeln(N3).
L = [1, [2], [3], 4] 



compile_list([[1,2],3,4],N1,S1),compile_list([3,[[]],4],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).

L = [[1, 2], 3, 4, 3, [[]], 4] 


compile_list([],N1,S1),compile_list([],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).

L = [] 

compile_list([a,"b"],N1,S1),compile_list(["a",b],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).
L = [a, "b", "a", b] .

 compile_list([[a,"b"],c,"d"],N1,S1),compile_list(["e",[[]],f],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).

L = [[a, "b"], c, "d", "e", [[]], f] ;

compile_list([a,"b"],N1,S1),compile_list([a,"b"],N2,S2),append_iio(N1,S1,N2,S2,N3,S3),uncompile_list(N3,S3,L).
L = [a, "b", a, "b"].


*/

:-include('uncompile_list.pl').

append_iio(N1,S1,N2,S2,N3,S3) :-
%trace,
 % get max index of N1

 N1=[[NAL1,Max_N1]|N11], % use in iteration in C
 N2=[[NAL2,Max_N2]|N21],

 S1=[SAL1,Max_S1|S11], % use in iteration in C
 S2=[SAL2,Max_S2|S21],


% test both are lists

N11=[[0,1,4]|N12],
N21=[[0,1,4]|N22],

% get both lists

N12=[N13|N14],
length(N12,LN12),
append(N15,[4],N13),

length(S11,LS11),

%N22=[N23|N24],
length(N22,LN22),
%trace,
%append(N25,[4],N23),

length(S21,LS21),

% repoint ns of later items in (n) list 2 to N+LN12

numbers(LN22,1,[],LNs),
findall(LNs1,(member(LNs2,LNs),LNs1 is LNs2+LN12-1),LNs3),
%trace,
findall(N245,(member(N241,N22),replace_items0(N241,LNs3,[],N245%(N241=[0,N242,4]->(get_item_n(LNs3,N242,N244),N245=[0,N244,4]);N245=N241)
)),N35),%N246),

numbers(LS21,1,[],LSs),
findall(LSs1,(member(LSs2,LSs),LSs1 is LSs2+LS11-1),LSs3),

%trace,
findall(N249,(member(N248,N35%N246
),replace_items(N248,LSs3,[],N249)),N351),

%trace,
%findall(N249,(member(N248,S21%N246
%),replace_items(N248,LSs3,[],N249)),N3512),

N351=[N247|N251],

%trace,
/* 
N15=N151,
%append(N15,[4],N151),
append(N25,[4],N251),
foldr(append,[N151,
N251],N35),
*/
NAL3 is NAL1+NAL2,

(Max_N1>=Max_N2->Max_N3=Max_N1;Max_N3=Max_N2),

length(N35,LN35),

(Max_N3>=LN35->Max_N4=Max_N3;Max_N4=LN35),
%trace,

(N14=[]->N141=[];N141=N14),

%trace,
(N24=[]->N241=[];(%foldr(append,N24,N242),
N241=N24)),

%foldr(append,[[[NAL3,Max_N4]],[[0,1,4]],[N35],N141,N241],N3),
append(N15,N247,N2470),
%trace,


% * get dimensions
%same for strings,atoms in L1 (below)

% watch for string, atoms in v,p

% repoint ns of later items in (s) list 2 to N+LS11


%trace,
foldr(append,[[[NAL3,Max_N4]],[[0,1,4]],[N2470],N14,N251%[N35],N141,N241
],N31),

%trace,
append(S11,S21,S31),
%SAL3 is SAL1+SAL2,

% get max s3

(Max_S1>=Max_S2->Max_S3=Max_S1;Max_S3=Max_S2),

%S311=[SAL3,Max_S3|S31],

% one copy of strings, atoms
%trace,
point_dups(S31,1,[],_S311,[],_S312,[],S313,[],S314),

length(S313,SAL4),

S3=[SAL4,Max_S3|S313],

N31=[[X,Y]|Z],
%trace,
findall(S315,(member(Z1,Z),replace_items(Z1,S314,[],S315)),S315),


% Get array length, max length for N list
%trace,
 findall(L,(member(List1,S315),length(List1,L)),L2),
 sort(L2,L3),
 (L3=[]->Y1=0;append(_,[Y1],L3)),

 length(S315,X1),

N3=[[X1,Y1]|S315],


!.

/*
[debug]  ?- point_dups([1,1,2,2,3],1,[],A,[],B,[],C).                               A = [[1, 1], [2, 3], [3, 5]],
non duplicated items and their indices

B = [[1, 1], [2, 1], [3, 3], [4, 3], [5, 5]],
(duplicated items x all items), their former indices and the indices of the items they are duplicates of

C = [1, 2, 3].
non duplicated items

D = [1,1,3,3,5],
(duplicated items x all items), (their former indices x) and the indices of the items they are duplicates of


*/

point_dups([],_,A,A,B,B,C,C,D,D):-!.
point_dups(A,N,B,C,B1,C1,B2,C2,B3,C3):-
 N1 is N+1,
 A=[D|E],
 (member([D,N2],B)->
 (%N0 is N-1,N02 is N2-1,
 append(B1,[[%D,
 N,N2]],F),
 N3 is N2-1,
 append(B3,[%D,
 N3],F3),
 point_dups(E,N1,B,C,F,C1,B2,C2,F3,C3));
 (N3 is N-1,
 append(B3,[%D,
 N3],F4),
 append(B1,[[%D,
 N,N]],F3),
 append(B,[[D,N]],F),
 append(B2,[D],F2),
 point_dups(E,N1,F,C,F3,C1,F2,C2,F4,C3))).


 % replace with 3rd set, then 2nd set (to avoid duplicates being replaced)
 
 %()replace_term(N11)

 % ()get list item of each list

 %N1=[[_,_]|N11], % start with index=1 not 0
 %N2=[[_,_]|N21],
 
 % get max of N1
 
 
 % shuffle N2 down according to max of N1
 
 % shuffle S2 down " S1
 
 % merge S1,S2
 
 % append lists
 
replace_items0(N252,LSs3,N255,N249):-
 replace_items01(N252,LSs3,N255,N2491),
 %trace,
 foldr(append,N2491,N249).

replace_items01([4],_LSs3,N250,N249) :-
 append(N250,[[4]],N249),!.
replace_items01(N248,LSs3,N2481,N249) :-
%trace,
 N248=[N250,N251|N252],
 (N250=0->(get_item_n(LSs3,N251,N253),N254=[N250,N253]);N254=[N250,N251]),
 append(N2481,[N254],N255),
 replace_items01(N252,LSs3,N255,N249).


replace_items(N252,LSs3,N255,N249):-
 replace_items1(N252,LSs3,N255,N2491),
 %trace,
 foldr(append,N2491,N249).

replace_items1([4],_LSs3,N250,N249) :-
 append(N250,[[4]],N249),!.
replace_items1(N248,LSs3,N2481,N249) :-
 N248=[N250,N251|N252],
 ((N250=2->true;(N250=3->true;(N250=5->true;(N250=6))))->(N2511 is N251+1,get_item_n(LSs3,N2511,N253),N254=[N250,N253]);N254=[N250,N251]),
 append(N2481,[N254],N255),
 replace_items1(N252,LSs3,N255,N249).


