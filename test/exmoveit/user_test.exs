defmodule Exmoveit.UserTest do
  @moduledoc """
    false
  """
  use Exmoveit.DataCase

  import Exmoveit.Factory

  alias Ecto.Changeset

  alias Exmoveit.User

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 image: "src/banana",
                 name: "Jp",
                 email: "jp@banana.com"
               },
               valid?: true
             } = response
    end

    test "When there are invalid params, returns an error" do
      params = %{name: "Jp", email: "jp@banana.com"}

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 name: "Jp",
                 email: "jp@banana.com"
               },
               errors: [image: {"can't be blank", [validation: :required]}],
               valid?: false
             } = response
    end
  end
end
