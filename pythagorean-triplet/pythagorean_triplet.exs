defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    Enum.reduce(triplet, &(&1 + &2))
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    Enum.reduce(triplet, &(&1 * &2))
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a * a + b * b == c * c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    Range.new(min + 1, max)
    |> Enum.map(&(find_a_b(&1, min)))
    |> Enum.reject(&Enum.empty?/1)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    generate(min, max)
    |> Enum.filter(&(sum(&1) == sum))
    |> Enum.reverse
  end

  defp find_a_b(c, min) do
    b = find_b_given_c(c, min)
    a = find_a_given_b_c(b, c, min)
    if a == nil || b == nil do
      []
    else
      [a, b, c]
    end
  end

  defp find_b_given_c(c, min) do
    Enum.find(Range.new(min, c - 1), fn(b) ->
      find_a_given_b_c(b, c, min)
    end)
  end

  defp find_a_given_b_c(nil, _c, _min), do: nil
  defp find_a_given_b_c(b, c, min) do
    Enum.find(Range.new(min, b - 1), fn(a) ->
      pythagorean?([a, b, c])
    end)
  end
end
