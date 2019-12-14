defmodule Intcode do
  defstruct memory: %{}, instruction: 0, input: :queue.new(), output: []

  def new(memory) when is_list(memory) do
    memory =
      for {value, index} <- Stream.with_index(memory),
      into: %{},
      do: {index, String.to_integer(value)}

    %__MODULE__{memory: memory}
  end

  # execute instructions until the computer halts, and return the final state
  def run(computer) do
    computer
    |> Stream.iterate(&execute_instruction/1)
    |> Stream.take_while(fn result -> result != :halt end)
    |> Enum.at(-1)
  end

  # write to an address in the computer's memory
  def set_memory(computer, address, value) do
    write(computer, {:positional, address}, value)
  end

  # get the value currently stored at an address in the computer's memory
  def get_memory(computer, address) do
    _read(computer, address)
  end

  # add an item to the front of the computer's input queue
  def push_input(computer, value) do
    update_in(computer.input, &:queue.in(value, &1))
  end

  # for day 5, get the diagnostic code from the computer's output.
  # assumes all prior tests have run correctly (output 0)
  def diagnostic_code(computer) do
    {_tests, [code]} = Enum.split_while(output(computer), &(&1 == 0))
    code
  end

  # executes the instruction stored in memory at the current instruction pointer
  # returns the updated computer for most, and :halt if the computer has halted.
  defp execute_instruction(%{instruction: instruction} = computer) do
    code = _read(computer, instruction)
    {fun, arity} = lookup_instruction(code)
    args = parameters(computer, code, arity)

    # we only need to increment the instruction pointer only if it
    # was not changed as a result of executing the instruction.
    with %{instruction: ^instruction} = computer <- apply(fun, [computer | args]),
         do: update_in(computer.instruction, &(&1 + arity + 1))
  end

  defp parameters(computer, code, arity) do
    Stream.unfold({1, div(code, 100)}, fn {offset, mode_acc} ->
      value = _read(computer, computer.instruction + offset)
      mode = parameter_mode(rem(mode_acc, 10))
      {{mode, value}, {offset + 1, div(mode_acc, 10)}}
    end)
    |> Enum.take(arity)
  end

  defp parameter_mode(0), do: :positional
  defp parameter_mode(1), do: :immediate

  # looks up an instruction using the provided code - returns {fun, arity} tuple
  defp lookup_instruction(code) do
    fun = Map.fetch!(instruction_table(), rem(code, 100))
    {:arity, arity} = Function.info(fun, :arity)

    # offset by -1 because we provide the current machine state as the first arg
    {fun, arity - 1}
  end

  # lookup table mapping opcodes to functions
  defp instruction_table do
    %{
      1 => &add/4,
      2 => &mul/4,
      3 => &input/2,
      4 => &output/2,
      5 => &jump_if_true/3,
      6 => &jump_if_false/3,
      7 => &less_than/4,
      8 => &equals/4,
      99 => &halt/1
    }
  end

  defp add(computer, param1, param2, param3) do
    write(computer, param3, read(computer, param1) + read(computer, param2))
  end

  defp mul(computer, param1, param2, param3) do
    write(computer, param3, read(computer, param1) * read(computer, param2))
  end

  defp input(computer, param) do
    {{:value, value}, input} = :queue.out(computer.input)
    computer = %{computer | input: input}
    write(computer, param, value)
  end

  defp output(computer, param) do
    update_in(computer.output, &[&1, read(computer, param)])
  end

  defp jump_if_true(computer, param1, param2) do
    if read(computer, param1) != 0 do
      jump(computer, read(computer, param2))
    else
      computer
    end
  end

  defp jump_if_false(computer, param1, param2) do
    if read(computer, param1) == 0 do
      jump(computer, read(computer, param2))
    else
      computer
    end
  end

  defp less_than(computer, param1, param2, param3) do
    value = if read(computer, param1) < read(computer, param2), do: 1, else: 0
    write(computer, param3, value)
  end

  defp equals(computer, param1, param2, param3) do
    value = if read(computer, param1) == read(computer, param2), do: 1, else: 0
    write(computer, param3, value)
  end

  defp halt(_computer), do: :halt

  defp jump(computer, address), do: %{computer | instruction: address}

  defp output(computer), do: List.flatten(computer.output)

  defp write(computer, {_mode, address}, value), do: put_in(computer.memory[address], value)

  defp read(computer, {:positional, address}), do: _read(computer, address)
  defp read(_computer, {:immediate, value}), do: value

  # for internal usage
  defp _read(computer, address), do: Map.fetch!(computer.memory, address)
end
