defmodule Intel471Ex.Girs do
  @moduledoc """
  Functions for working with the Intel 471 Verity GIRS (General Intel
  Requirements) API.

  Service path: `integrations/girs/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/girs/v1"

  @doc """
  Get the GIRS tree.

  Returns the full hierarchy of General Intel Requirements.

  ## Examples

      {:ok, tree} = Intel471Ex.Girs.tree()
  """
  @spec tree() :: {:ok, map()} | {:error, any()}
  def tree do
    Client.get("#{@service_path}/girs/tree")
  end
end