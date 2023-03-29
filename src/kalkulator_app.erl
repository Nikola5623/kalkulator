%%%-------------------------------------------------------------------
%% @doc kalkulator public API
%% @end
%%%-------------------------------------------------------------------

-module(kalkulator_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    kalkulator_sup:start_link(),
    {ok, Pid} = kalkulator_sup:start_connection(),
    main(ok, Pid).
            

stop(_State) ->
    ok.

%% internal functions


main(ok, Pid) ->
    {ok, A}=io:read("Podaj pierwszą wartość: "),
    {ok, B}=io:read("Podaj drugą wartość: "),
    {ok, Op}=io:read("Podaj operacje: "),
    Result = gen_server:call(Pid,{A, B, Op}),
    io:write(Result),
    Choice = io:read("Czy chcesz kontynuować tak/nie"),
    if Choice == tak ->
        main(ok, Pid);
    true ->
        main(close, Pid) end;
    main(close, Pid) ->
        io:write('Dziękuję za użycie programu').           

