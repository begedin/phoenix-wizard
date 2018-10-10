defmodule WizardWeb.Router do
  use WizardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WizardWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/step-1", WizardController, :step_1
    post "/step-1", WizardController, :submit_step_1
    get "/step-2", WizardController, :step_2
    post "/step-2", WizardController, :submit_step_2
    get "/doublecheck", WizardController, :doublecheck
    post "/confirm", WizardController, :confirm
    get "/done", WizardController, :done
  end

  # Other scopes may use custom stacks.
  # scope "/api", WizardWeb do
  #   pipe_through :api
  # end
end
