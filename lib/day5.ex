defmodule Day5 do
  @filename "day5.txt"

  def sum_middle_pages_from_valid_manuals(input) do
    {rulebook, manuals} = handle_input(input)

    manuals
    |> Enum.filter(fn manual -> is_manual_valid(manual, rulebook) end)
    |> Enum.map(fn line -> Enum.at(line, div(length(line), 2)) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def sum_middle_pages_from_fixed_manuals(input) do
    {rulebook, manuals} = handle_input(input)

    manuals
    |> Enum.filter(fn manual -> not is_manual_valid(manual, rulebook) end)
    |> Enum.map(fn manual -> fix_manual(manual, rulebook) end)
    |> Enum.map(fn line -> Enum.at(line, div(length(line), 2)) end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp fix_manual(incorrect_manual, rulebook) do
    incorrect_manual
    |> Enum.reduce(incorrect_manual, fn page, current_manual ->
      fix_manual_page(current_manual, page, Map.get(rulebook, page, []))
    end)
  end

  defp fix_manual_page(manual, _page, []), do: manual

  defp fix_manual_page(manual, page, [rule_to_fix | rules_left]) do
    fixed_rule = [rule_to_fix, page]

    rule_index =
      Enum.find_index(manual, fn page_to_fix -> page_to_fix == rule_to_fix end)

    page_index =
      Enum.find_index(manual, fn page_to_fix -> page == page_to_fix end)

    if(rule_index == nil || rule_index < page_index) do
      fix_manual_page(manual, page, rules_left)
    else
      manual
      |> List.replace_at(rule_index, fixed_rule)
      |> List.delete(page)
      |> List.flatten()
      |> fix_manual_page(page, rules_left)
    end
  end

  defp handle_input(input) do
    {rules, manuals} =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "\n", trim: true) end)
      |> List.to_tuple()

    {create_rule_map(rules), create_reversed_manual_list(manuals)}
  end

  defp is_manual_valid([], _rulebook), do: true

  defp is_manual_valid([current_page | other_pages], rulebook) do
    forbidden_pages =
      Map.get(rulebook, current_page, [])

    broken_rules =
      other_pages
      |> Enum.filter(fn page -> page in forbidden_pages end)
      |> Enum.count()

    broken_rules == 0 and is_manual_valid(other_pages, rulebook)
  end

  defp create_rule_map(rules) do
    rules
    |> Enum.map(fn line -> String.split(line, "|", trim: true) end)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.reduce(%{}, fn {page, rule_for_page}, rulebook ->
      {_value, new_rulebook} =
        Map.get_and_update(rulebook, page, fn current_value ->
          {page, [rule_for_page | current_value || []]}
        end)

      new_rulebook
    end)
  end

  defp create_reversed_manual_list(manuals) do
    Enum.map(manuals, fn line -> String.split(line, ",", trim: true) end)
    |> Enum.map(&Enum.reverse/1)
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> sum_middle_pages_from_valid_manuals()
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> sum_middle_pages_from_fixed_manuals()
  end
end
