defmodule Envio.Store.Physical do
  alias Envio.Store

  import Store, only: [base_fname: 1, valid_file_extension: 1]
  
  @behaviour Store

  @store_source "./images/"

  @impl Store
  def store_image(image, fname \\ nil) do
    fname = fname || image.filename
    ext = Path.extname(image.filename)

    with {:ok, _} <- valid_file_extension(ext),
      true <- get_images(fname) == []
      do
        img = download_image(image.url)

        write_name = "#{base_fname(fname)}#{ext}"
        File.write!(Path.join(store_source(), write_name), img)

        {:ok, "wow"}
      else
        {:error, message} ->
          {:error, message}
        false ->
          {:error, "there's a file already named that"}
    end
  end

  @impl Store
  def retrieve_image(name) do
    images = get_images(name)

    if length(images) > 0 do
      img = List.first(images)
      {:ok, img}
    else
      {:error, "file not found"}
    end
  end

  @impl Store
  def image_list do
    Enum.map(get_images(), fn path -> base_fname(path) end)
  end

  def create_store do
    if not File.exists?(@store_source) do
      File.mkdir(@store_source)
    end
  end

  defp download_image(url) do
    Application.ensure_all_started :inets

    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    body
  end

  defp get_images(name \\ "*") do
    s_fname = base_fname(name)

    @store_source
    |> Path.join("#{s_fname}.{png,jpeg,jpg}")
    |> Path.absname()
    |> Path.wildcard()
  end

  defp store_source do
    @store_source
  end
end
