-module(kitchen).
-compile(export_all).

start() ->
    Pid = spawn(?MODULE, db, [[]]), % start database first
    register(food_db, Pid),
    spawn(?MODULE, restarter, [start]).
    
restarter(Command) ->
    case Command of
        start ->
            process_flag(trap_exit, true),
            food_db ! {self(), start, list};
        _ ->
            ok
    end,
    FridgePid = whereis(fridge),
    receive
        {start, FoodList} -> % got food list now spawn fridge
            Pid = spawn_link(?MODULE, fridge, [start, FoodList]),
            register(fridge, Pid),
            io:format("Fridge running.~n"),
            restarter(continue);
        {'EXIT', FridgePid, normal} ->
            food_db ! terminate,
            ok;
        {'EXIT', FridgePid, shutdown} ->
            food_db ! terminate,
            ok;
        {'EXIT', FridgePid, _} -> % restart when crash happens, ask for latest list
            restarter(start)
    end.
    
db(FoodList) ->
    receive
        {From, Ref, list} ->
            From ! {Ref, FoodList},
            db(FoodList);
        {update, NewFoodList} ->
            db(NewFoodList);
        terminate ->
            ok
    end.
    
power() ->
    fridge ! cool,
    receive
        terminate ->
            ok
    after 10000 -> % cool every 10 seconds
        power()
    end.

outside() ->
    fridge ! heat,
    receive
        terminate ->
            ok
    after 10000 -> % heat every 10 seconds
        outside()
    end.

monitor() -> % check the fridge is temp every 10 seconds
    fridge ! check_temp,
    receive
    after 10000 ->
        monitor()
    end.

store(Food) ->
    store(Food, 72). % default to 72 degrees if no temp given

store(Food, Temp) ->
    Ref = make_ref(),
    fridge ! {self(), Ref, {store, {Food, Temp}}},
    receive
        {Ref, Msg} -> Msg
    after 3000 ->
        timeout
    end.

take(Food) ->
    Ref = make_ref(),
    fridge ! {self(), Ref, {take, Food}},
    receive
        {Ref, Msg} -> Msg
    after 3000 ->
        timeout
    end.

list() ->
    Ref = make_ref(),
    fridge ! {self(), Ref, list},
    receive
        {Ref, Msg} -> Msg
    after 3000 ->
        timeout
    end.

cool_it({Key, Value}) when Value > 40 ->
    {Key, Value - 2};
cool_it(KV) ->
    KV.

heat_it({Key, Value}) ->
    {Key, Value + 1};
heat_it(KV) ->
    KV.

values({_Key, Value}) ->
    Value;
values(KV) ->
    KV.

fridge(Command, FoodList) ->
    case Command of
        start ->
            Ppid = spawn(?MODULE, power, []),
            register(fridge_power, Ppid),
            spawn_link(?MODULE, outside, []),
            spawn_link(?MODULE, monitor, []);
        _ ->
            ok
    end,
    receive
        {From, Ref, {store, {Food, Temp}}} ->
            From ! {Ref, ok},
            food_db ! {update, [{Food, Temp}|FoodList]}, 
            fridge(continue, [{Food, Temp}|FoodList]);
        {From, Ref, {take, Food}} ->
            case lists:keymember(Food, 1, FoodList) of
                true ->
                    {_Value, Tuple, NewFoodList} = lists:keytake(Food, 1, FoodList),
                    food_db ! {update, NewFoodList},
                    From ! {Ref, {ok, Tuple}},
                    fridge(continue, NewFoodList);
                false ->
                    From ! {Ref, not_found},
                    fridge(continue, FoodList)
            end;
        {From, Ref, list} ->
            From ! {Ref, FoodList},
            fridge(continue, FoodList);
        cool ->
            CooledList = lists:map(fun kitchen:cool_it/1, FoodList),
            food_db ! {update, CooledList}, 
            fridge(continue, CooledList);
        heat ->
            HeatedList = lists:map(fun kitchen:heat_it/1, FoodList),
            food_db ! {update, HeatedList}, 
            fridge(continue, HeatedList);
        check_temp ->
            ValueList = lists:map(fun kitchen:values/1, FoodList),
            Nbr = length(ValueList),
            Sum = lists:foldl(fun (X, Sum) -> X + Sum end, 0, ValueList),
            if Nbr > 0 ->
                Avg = Sum / Nbr,
                if Avg > 72 -> 
                    io:format("Fridge is too hot.~n");
                true ->
                    ok
                end;
            true ->
                ok
            end,
            fridge(continue, FoodList);
        terminate ->
            ok
    end.
