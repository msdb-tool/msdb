defmodule MsdbWeb.StorageController do
  use MsdbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
