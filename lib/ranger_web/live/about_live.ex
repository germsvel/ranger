defmodule RangerWeb.AboutLive do
  use RangerWeb, :live_view

  import RangerWeb.AboutComponents

  alias Ranger.FellowshipMember

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 gap-4 space-x-2">
      <%= for  member <- @members do %>
        <.card>
          <:title>
            <span class="text-lg font-bold"><%= member.name %></span>
            <.badge type={member.type} />
          </:title>

          <div>
            <%= member.description %>
          </div>
        </.card>
      <% end %>
    </div>
    """
  end

  def mount(_, _, socket) do
    members = fellowship_characters()

    {:ok, assign(socket, members: members)}
  end

  defp fellowship_characters do
    [
      FellowshipMember.new(
        "Frodo",
        "hobbit",
        "The main protagonist of The Lord of the Rings, a Hobbit of exceptional character. Frodo is also a friend of the Elves, knowledgeable in their language and a lover of their songs. Like Bilbo—or any other good Hobbit—Frodo loves good food and simple comforts, but he is also thoughtful and curious and has a wisdom and strength of character that set him apart."
      ),
      FellowshipMember.new(
        "Sam",
        "hobbit",
        "The former gardener at Bag End and Frodo’s indomitable servant throughout his quest. Although Sam is not extraordinarily wise or intelligent, his common sense and powers of observation serve him well. Perhaps most important, he is stubborn, brave, and deeply loyal to Frodo."
      ),
      FellowshipMember.new(
        "Merry",
        "hobbit",
        "A young Hobbit from Buckland. Merry has a temperament similar to Pippin’s, though he is more mature and, unlike most Hobbits, not afraid of boats and water."
      ),
      FellowshipMember.new(
        "Pippin",
        "hobbit",
        "A young and somewhat rash Hobbit. Pippin is good-natured and a bit of a smart aleck."
      ),
      FellowshipMember.new(
        "Aragorn",
        "human",
        "The heir of Isildur, one of the few Men from the great race of Númenor left in Middle-earth. Aragorn is also known as Strider. Before the coming of the Ring, he lived as a Ranger in the North, protecting the Shire and other lands from servants of the Enemy. Aragorn is a formidable warrior and tracker"
      ),
      FellowshipMember.new(
        "Legolas",
        "elf",
        "An Elf from Mirkwood. Legolas is light on his feet and masterful with a bow. After overcoming initial differences that stem from the historical antipathy between their races, he and the Dwarf Gimli become fast friends"
      ),
      FellowshipMember.new(
        "Gimli",
        "dwarf",
        "A Dwarf, the son of Glóin (one of Bilbo’s company in The Hobbit). Gimli bristles when he feels insulted, but he is noble, stalwart, and brave."
      ),
      FellowshipMember.new(
        "Gandalf",
        "wizard",
        "One of the five great Wizards in Middle-earth, second in his order only to Saruman. Known to most Hobbits only as a creator of fine fireworks, Gandalf is actually powerful beyond their imagination. He is also wise, humorous, kind, and generous, though sometimes short-tempered."
      ),
      FellowshipMember.new(
        "Boromir",
        "human",
        "One of the Men of Gondor, from the city of Minas Tirith in the south. Boromir is a valiant fighter and is always trustworthy in battle, but his pride and recklessness make him vulnerable to the Ring’s power."
      )
    ]
  end
end
