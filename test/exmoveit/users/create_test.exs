defmodule Exmoveit.Users.CreateTest do
  @moduledoc false
  use Exmoveit.DataCase, async: true

  import Exmoveit.Factory

  alias Exmoveit.{Error, User}

  describe "call/1" do
    test "When all params are valid, creates the user" do
      params = build(:user_params)

      response = Exmoveit.create_user(params)

      assert {:ok, %User{id: _id, name: "Jp", email: "jp@banana.com", image: "src/banana"}} =
               response
    end

    test "When there the email already registered, returns an error" do
      :user_params
      |> build()
      |> Exmoveit.create_user()

      response =
        :user_params
        |> build()
        |> Exmoveit.create_user()

      assert {:error, %Error{}} = response
    end
  end
end
