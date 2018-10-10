defmodule Wizard.Onboarding do
  @name __MODULE__

  use GenServer

  # API

  def start_link() do
    GenServer.start_link(@name, [], name: @name)
  end

  def submit_account(ip, params) do
    GenServer.cast(@name, {:submit_account, ip, params})
  end

  def submit_workspace(ip, params) do
    GenServer.cast(@name, {:submit_workspace, ip, params})
  end

  def get_data(ip) do
    GenServer.call(@name, {:get_data, ip})
  end

  # Callbacks

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:submit_account, ip, params}, %{} = state) do
    # update state so old workspace params are kept but account is updated
    new_state =
      state
      |> Map.update(ip, {nil, nil}, fn {_, workspace_params} ->
        {params, workspace_params}
      end)

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:submit_workspace, ip, params}, %{} = state) do
    # update state so old account params are kept but workspace is updated
    new_state =
      state
      |> Map.update(ip, {nil, nil}, fn {account_params, _} ->
        {account_params, params}
      end)

    {:noreply, new_state}
  end

  @impl true
  def handle_call({:get_data, ip}, _from, %{} = state) do
    state |> IO.inspect
    {:reply, state[ip], state}
  end
end
