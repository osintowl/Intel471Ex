defmodule Intel471Ex.Actors do
  @moduledoc """
  Functions for working with the Intel 471 Titan Actors API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Search actors using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering actors
    - `:actor` - Search for handles only
    - `:forum` - Search for actors active on given forum
    - `:from` - Search data starting from given creation time
    - `:until` - Search data ending before given creation time
    - `:lastUpdatedFrom` - Search data starting from given last updated time
    - `:lastUpdatedUntil` - Search data ending before given last updated time
    - `:sort` - Sort results (relevance, earliest, latest)
    - `:offset` - Skip leading number of records
    - `:count` - Returns given number of records
  
  ## Examples
  
      iex> Intel471Ex.Actors.search(%{actor: "synthx"})
      {:ok, %{"actorTotalCount" => 35, "actors" => [...]}}
  """
  @spec search(map()) :: {:ok, map()} | {:error, any()}
  def search(params \\ %{}) do
    Client.request(:get, "/actors", params)
  end
  
  @doc """
  Get a single actor by UID.
  
  ## Parameters
  
  - `uid`: The unique identifier of the actor
  
  ## Examples
  
      iex> Intel471Ex.Actors.get("e7fafbb8f44a6ded005c154976627da4")
      {:ok, %{...}}
  """
  @spec get(String.t()) :: {:ok, map()} | {:error, any()}
  def get(uid) do
    Client.request(:get, "/actors/#{uid}")
  end
end

