class MainController < ApplicationController
  # Initialize an empty array to store chat messages as a class variable.
  cattr_accessor :chat_history
  self.chat_history = ''

  def index
    # Read chat history from the file and store it in memory.
    @chat_history = read_chat_history
  end

  def save
    content = params[:content]
    time = Time.now.strftime("%Y/%m/%d %H:%M")

    self.chat_history += "[#{time}] #{content}\n"

    write_chat_history(self.chat_history)

    redirect_to main_index_path
  end

  def erase_history
    # Clear the chat history in memory and save an empty string to the file.
    self.chat_history = ''
    write_chat_history('')

    redirect_to main_index_path, notice: "Chat history has been erased."
  end

  private

  def read_chat_history
    if File.exist?('yourfile.txt')
      File.read('yourfile.txt')
    else
      ''
    end
  end

  def write_chat_history(content)
    File.write('yourfile.txt', content)
  end
end
