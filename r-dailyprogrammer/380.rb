Dict = {
  "a" => ".-", "b" => "-...", "c" => "-.-.", "d" => "-..", "e" => ".",
  "f" => "..-.", "g" => "--.","h" => "....", "i" => "..", "j" => ".---",
  "k" => "-.-", "l" => ".-..", "m" => "--", "n" => "-.", "o" => "---",
  "p" => ".--.", "q" => "--.-", "r" => ".-.", "s" => "...", "t" => "-",
  "u" => "..-", "v" => "...-", "w" => ".--", "x" => "-..-", "y" => "-.--",
  "z" => "--..",
}

def smorse(word)
  word.chars.map {|letter| Dict[letter]}.join
end

def smalpha(sequence)
  lens = Dict.reduce([]) {|acc, (k, v)|
    acc[v.length] = {} unless acc[v.length]
    acc[v.length].update(k => v)
    acc
  }
  lens = lens.reverse
end

def match(pattern, str)
  pattern.split("").each_with_index {|c, i| return false if c != str[i] }
  true
end

class Trie
  class Node
    Dot = 0
    Dash = 1

    def convert(morseChar); morseChar == "." ? Dot : Dash; end
    
    def initialize(code, letter)
      if code.length == 0
        @letter = letter
      else
        @children = [nil, nil] unless @children
        c = convert(code[0])
        @children[c] = Node.new unless @children[c]
        @children[c].initialize(code[1, code.length - 1], letter)
      end
    end
  end
end
