defmodule Ranger.Timeline do
  def posts(opts \\ []) do
    offset = Keyword.get(opts, :offset, 0)
    limit = Keyword.get(opts, :limit, 10)
    total = offset + limit - 1

    Enum.slice(all_posts(), offset..total)
  end

  def all_posts do
    [
      %{
        id: 13,
        author: "Frodo",
        text: "I will take the Ring, though I do not know the way."
      },
      %{
        id: 18,
        author: "Celeborn",
        text:
          "But do not despise the lore that has come down from distant years; for oft it may chance that old wives keep in memory word of things that once were needful for the wise to know."
      },
      %{
        id: 24,
        author: "Sam",
        text: "It's the job that's never started as takes longest to finish."
      },
      %{
        id: 29,
        author: "Eowyn",
        text:
          "But no living man am I! You are looking upon a woman. Eowyn am I, Eomund's daughter. You stand between me and my lord and kin. Begone, if you be not deathless! For living or dark undead, I will smite you, if you touch him."
      },
      %{
        id: 35,
        author: "Haldir",
        text:
          "The world is indeed full of peril, and in it there are many dark places; but still there is much that is fair, and though in all lands love is now mingled with grief, it grows perhaps the greater."
      },
      %{
        id: 41,
        author: "Frodo",
        text: "I wish the Ring had never come to me. I wish none of this had happened."
      },
      %{
        id: 46,
        author: "Merry",
        text:
          "But it is a greater honour to dangle at your tail, Gandalf. For one thing, in that position one has a chance of putting a question a second time. Are we riding far tonight?"
      },
      %{
        id: 52,
        author: "Pippin",
        text:
          "We hobbits ought to stick together, and we will. I shall go, unless they chain me up. There must be someone with intelligence in the party."
      },
      %{
        id: 58,
        author: "Gildor",
        text: "Courage is found in unlikely places."
      },
      %{
        id: 63,
        author: "Bilbo",
        text:
          "It's a dangerous business, Frodo, going out your door. You step onto the road, and if you don't keep your feet, there's no knowing where you might be swept off to."
      },
      %{
        id: 69,
        author: "Aragorn",
        text: "I can avoid being seen, if I wish, but to disappear entirely, that is a rare gift."
      },
      %{
        id: 74,
        author: "Gandalf",
        text: "He that breaks a thing to find out what it is, has left the path of wisdom."
      },
      %{
        id: 79,
        author: "Galadriel",
        text:
          "You may learn something, and whether what you see be fair or evil, that may be profitable, and yet it may not. Seeing is both good and perilous."
      },
      %{
        id: 85,
        author: "Elrond",
        text:
          "Yet such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the eyes of the great are elsewhere."
      },
      %{
        id: 91,
        author: "Aragorn",
        text:
          "His grief he will not forget; but it will not darken his heart, it will teach him wisdom."
      },
      %{
        id: 97,
        author: "Legolas",
        text:
          "In that hour I looked on Aragorn and thought how great and terrible a Lord he might have become in the strength of his will, had he taken the Ring to himself. Not for naught does Mordor fear him."
      },
      %{
        id: 103,
        author: "Aragorn",
        text: "A hunted man sometimes wearies of distrust and longs for friendship."
      },
      %{
        id: 108,
        author: "Gimli",
        text: "Faithless is he that says farewell when the road darkens."
      },
      %{
        id: 113,
        author: "Gandalf",
        text:
          "I am a servant of the Secret Fire, wielder of the flame of Anor. You cannot pass. The dark fire will not avail you, flame of Udûn. Go back to the Shadow! You cannot pass."
      },
      %{
        id: 119,
        author: "Boromir",
        text:
          "It is a strange fate that we should suffer so much fear and doubt over so small a thing. Such a little thing."
      },
      %{
        id: 125,
        author: "Bilbo",
        text:
          "I don't know half of you half as well as I should like, and I like less than half of you half as well as you deserve."
      },
      %{
        id: 131,
        author: "Aragorn",
        text: "Yet the deeds will not be less valiant because they are unpraised."
      },
      %{
        id: 136,
        author: "Legolas",
        text: "Oft hope is born when all is forlorn."
      },
      %{
        id: 141,
        author: "Gandalf",
        text:
          "A most unquenchable hobbit! All wizards should have a hobbit or two in their care—to teach them the meaning of the world, and to correct them."
      },
      %{
        id: 147,
        author: "Frodo",
        text: "It is useless to meet revenge with revenge: it will heal nothing."
      },
      %{
        id: 152,
        author: "Bilbo",
        text:
          "I am old, Gandalf. I don't look it, but I am beginning to feel it in my heart of hearts. Well-preserved indeed! Why, I feel all thin, sort of stretched, if you know what I mean: like butter that has been scraped over too much bread. That can't be right. I need a change, or something."
      },
      %{
        id: 158,
        author: "Sam",
        text:
          "Even darkness must pass. A new day will come. And when the sun shines it will shine out the clearer. Those were the stories that stayed with you, that meant something, even if you were too small to understand why."
      },
      %{
        id: 164,
        author: "Gandalf",
        text:
          "Do not be so quick to deal out death and judgment. Even the very wise do not see all ends."
      },
      %{
        id: 170,
        author: "Gollum",
        text: "My precious!"
      },
      %{
        id: 176,
        author: "Sam",
        text: "Potatoes! Boil 'em, mash 'em, stick 'em in a stew."
      }
    ]
  end
end
