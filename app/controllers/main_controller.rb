class MainController < ApplicationController
  # Initialize an empty array to store chat messages as a class variable.
  cattr_accessor :chat_history
  self.chat_history = []

  def index
    # Read chat history from the file and store it in memory.
    self.chat_history = read_chat_history
    @chat_history = self.chat_history
  end

  def save
    content = params[:content]
    time = Time.now.strftime("%Y/%m/%d %H:%M")
  
    messages = content.split("\n").map(&:strip)
  
    messages.each do |message|
      self.chat_history << "[#{time}] #{message}"
    end
  
    write_chat_history(self.chat_history)
  
    redirect_to main_index_path
  end
  

  def erase_history
    # Clear the chat history in memory and save an empty array to the file.
    self.chat_history = []
    write_chat_history([])

    redirect_to main_index_path, notice: "Chat history has been erased."
  end

  private

  def read_chat_history
    if File.exist?('yourfile.txt')
      File.read('yourfile.txt').split("\n").map(&:strip)
    else
      []
    end
  end

  def write_chat_history(messages)
    File.write('yourfile.txt', messages.join("\n"))
  end
end
