defmodule RangerWeb.SettingsLive.EditableInputComponentDoneTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias RangerWeb.SettingsLive.EditableInputComponent

  test "renders field text" do
    user = %{name: "Frodo"}

    html = render_component(EditableInputComponent, id: "name", field: :name, user: user)

    assert html =~ "Frodo"
  end
end
