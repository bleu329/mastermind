#RED    0
#BLUE   1
#GREEN  2
#YELLOW 3
#ORANGE 4
#PURPLE 5

def random_colors
  solution = []
  4.times do
    solution << rand(6)
  end
  solution
end

def validate guess
  valid_guesses = %w(B R G Y O P)
  if guess.length != 4
    false
  else
    i = 0
    while i < guess.length
      if !valid_guesses.include? guess[i]
        return false
      end
      i += 1
    end
    true
  end
end

def get_guess
  loop do
    print "make a guess: "
    guess = gets.chomp
    if !validate guess
      puts "that is not a valid guess.  try again."
    else
      return guess
    end
  end
end

def convert_to_i guess
  guess_array = []
  conversions = {'R' => 0, 'B' => 1, 'G' => 2, 'Y' => 3, 'O' => 4, 'P' => 5}
  i = 0
  while i < 4
    guess_array << conversions[guess[i]]
    i += 1
  end
  guess_array
end

def convert_to_s guess
  guess_string = ""
  conversions = {0 => 'R', 1 => 'B', 2 => 'G', 3 => 'Y', 4 => 'O', 5 => 'P'}
  i = 0
  while i < 4
    guess_string << conversions[guess[i]]
    i += 1
  end
  guess_string
end

def check guess, solution
  correct_locations = 0
  correct_colors = 0
  correct = false, false, false, false
  i = 0
  while i < 4
    if guess[i] == solution[i]
      correct[i] = true
      correct_locations += 1
    end
    i += 1
  end
  i = 0
  colors = false, false, false, false
  while i < 4
    if !correct[i]
      j = 0
      while j < 4
        if j != i && !correct[j] && guess[j] == solution[i] && colors[j] == false
          correct_colors += 1
          colors[j] = true
          j = 4
        end
        j += 1
      end
    end
    i += 1
  end
  [correct_locations, correct_colors]
end

puts "---rules---"
puts "color choices: Blue, Yellow, Red, Orange, Purple, Green"
puts "guess 4 colors using the capital letter of each color(ex. BYRO)"
puts "you will get a result (ex [2, 1])"
puts "the first number is the number of colors you have in the right position"
puts "the second number is the number of other colors you have correct, but in the wrong positon"
puts "there can be multiple colors in the same solution (ex BBRR)"
puts "-----------"
solution = random_colors
turn = 1
puts "The computer has made his selection.  Start guessing"

while turn <= 12
  puts "---turn #{turn} ---"
  guess = convert_to_i get_guess
  result = check guess, solution
  if result[0] == 4
    puts "You got everything correct! You win"
    turn = 15
  else
    print result; puts
  end
  turn += 1
  if turn == 13
    print "Sorry you didn't get it.  Here is the correct solution: "
    solution = convert_to_s solution
    print solution; puts
  end
end
