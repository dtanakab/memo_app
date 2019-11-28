# frozen_string_literal: true

require 'securerandom'

# read or write or remove txt file
class Memo
  attr_reader :file_name, :id, :contents

  def initialize(contents)
    @id = SecureRandom.urlsafe_base64
    @file_name = "memo_#{@id}.txt"
    update(contents)
  end

  def update(contents)
    File.open("memo/#{@file_name}", 'w') do |f|
      @contents = contents
      f.puts(contents)
    end
  end

  def read
    File.read("memo/#{@file_name}")
  end

  def delete
    FileUtils.rm("memo/#{@file_name}")
  end
end
