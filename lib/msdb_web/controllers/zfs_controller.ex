defmodule MsdbWeb.ZfsController do
  use MsdbWeb, :controller

  def index(conn, _params) do
    datasets = Msdb.Zfs.list()
    render(conn, "index.html", datasets: datasets)
  end
end
