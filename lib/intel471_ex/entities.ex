defmodule Intel471Ex.Entities do
  @moduledoc """
  Functions for working with the Intel 471 Verity Entities API.

  Service path: `integrations/entities/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/entities/v1"

  @doc """
  Stream entities matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:entity` (required) — Entity search term (e.g., domain name)
    - `:type` — Filter by entity type
    - `:from` / `:until` — Time range
    - `:size` / `:cursor` — Pagination

  ## Examples

      {:ok, result} = Intel471Ex.Entities.stream(%{entity: "intel.com", size: 10})
  """
  @spec stream(map()) :: {:ok, map()} | {:error, any()}
  def stream(params \\ %{}) do
    Client.get("#{@service_path}/entities/stream", params)
  end
end