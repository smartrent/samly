defmodule Samly.SpDataStore.Process do
  @moduledoc """
  Reads service providers data from the process dictionary.

  This is useful in test environments, particularly if tests run asynchronously.

  This implementation only provides `init/1` and `get/1`.
  `delete/1` and `put/2` will return `:unsupported`.

  ## Usage

      config :samly, Samly.Provider,
        sp_data_store: MyApp.SpStore
  """

  @behaviour Samly.SpDataStore.Store

  @impl true
  def init(opts) do
    service_providers = Samly.SpData.load_providers(opts || [])

    Process.put(:samly_service_providers, service_providers)
  end

  @impl true
  def get(sp_id) do
    sps = Process.get(:samly_service_providers, %{})
    Map.get(sps, sp_id)
  end

  @impl true
  def put(_sp_id, _sp_data), do: :unsupported

  @impl true
  def delete(_sp_id), do: :unsupported
end
