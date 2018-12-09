defmodule Envio.Store do
  @moduledoc """
  Provides a module for storing and retrieving data.
  """

  @valid_file_types [".png", ".jpg", ".jpeg"]

  @callback store_image(%{}) :: {:ok, [String.t()]} | {:error, any}

  @callback retrieve_image(%{}) :: {:ok, %{}} | {:error, any}

  def store do
    config(:store) || Envio.Store.Physical
  end

  def valid_file_extension(extension) do
    if Enum.member?(valid_file_types(), extension) do
      {:ok, "wow"}
    else
      {:error, "invalid file type"}
    end
  end

  def base_fname(name) do
    Path.basename(name)
  end

  defp valid_file_types do
    config(:valid_file_types) || @valid_file_types
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:envio, __MODULE__, [])[key]
  end
end
