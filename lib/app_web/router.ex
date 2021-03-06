defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AppWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/terms-of-use", PageController, :term_of_use
    get "/privacy-policy", PageController, :privacy_policy
    get "/menus", PageController, :menus
    get "/about-us", PageController, :about_us
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    get "/gantt-chart", PageController, :gantt_chart

    resources "/uploads", UploadController, only: [:index, :new, :create, :show, :edit, :update, :delete]

    resources "/blogs", BlogController, only: [:index, :new, :create, :show, :edit, :update, :delete]

    resources "/faqs", FaqController

  end

  scope "/users", AppWeb.User, as: :user do
    pipe_through :browser

    get "/", PageController, :index
    resources "/accounts", AccountController, only: [:new, :create, :show]

    get "/accounts/:id/edit-name", AccountController, :edit_name
    put "/accounts/edit-name", AccountController, :update_name
    get "/accounts/:id/change-password", AccountController, :change_password
    put "/accounts/change-password", AccountController, :update_password
  end

  scope "/items", AppWeb do
    pipe_through :browser

    resources "/", PageController, only: [
      :index
    ]

  end

  scope "/admins", AppWeb.Admin, as: :admin do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    get "/list-admins", PageController, :list_admins
    resources "/", PageController, only: [
      :index, :new, :create, :show, :edit, :update, :delete
    ]

     get "/accounts/:id/edit-username", AccountController, :edit_username
     put "/accounts/update-username", AccountController, :update_username
     get "/accoutns/:id/change-password", AccountController, :change_password
     put "/accounts/update-password", AccountController, :update_password

  end


  # Other scopes may use custom stacks.
  # scope "/api", AppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
    end
  end
end
