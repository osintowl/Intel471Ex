defmodule Intel471Ex.Search do
  @moduledoc """
  Functions for performing global search across multiple data types in the Intel 471 Titan API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Perform a global search across multiple data types.
  
  ## Parameters
  
  - `params`: A map of query parameters for the search
    - `:text` - Search text everywhere
    - `:ipAddress` - IP address search
    - `:url` - URL search
    - `:contactInfoEmail` - E-mail address search
    - `:post` - Forum post search
    - `:privateMessage` - Forum private message search
    - `:actor` - Actor search
    - `:entity` - Entity search
    - `:entityType` - Search by entity type
    - `:victim` - Purported victim search
    - Many other parameters - see the API docs
  
  ## Examples
  
      iex> Intel471Ex.Search.search(%{text: "ransomware"})
      {:ok, %{
        "actorTotalCount" => 41,
        "reportTotalCount" => 35,
        "actors" => [...],
        "reports" => [...]
      }}
  """
  @spec search(map()) :: {:ok, map()} | {:error, any()}
  def search(params \\ %{}) do
    Client.request(:get, "/search", params)
  end
end

