defmodule Intel471Ex.Downloader do
  @moduledoc """
  File downloader for Intel 471 Titan API using Req.
  """

  @doc """
  Downloads a file from Intel 471 Titan API.
  
  ## Parameters
  
  - `url`: Full URL to the file (e.g., "https://api.intel471.com/v1/dataleak/download/archives/interlock/25154/structure.zip")
  - `destination`: Local path where the file should be saved
  - `params`: Query parameters (optional)
  - `config`: Optional configuration override
  
  ## Returns
  
  - `{:ok, path}` - Successful download with path to saved file
  - `{:error, reason}` - Error with reason
  """
  @spec download_file(String.t(), String.t(), map(), map() | nil) ::
    {:ok, String.t()} | {:error, any()}
  def download_file(url, destination, params \\ %{}, config \\ nil) do
    config = config || Intel471Ex.config()
    
    # Add version parameter if specified
    params = if config.api_version do
      Map.put(params, :v, config.api_version)
    else
      params
    end
    
    # Create request with binary response format and FIXED auth format
    req = Req.new(
      method: :get,
      url: url,
      params: params,
      # Fix: Pass username and password as tuple directly, not nested in :basic
      auth: {config.username, config.api_key},
      # Request binary response instead of JSON
      decode_body: false
    )
    
    # Execute request and handle response
    case Req.request(req) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 300 ->
        # Ensure the directory exists
        destination |> Path.dirname() |> File.mkdir_p!()
        
        # Write the file
        case File.write(destination, body) do
          :ok -> {:ok, destination}
          {:error, reason} -> {:error, %{message: "Failed to write file", reason: reason}}
        end
        
      {:ok, %{status: status, body: body}} ->
        error_message = extract_error_message(body) || "Download failed with status code #{status}"
        {:error, %{status: status, message: error_message}}
        
      {:error, exception} ->
        {:error, exception}
    end
  end

  @doc """
  Downloads a file from Intel 471 Titan API and automatically extracts the filename from the URL.
  
  ## Parameters
  
  - `url`: Full URL to the file
  - `destination_dir`: Directory where the file should be saved (default: "downloads")
  - `params`: Query parameters (optional)
  - `config`: Optional configuration override
  
  ## Returns
  
  - `{:ok, path}` - Successful download with path to saved file
  - `{:error, reason}` - Error with reason
  """
  @spec download_file_auto(String.t(), String.t(), map(), map() | nil) ::
    {:ok, String.t()} | {:error, any()}
  def download_file_auto(url, destination_dir \\ "downloads", params \\ %{}, config \\ nil) do
    filename = url |> URI.parse() |> Map.get(:path) |> Path.basename()
    destination = Path.join(destination_dir, filename)
    
    download_file(url, destination, params, config)
  end

  defp extract_error_message(%{"message" => message}) when is_binary(message), do: message
  defp extract_error_message(%{message: message}) when is_binary(message), do: message
  defp extract_error_message(_), do: nil
end
