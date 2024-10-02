defmodule Chatbot do
  @config %OpenAI.Config{api_key: ""}

  def start(_type, _args) do
    # Initialize messages with the system message from "personality.txt"
    personality = File.read!("./lib/personality.txt")
    system_message = %{role: "system", content: personality}
    messages = [system_message]
    loop(messages)
  end

  defp loop(messages) do
    # Get input from the user
    IO.write("🦄 Me: ")
    user_input = IO.gets("") |> String.trim()

    # Create a message from the user input
    user_message = %{role: "user", content: user_input}
    messages = messages ++ [user_message]

    # Get a reply from the AI
    {:ok, completion} =
      OpenAI.chat_completion(
        # TODO - fill this in
      )

    %{choices: [%{"message" => assistant_message}]} = completion

    # Save the assistant message
    messages = messages ++ [assistant_message]

    # Print the AI's reply
    IO.puts("🤖 Bob: #{assistant_message["content"]}")

    # Log how many tokens we used
    %{usage: usage} = completion
    IO.inspect(usage)

    loop(messages)
  end
end
