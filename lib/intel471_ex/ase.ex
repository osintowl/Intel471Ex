defmodule Intel471Ex.Ase do
  @moduledoc """
  Functions for working with the Intel 471 Verity Attack Surface
  Exposure (ASE) API.

  Service path: `integrations/ase/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/ase/v1"

  @doc """
  List ASE monitors.

  ## Parameters

  - `params`: A map of query parameters
    - `:last_run_after` — Filter by last run after timestamp
    - `:last_run_before` — Filter by last run before timestamp

  ## Examples

      {:ok, monitors} = Intel471Ex.Ase.list_monitors()
  """
  @spec list_monitors(map()) :: {:ok, map()} | {:error, any()}
  def list_monitors(params \\ %{}) do
    Client.get("#{@service_path}/monitor", params)
  end
end