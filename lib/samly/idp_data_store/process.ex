defmodule Samly.IdpDataStore.Process do
  @moduledoc """
  Reads identity providers data from the process dictionary.

  This is useful in test environments, particularly if tests run asynchronously.

  This implementation only provides `init/1` and `get/1`.
  `delete/1` and `put/2` will return `:unsupported`.

  ## Usage

      config :samly, Samly.Provider,
        idp_data_store: MyApp.IdpStore
  """

  @behaviour Samly.IdpDataStore.Store

  @impl true
  def init(opts) do
    identity_providers = Samly.IdpData.load_providers(opts || [])

    Process.put(:samly_identity_providers, identity_providers)
  end

  @impl true
  def get(idp_id) do
    idps = Process.get(:samly, %{})
    Map.get(idps, idp_id)
  end

  @impl true
  def put(_idp_id, _idp_data), do: :unsupported

  @impl true
  def delete(_idp_id), do: :unsupported
end
