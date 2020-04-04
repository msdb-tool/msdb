defmodule MsdbWeb.ZpoolController do
  use MsdbWeb, :controller

  def list(conn, _params) do
    zpools = Msdb.Zpool.list()
    render(conn, "list.html", zpools: zpools)
  end

  def history(conn, %{"zpool" => zpool}) do
    history = Msdb.Zpool.history(zpool)
    render(conn, "history.html", history: history)
  end
end
