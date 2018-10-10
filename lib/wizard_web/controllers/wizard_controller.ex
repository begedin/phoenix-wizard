defmodule WizardWeb.WizardController do
  use WizardWeb, :controller

  alias Wizard.Onboarding

  def step_1(conn, _params) do
    conn |> render("step_1.html")
  end

  def submit_step_1(conn, params) do
    conn.remote_ip |> Onboarding.submit_account(params)
    conn |> redirect(to: conn |> wizard_path(:step_2))
  end

  def step_2(conn, _params) do
    conn |> render("step_2.html")
  end

  def submit_step_2(conn, params) do
    conn.remote_ip |> Onboarding.submit_workspace(params)
    conn |> redirect(to: conn |> wizard_path(:doublecheck))
  end

  def doublecheck(conn, _params) do
    {account_params, workspace_params} = conn.remote_ip |> Onboarding.get_data()
    assigns = [account_params: account_params, workspace_params: workspace_params]
    conn |> render("doublecheck.html", assigns)
  end
end
