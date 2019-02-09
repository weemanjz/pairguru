class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    return if BracketChecker.new(record.title).valid?

    record.errors["title"] << "is invalid"
  end

  class BracketChecker
    BRACKET_PAIRS = {
      "}" => "{",
      ")" => "(",
      "]" => "["
    }.freeze

    def initialize(str)
      @str = str
      @stack = []
      @empty = false
    end

    def valid?
      str.each_char do |c|
        return false if invalid_close_bracket?(c)
        if open_bracket?(c)
          stack << c
          @empty = true
        else
          @empty = false
        end
      end

      stack.empty? # it is valid when stack is empty, because all brackets are closed
    end

    private

    attr_reader :str, :empty, :stack

    # is invalid when it is empty or does not match to last open bracket
    def invalid_close_bracket?(chr)
      close_bracket?(chr) && (empty || stack.pop != BRACKET_PAIRS[chr])
    end

    def open_bracket?(chr)
      BRACKET_PAIRS.values.include?(chr)
    end

    def close_bracket?(chr)
      BRACKET_PAIRS.keys.include?(chr)
    end
  end
end
