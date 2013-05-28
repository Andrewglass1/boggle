class WordChecker

  def initialize
    words = {}
      File.open("/usr/share/dict/words") do |file|
        file.each do |line|
          words[line.strip] = true
        end
      end
    @words = words
  end

  def check(word)
    @words[word]
  end
end