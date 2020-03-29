defmodule Msdb.Zfs do
  def list() do
    {raw_list, _} = System.cmd("zfs", ["list", "-H", "-o", "name,used,avail,refer,mountpoint"])

    raw_list
    |> sanitize_raw_string()
    |> parse_list()
  end

  def sanitize_raw_string(raw_list) do
    raw_list |> String.replace_trailing("\n", "") |> String.split("\n")
  end

  def parse_list(datasets) do
    Enum.map(datasets, fn dataset ->
      [name, used, available, reference, mountpoint] = dataset |> String.split()
      [name: name, used: used, available: available, reference: reference, mountpoint: mountpoint]
    end)
  end
end
