defmodule Intel471Ex.Observables do
  @moduledoc """
  Functions for working with the Intel 471 Verity Observables API.

  Service path: `integrations/observables/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/observables/v1"

  @doc """
  Stream observables matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:observable` (required) — Observable search term (e.g., IP address, domain)
    - `:type` — Observable type
    - `:from` / `:until` — Time range
    - `:size` / `:cursor` — Pagination

  ## Examples

      {:ok, result} = Intel471Ex.Observables.stream(%{observable: "8.8.8.8", size: 10})
  """
  @spec stream(map()) :: {:ok, map()} | {:error, any()}
  def stream(params \\ %{}) do
    Client.get("#{@service_path}/observables/stream", params)
  end
end