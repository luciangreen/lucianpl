% uncompile_list.pl

% can be modified to be list to string, equals4 in C

:-include('compile_list.pl').

/*

uncompile_list([[5,7],[0,1,4],[0,2,0,3,0,4,4],[4],[4],[4]],[0, 0],L).
L=[[],[],[]].

compile_list([1,[a,["a"],[v,a]],[n,a]],N,S),uncompile_list(N,S,L).
L = [1, [a, ["a"], [v, a]], [n, a]].

Don't need Height,Length in N - just for memory allocation, start with index 1

Don't need Height,Length in S - just for memory allocation, use indices from N

*/

uncompile_list(N,S,L) :-

 uncompile_list(N,S,[],L),!.

uncompile_list([],_,L,L) :- !.
uncompile_list(N,S,L1,L2) :-
 N=[[_,_]|N1],
 S=[_,_|S1],
 uncompile_list(1,N1,S1,L1,[L2]). % 1 needs to be 0 in C x not in C (for testing)
 
uncompile_list(Index,N,S,L1,L2) :-
 get_item_n(N,Index,N1),
 Index2 = 1, % 0 in C
 Index3 = 2, % 1 in C
 uncompile_list1(Index2,Index3,N1,N,S,L1,L2).

uncompile_list1(Index2,Index3,N1,N,S,L1,L2) :-
 get_item_n(N1,Index2,N2),
 (N2=4->
 (L1=L2);
 (get_item_n(N1,Index3,N3),
 %N31 is N3+1, % 0 C is 1 pl
 %trace,
 get_item_uncompile_list(N2,N3,N,S,L1,L3),
 Index21 is Index2+2,
 Index31 is Index3+2,
 uncompile_list1(Index21,Index31,N1,N,S,L3,L2))).

get_item_uncompile_list(N2,N3,N,S,L1,L2) :-
 N2=0, % list
 N31 is N3+1,
 uncompile_list(N31,N,S,[],L3), 
 append(L1,[L3],L2).
get_item_uncompile_list(N2,N3,_N,_S,L1,L2) :-
 N2=1, % number
 append(L1,[N3],L2).
get_item_uncompile_list(N2,N3,_N,S,L1,L2) :-
 N2=2, % string
 N31 is N3+1,
 get_item_n(S,N31,S1),
 append(L1,[S1],L2).
get_item_uncompile_list(N2,N3,_N,S,L1,L2) :-
 N2=3, % atom
 N31 is N3+1,
 get_item_n(S,N31,S1),
 append(L1,[S1],L2).
get_item_uncompile_list(N2,N3,_N,S,L1,L2) :-
 N2=5, % variable name
 N31 is N3+1,
 get_item_n(S,N31,S1),
 get_lang_word("v",Dbw_v),
 append(L1,[[Dbw_v,S1]],L2).
get_item_uncompile_list(N2,N3,_N,S,L1,L2) :-
 N2=6, % predicate name
 N31 is N3+1,
 get_item_n(S,N31,S1),
 get_lang_word("n",Dbw_n),
 append(L1,[[Dbw_n,S1]],L2).
