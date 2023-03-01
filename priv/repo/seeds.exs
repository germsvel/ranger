# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ranger.Repo.insert!(%Ranger.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Ranger.{Repo, User}

users = [
  %User{name: "Aragorn", email: "aragorn@ranger.com"},
  %User{name: "Gandalf", email: "gandalf@istari.com"},
  %User{name: "Frodo", email: "frodo@baggins.com"},
  %User{name: "Merry", email: "merry@brandybuck.com"},
  %User{name: "Pippin", email: "pippin@took.com"},
  %User{name: "Sam", email: "sam@gamgee.com"},
  %User{name: "Legolas", email: "legolas@woods.com"},
  %User{name: "Gimli", email: "gimli@gloinson.com"},
  %User{name: "Boromir", email: "boromir@minastirith.com"}
]

users |> Enum.each(&Repo.insert!/1)
