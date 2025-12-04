% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Aidan Blankenship
%
% Documentation: No help received.
%

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

day(tuesday).
day(wednesday).
day(thrusday).
day(friday).

object(balloon).
object(kite).
object(cloud).
object(fighter).


solve :-
    cadet(tuesdayCadet), cadet(wednesdayCadet), 
    cadet(thursdayCadet), cadet(fridayCadet),
    all_different([tuesdayCadet, wednesdayCadet, thursdayCadet, fridayCadet]),
            
    object(tuesdayObject), object(wednesdayObject), 
    object(thursdayObject), object(fridayObject),
    all_different([tuesdayObject, wednesdayObject, thursdayObject, fridayObject]),
    
    Triples = [ [tuesdayCadet, tuesday, tuesdayObject],
                [wednesdayCadet, wednesday, wednesdayObject],
                [thursdayCadet, thursday, thursdayObject],
                [fridayCadet, friday, fridayObject] ],
    
	%C4C Smith did not see a weather balloon, nor kite.
	\+ member([smith, _, balloon], Triples),
	\+ member([smith, _, kite], Triples),    
	%The one who saw the kite isn’t C4C Garcia.
	\+ member([garcia, _, kite], Triples),
	%Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
	(member([chen, friday, _], Triples); 
    member([_, friday, fighter], Triples)),
	%The kite was not sighted on Tuesday.
	\+ member([_, tuesday, kite], Triples),
	%Neither C4C Garcia nor C4C Jones saw the weather balloon.
	\+ member([garcia, _, balloon], Triples),
	\+ member([jones, _, balloon], Triples),
	%C4C Jones did not make their sighting on Tuesday.
	\+ member([jones, tuesday, _], Triples),
	%C4C Smith saw an object that turned out to be a cloud.
	(   member([smith, _, cloud], Triples)   ),
	%The fighter aircraft was spotted on Friday.
	(   member([_, friday, fighter], Triples)   ),
	%The weather balloon was not spotted on Wednesday.
	\+ member([_, wednesday, balloon], Triples),
        
    tell(tuesdayCadet, tuesday, tuesdayObject),
    tell(wednesdayCadet, wednesday, wednesdayObject),
    tell(thursdayCadet, thursday, thursdayObject),
    tell(fridayCadet, friday, fridayObject).
        
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).
                                          
tell(C, D, O) :-
	write('C4C '), write(C), write('saw the '), write(O), write('on '), write(D), write('.'), nl.
% The query to get the answer(s) or that there is no answer
% ?- solve.
