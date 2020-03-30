defmodule Msdb.Zpool do
  @spec list() :: list(list())
  def list() do
    {raw_list, _} =
      System.cmd("zpool", [
        "list",
        "-H",
        "-o",
        "name,size,allocated,free,checkpoint,expandsize,fragmentation,capacity,dedupratio,health,altroot"
      ])

    raw_list
    |> sanitize_raw_string()
    |> parse_list()
  end

  @spec sanitize_raw_string(String.t()) :: list(list(String.t()))
  def sanitize_raw_string(raw_list) do
    raw_list |> String.replace_trailing("\n", "") |> String.split("\n")
  end

  @type zpool :: list(tuple)
  @type zpools :: list(zpool)

  @spec parse_list(list(list)) :: zpools
  def parse_list(zpools) do
    Enum.map(zpools, fn zpool ->
      [
        name,
        size,
        allocated,
        free,
        checkpoint,
        expandsize,
        fragmentation,
        capacity,
        dedupratio,
        health,
        altroot
      ] = zpool |> String.split()

      [
        name: name,
        size: size,
        allocated: allocated,
        free: free,
        checkpoint: checkpoint,
        expandsize: expandsize,
        fragmentation: fragmentation,
        capacity: capacity,
        dedupratio: dedupratio,
        health: health,
        altroot: altroot
      ]
    end)
  end
end