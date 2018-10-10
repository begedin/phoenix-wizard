defmodule WizardWeb.PageController do
  use WizardWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
