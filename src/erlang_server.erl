-module(erlang_server).

-export([start_link/0]).

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, service/0]).

handle_cast(Args, B) ->
    {noreply, ok}.

service() ->
    gen_server:call(?MODULE, [argument]).

init([]) ->
    {ok, started}.


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

handle_call(Args, From, Oldstate) ->
   {reply, kal(Args), ok}.

kal({A, B, Op}) ->
    case Op of
    '+' -> A + B;
    '-' -> A - B;
    '*' -> A * B;
    '/' -> A / B;
    '^' -> math:pow(A, B);
    '%' -> mod(A, B);
    _ -> 'Zla operacja' end.


mod(A, B) when is_integer(A) and is_integer(B) ->
    A rem B;
    
mod(_, _) ->
    'Reszta z dzielenia musi być całkowita'.
