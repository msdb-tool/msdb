defmodule Msdb.ZfsTest do
  use ExUnit.Case
  doctest Msdb.Zfs

  test "Sanatize raw zfs list string" do
    raw_string = "ztest\t117K\t39.9M\t24K\t/ztest\nztest/lorem\t24K\t39.9M\t24K\t/ztest/lorem\n"

    sanitized_string = [
      "ztest\t117K\t39.9M\t24K\t/ztest",
      "ztest/lorem\t24K\t39.9M\t24K\t/ztest/lorem"
    ]

    assert Msdb.Zfs.sanitize_raw_string(raw_string) == sanitized_string
  end

  test "Parse correctly zfs list output" do
    list_unparsed = [
      "ztest         117K  39.9M       24K  /ztest",
      "ztest/lorem    24K  39.9M       24K  /ztest/lorem"
    ]

    list_parsed = [
      [
        name: "ztest",
        used: "117K",
        available: "39.9M",
        reference: "24K",
        mountpoint: "/ztest"
      ],
      [
        name: "ztest/lorem",
        used: "24K",
        available: "39.9M",
        reference: "24K",
        mountpoint: "/ztest/lorem"
      ]
    ]

    assert Msdb.Zfs.parse_list(list_unparsed) == list_parsed
  end
end
