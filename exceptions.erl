-module(exceptions).
-compile(export_all).

throws(F) ->
  try F() of
    _ -> ok
  catch
    Throw -> {throw, caught, Throw}
  end.

errors(F) ->
  try F() of
    _ -> ok
  catch
    error:Error -> {error, caught, Error}
  end.

exits(F) ->
  try F() of
    _ -> ok
  catch
    exit:Exit -> {exit, caught, Exit}
  end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
  try Attack() of
    _ -> "None shall pass."
  catch
    throw:slice -> "Is is but a scratch.";
    error:cut_arm -> "I've had worse.";
    exit:cut_leg -> "Come on you pansy!";
    _:_ -> "Just a flesh wound."
  end.

talk() -> "blah blah".

whoa() ->
  try
    talk(),
    _Knight = "None shall Pass!",
    _Doubles = [N*2 || N <- lists:seq(1,100)],
    throw(up),
    _WillReturnThis = tequila
  of
    tequila -> "hey this worked!"
  catch
    Exception:Reason -> {caught, Exception, Reason}
  end.

im_impressed() ->
  try
    talk(),
    _Knight = "None shall Pass!",
    _Doubles = [N*2 || N <- lists:seq(1,100)],
    throw(up),
    _WillReturnThis = tequila
  catch
    Exception:Reason -> {caught, Exception, Reason}
  end.

catcher(X,Y) ->
  case catch X/Y of
    {'EXIT', {badarith,_}} -> "uh oh";
    N -> N
  end.
