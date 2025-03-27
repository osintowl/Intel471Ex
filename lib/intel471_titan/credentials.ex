defmodule Intel471Ex.Credentials do
  @moduledoc """
  Functions for working with credential-related endpoints in the Intel 471 Titan API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Search credential sets using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering credential sets
    - `:text` - Search text everywhere in credential sets
    - `:credentialSetName` - Search by credential set name
    - `:credentialSetUid` - Search by credential set uid
    - `:victim` - Search by purported victim
    - `:gir` - Search by General Intel Requirements
  """
  @spec search_credential_sets(map()) :: {:ok, map()} | {:error, any()}
  def search_credential_sets(params \\ %{}) do
    Client.request(:get, "/credentialSets", params)
  end
  
  @doc """
  Stream credential sets using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering credential sets
    - `:text` - Search text everywhere in credential sets
    - `:credentialSetName` - Search by credential set name
    - `:cursor` - Continue scrolling from cursor
    - `:victim` - Search by purported victim
    - `:gir` - Search by General Intel Requirements
  """
  @spec stream_credential_sets(map()) :: {:ok, map()} | {:error, any()}
  def stream_credential_sets(params \\ %{}) do
    Client.request(:get, "/credentialSets/stream", params)
  end
  
  @doc """
  Search credentials using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering credentials
    - `:text` - Search text everywhere in credentials
    - `:credentialUid` - Search by credential uid
    - `:credentialSetName` - Search by credential set name
    - `:credentialDomain` - Search by credential domain
    - `:passwordStrength` - Search by password strength
    - `:credentialLogin` - Search by credential login
  """
  @spec search_credentials(map()) :: {:ok, map()} | {:error, any()}
  def search_credentials(params \\ %{}) do
    Client.request(:get, "/credentials", params)
  end
  
  @doc """
  Search credential occurrences using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering credential occurrences
    - `:text` - Search text everywhere in credential occurrences
    - `:credentialOccurrenceUid` - Search by credential occurrence uid
    - `:credentialUid` - Search by credential uid
    - `:accessedUrl` - Search by accessed url
  """
  @spec search_credential_occurrences(map()) :: {:ok, map()} | {:error, any()}
  def search_credential_occurrences(params \\ %{}) do
    Client.request(:get, "/credentials/occurrences", params)
  end
  
  @doc """
  Stream credential occurrences using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering credential occurrences
    - `:text` - Search text everywhere in credential occurrences
    - `:credentialOccurrenceUid` - Search by credential occurrence uid
    - `:credentialUid` - Search by credential uid
    - `:accessedUrl` - Search by accessed url
    - `:cursor` - Continue scrolling from cursor
  """
  @spec stream_credential_occurrences(map()) :: {:ok, map()} | {:error, any()}
  def stream_credential_occurrences(params \\ %{}) do
    Client.request(:get, "/credentials/occurrences/stream", params)
  end
end

