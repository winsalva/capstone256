defmodule AppWeb.PageController do
  use AppWeb, :controller

  alias App.Query.Upload
  
  def index(conn, _params) do
    ## temporary commenting out
    #uploads = Upload.list_uploads
    #render(conn, :index, uploads: uploads)

    conn
    |> redirect(to: Routes.page_path(conn, :gantt_chart))
  end

  def gantt_chart(conn, _params) do
    render(conn, "gantt-chart.html")
  end

  def term_of_use(conn, _params) do
    render(conn, "term-of-use.html")
  end

  def privacy_policy(conn, _params) do
    render(conn, "privacy-policy.html")
  end

  def about_us(conn, _params) do
    render(conn, "about-us.html")
  end

  def menus(conn, _params) do
    render(conn, "menus.html")
  end
end