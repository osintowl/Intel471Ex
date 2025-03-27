defmodule Intel471Ex.Client do
  @moduledoc """
  HTTP Client for Intel 471 Titan API using Req.
  """

  @doc """
  Makes an API request to Intel 471 Titan API.
  
  ## Parameters
  
  - `method`: HTTP method (:get, :post, :put, :delete)
  - `path`: API endpoint path
  - `params`: Query parameters (optional)
  - `body`: Request body for POST/PUT requests (optional)
  - `config`: Optional configuration override
  
  ## Returns
  
  - `{:ok, response}` - Successful response with parsed JSON
  - `{:error, reason}` - Error with reason
  """
  @spec request(atom(), String.t(), map(), map() | nil, map() | nil) ::
    {:ok, map()} | {:error, map() | any()}
  def request(method, path, params \\ %{}, body \\ nil, config \\ nil) do
    config = config || Intel471Ex.config()
    
    # Add version parameter if specified
    params = if config.api_version do
      Map.put(params, :v, config.api_version)
    else
      params
    end

    # Build request
    url = "#{config.api_url}#{path}"
    
    req = Req.new(
      method: method,
      url: url,
      auth: {:basic, "#{config.username}:#{config.api_key}"},
      params: params,
      json: body
    )

    # Execute request and handle response
    case Req.request(req) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 300 ->
        {:ok, body}
      {:ok, %{status: status, body: body}} ->
        error_message = extract_error_message(body) || "Request failed with status code #{status}"
        {:error, %{status: status, message: error_message, body: body}}
      {:error, exception} ->
        {:error, exception}
    end
  end

  defp extract_error_message(%{"message" => message}) when is_binary(message), do: message
  defp extract_error_message(%{message: message}) when is_binary(message), do: message
  defp extract_error_message(_), do: nil
end
