module Recursive
  module_function
  def tail_fac(n, acc=1)
    return acc if n == 0
    tail_fac(n - 1, n * acc)
  end
end
