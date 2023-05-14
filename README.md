# Welcome to Ranger 🎉

Ranger is the codebase that accompanies my [Testing LiveView] course.

## Getting set up

- Install Elixir and Erlang versions defined in [`.tool-versions`](./.tool-versions)
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
  - That will also add some seed data.
- Run `mix test` to make sure all tests pass.
  - It's okay if there are warnings.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit Ranger at [`localhost:4000`](http://localhost:4000).

## Test files

Each lesson is associated with a different LiveView. That makes each lesson
stand alone and allows us to focus on how to test a particular LiveView.

For each lesson, you should see two test files:

- A "standard" test file, and
- A "done" test file

The standard test file is the test file that corresponds to the LiveView we're
about to test.

For example, when we're considering testing `CounterLive`, which is located in
`lib/ranger_web/live/counter_live.ex`, you will see two tests:

- Standard test file: `test/ranger_web/live/counter_live_test.exs`,
- Done test file: `test/ranger_web/live/counter_live_done_test.exs`

As you can see, the only difference in filename is the "done" portion.

The first test (a.k.a "standard" test) is the blank canvas where we'll be adding
tests in the lesson.

The "done" test is a cheat sheet (which you should reference freely) with all
the tests already written.

If you're ever lost or want to double check how I wrote the final test, feel
free to reference the "done" test.

With that out of the way, let's get started!

## Resources

- [Testing LiveView course][Testing LiveView]
- [`Phoenix.LiveViewTest` docs](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveViewTest.html)

[Testing LiveView]: https://www.testingliveview.com/
