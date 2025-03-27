defmodule Intel471Ex do
  @moduledoc """
  Client library for Intel 471's Titan API.
  
  This library provides functions to interact with the Titan API for gathering cyber threat intelligence.
  Configuration is handled via system environment variables.
  """

  @doc """
  Retrieves the configuration from environment variables.
  
  ## Environment Variables
  
  - `INTEL471_USERNAME`: Your email address used for authentication
  - `INTEL471_API_KEY`: Your API key
  - `INTEL471_API_VERSION`: Optional API version
  - `INTEL471_API_URL`: Optional custom API URL
  
  ## Returns
  
  A map containing the configuration values.
  
  ## Examples
  
      iex> System.put_env("INTEL471_USERNAME", "user@example.com")
      iex> System.put_env("INTEL471_API_KEY", "secret")
      iex> config = Intel471Ex.config()
      iex> config.username
      "user@example.com"
  """
  def config do
    %{
      username: get_env("INTEL471_USERNAME"),
      api_key: get_env("INTEL471_API_KEY"),
      api_version: System.get_env("INTEL471_API_VERSION"),
      api_url: System.get_env("INTEL471_API_URL", "https://api.intel471.com/v1")
    }
  end

  defp get_env(name) do
    case System.get_env(name) do
      nil -> raise "Environment variable #{name} is not set"
      value -> value
    end
  end
end
