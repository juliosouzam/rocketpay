defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{file: file}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Rocketpay API. Here is you number #{file}"})
  end

  defp handle_response({:error, reson}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reson)
  end
end
