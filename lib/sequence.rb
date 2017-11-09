class Sequence
  attr_accessor :value

  extend Forwardable

  def_delegator :value, :to_s

  def initialize(value)
    @value = value
  end

  def next
    next_value = transcription_of_number

    self.class.new(next_value)
  end

  private

  def transcription_of_number
    result = []
    temp = []
    counter = 1
    array_of_chars = to_s.chars

    array_of_chars.each_with_index do |item, index|
      break result_picker(result, array_of_chars, 1) if array_of_chars.size == 1

      next temp << item if temp.empty?

      break generate_last_number(item, result, temp, counter) if (array_of_chars.size - 1) == index

      next counter += 1 if temp.last == item

      result_picker(result, temp, counter)
      temp = [item]
      counter = 1
    end

    result.join
  end

  def result_picker(result, temp, counter)
    result << temp.push(counter).reverse.join
  end

  def generate_last_number(item, result, temp, counter)
    if temp.last == item
      counter += 1
      result_picker(result, temp, counter)
    else
      result_picker(result, temp, counter)

      result_picker(result, [item], 1)
    end
  end
end
