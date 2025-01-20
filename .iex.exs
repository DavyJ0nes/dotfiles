# ~/.iex.exs
# Configure IEx basic settings

# Common imports that you use frequently
import Enum, only: [map: 2, reduce: 3]
import String, only: [upcase: 1, downcase: 1]

# Set up aliases
# alias MyApp.Repo
# alias MyApp.User

# Configure shell appearance
Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  history_size: 100,
  width: 80,
  inspect: [
    limit: 5_000,
    pretty: true,
    width: 80
  ],
  colors: [
    syntax_colors: [
      number: :yellow,
      atom: :cyan,
      string: :green,
      boolean: :red,
      nil: :red
    ],
    eval_result: [:green, :bright],
    eval_error: [:red, :bright],
    eval_info: [:blue, :bright],
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline]
  ],
  default_prompt:
    "#{IO.ANSI.green()}%prefix#{IO.ANSI.reset()}" <>
      "(#{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}) >"
)

defmodule IExHelpers do
  def reload! do
    Mix.Task.reenable("compile.elixir")
    Application.stop(Mix.Project.config()[:app])
    Mix.Task.run("compile.elixir")
    Application.start(Mix.Project.config()[:app])
  end

  def list_app_modules(app) do
    case :application.get_key(app, :modules) do
      {:ok, modules} ->
        modules
        |> Enum.sort()
        |> IO.inspect(pretty: true)

      :undefined ->
        IO.puts("Application #{app} not found or has no modules")
    end
  end
end

# Import helper functions into IEx session scope
import IExHelpers
