class MainController < ApplicationController
  def index
    chat_history = File.read('yourfile.txt') if File.exist?('yourfile.txt')
    # Split on newlines and remove any leading/trailing whitespace
    @chat_history = chat_history.to_s.split("\n").map(&:strip)
  end

  def save
    content = params[:content]
    time = Time.now.strftime("%Y/%m/%d %H:%M")
    message = "[#{time}] #{content}"

    existing_history = File.exist?('yourfile.txt') ? File.read('yourfile.txt') : ''
    # Check if the existing history is empty before appending a newline
    new_history = existing_history.empty? ? message : "#{existing_history}\n#{message}"
    
    File.write('yourfile.txt', new_history)
    redirect_to main_index_path
  end

  def erase_history
    File.write('yourfile.txt', '') # Clears the chat history file
    redirect_to main_index_path, notice: "Chat history has been erased."
  end
end