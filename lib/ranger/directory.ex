defmodule Ranger.Directory do
  def all_members do
    [
      %{
        id: 1,
        name: "Frodo",
        type: "hobbit",
        description:
          "The main protagonist of The Lord of the Rings, a Hobbit of exceptional character. Frodo is also a friend of the Elves, knowledgeable in their language and a lover of their songs. Like Bilbo—or any other good Hobbit—Frodo loves good food and simple comforts, but he is also thoughtful and curious and has a wisdom and strength of character that set him apart.",
        title: "Elf friend",
        image_url:
          "http://images1.fanpop.com/images/photos/2600000/frodo-frodo-2650707-380-416.jpg"
      },
      %{
        id: 2,
        name: "Sam",
        type: "hobbit",
        description:
          "The former gardener at Bag End and Frodo’s indomitable servant throughout his quest. Although Sam is not extraordinarily wise or intelligent, his common sense and powers of observation serve him well. Perhaps most important, he is stubborn, brave, and deeply loyal to Frodo.",
        title: "Samwise the brave",
        image_url:
          "http://images6.fanpop.com/image/polls/1361000/1361010_1396802033513_full.png?v=1396802314"
      },
      %{
        id: 3,
        name: "Merry",
        type: "hobbit",
        description:
          "A young Hobbit from Buckland. Merry has a temperament similar to Pippin’s, though he is more mature and, unlike most Hobbits, not afraid of boats and water.",
        title: "Pippin's friend",
        image_url:
          "http://images2.fanpop.com/images/polls/188000/188267_1234830717063_full.jpg?v=1234830744"
      },
      %{
        id: 4,
        name: "Pippin",
        type: "hobbit",
        description:
          "A young and somewhat rash Hobbit. Pippin is good-natured and a bit of a smart aleck.",
        title: "Merry's friend",
        image_url:
          "http://images4.fanpop.com/image/polls/736000/736424_1307151571130_full.jpg?v=1307151580"
      },
      %{
        id: 5,
        name: "Aragorn",
        type: "human",
        description:
          "The heir of Isildur, one of the few Men from the great race of Númenor left in Middle-earth. Aragorn is also known as Strider. Before the coming of the Ring, he lived as a Ranger in the North, protecting the Shire and other lands from servants of the Enemy. Aragorn is a formidable warrior and tracker",
        title: "Dunadan",
        image_url:
          "https://images2.fanpop.com/images/photos/7600000/King-Aragorn-aragorn-7652236-800-779.jpg"
      },
      %{
        id: 6,
        name: "Legolas",
        type: "elf",
        description:
          "An Elf from Mirkwood. Legolas is light on his feet and masterful with a bow. After overcoming initial differences that stem from the historical antipathy between their races, he and the Dwarf Gimli become fast friends",
        title: "Greenleaf",
        image_url:
          "https://images2.fanpop.com/image/photos/12500000/Legolas-legolas-greenleaf-12509602-342-403.jpg"
      },
      %{
        id: 7,
        name: "Gimli",
        type: "dwarf",
        description:
          "A Dwarf, the son of Glóin (one of Bilbo’s company in The Hobbit). Gimli bristles when he feels insulted, but he is noble, stalwart, and brave.",
        title: "Gloin son",
        image_url:
          "http://images2.fanpop.com/images/polls/221000/221030_1239748330714_full.jpg?v=1239748844"
      },
      %{
        id: 8,
        name: "Gandalf",
        type: "wizard",
        description:
          "One of the five great Wizards in Middle-earth, second in his order only to Saruman. Known to most Hobbits only as a creator of fine fireworks, Gandalf is actually powerful beyond their imagination. He is also wise, humorous, kind, and generous, though sometimes short-tempered.",
        title: "Grey pilgrim",
        image_url:
          "http://images6.fanpop.com/image/polls/1237000/1237067_1372097155674_full.jpg?v=1372097217"
      },
      %{
        id: 9,
        name: "Boromir",
        type: "human",
        description:
          "One of the Men of Gondor, from the city of Minas Tirith in the south. Boromir is a valiant fighter and is always trustworthy in battle, but his pride and recklessness make him vulnerable to the Ring’s power.",
        title: "Man of Gondor",
        image_url:
          "https://images2.fanpop.com/images/photos/5500000/Boromir-boromir-5599646-516-540.jpg"
      }
    ]
  end

  def get_by(name: name) do
    Enum.find(all_members(), &(&1.name == name))
  end

  def get_by(id: id) do
    Enum.find(all_members(), &(&1.id == id))
  end
end
