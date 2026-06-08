defmodule Intel471Ex.Indicators do
  @moduledoc """
  Functions for working with the Intel 471 Verity Indicators API.

  Service path: `integrations/indicators/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/indicators/v1"

  @doc """
  Stream indicators matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:type` — Indicator type (e.g., "domain", "url", "ip")
    - `:threat_type` — Threat type
    - `:confidence` — Confidence level
    - `:text_filter` — Free text search
    - `:malware_id` — Filter by malware ID
    - `:malware_family_id` — Filter by malware family ID
    - `:malware_family_name` — Filter by malware family name
    - `:girs` — Filter by GIRs
    - `:from` / `:until` — Time range
    - `:size` / `:cursor` — Pagination

  ## Examples

      {:ok, result} = Intel471Ex.Indicators.stream(%{type: "domain", size: 10})
  """
  @spec stream(map()) :: {:ok, map()} | {:error, any()}
  def stream(params \\ %{}) do
    Client.get("#{@service_path}/indicators/stream", params)
  end

  @doc """
  Get an indicator by ID.

  ## Parameters

  - `id`: The indicator identifier

  ## Examples

      {:ok, indicator} = Intel471Ex.Indicators.get_by_id("indicator-id")
  """
  @spec get_by_id(String.t()) :: {:ok, map()} | {:error, any()}
  def get_by_id(id) do
    Client.get("#{@service_path}/indicators/#{id}")
  end
end