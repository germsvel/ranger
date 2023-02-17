defmodule Ranger.FellowshipMember do
  defstruct [:name, :type, :description]

  def new(name, type, description) do
    %__MODULE__{
      name: name,
      type: type,
      description: description
    }
  end
end
