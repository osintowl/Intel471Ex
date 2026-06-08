defmodule Intel471Ex.Actors do
  @moduledoc """
  Functions for working with the Intel 471 Verity Actors API.

  Service path: `integrations/actors/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/actors/v1"

  @doc """
  Stream actors matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:actor` — Search for actor handles
    - `:forum` — Search for actors active on given forum
    - `:server_type` — Filter by server type (e.g., "telegram", "discord")
    - `:from` — Search data starting from given timestamp
    - `:until` — Search data ending before given timestamp
    - `:size` — Number of records per page
    - `:cursor` — Continue from cursor for pagination

  ## Examples

      {:ok, result} = Intel471Ex.Actors.stream(%{actor: "lazarus", size: 10})
  """
  @spec stream(map()) :: {:ok, map()} | {:error, any()}
  def stream(params \\ %{}) do
    Client.get("#{@service_path}/actors/stream", params)
  end
end