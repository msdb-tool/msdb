defmodule MsdbWeb.ZpoolController do
  use MsdbWeb, :controller

  def index(conn, _params) do
    zpools = Msdb.Zpool.list()
    render(conn, "index.html", zpools: zpools)
  end
end
