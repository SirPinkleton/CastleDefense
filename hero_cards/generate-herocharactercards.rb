require 'squib'
require 'game_icons'


if ARGV[0].nil?
  default = "Castle_Defense_Data-Hero-Characters.csv"
  output = "no argument given, using default, " + default + "\n"
  print output
  characterData = Squib.csv file: default
else
  output = "using argument, " + ARGV[0] + "\n"
  print output
  characterData = Squib.csv file: ARGV[0]
end

output = "indexing into Hero Card Name column of given csv\n"
print output
something = characterData['Name']
output = "off of this index, number of cards is: "
print output
sizeOfSomething = something.size
output = sizeOfSomething
print output
output = "\n"
print output

#characterData = Squib.csv file: 'Tactile_Tabletop_Data-Level_2_CC.csv'
#grabbing icons from https://game-icons.net/
#using gem game_icons to be able to load them

#width/height/dpi measurements provided by template from BoardGameMaker.com, see poker-size.pdf
Squib::Deck.new(dpi: 300, width: 750, height: 1050, cards: characterData['Name'].size, layout: 'herocardcharacterlayout.yml')  do

  ## overall card stuff

  background color: 'white'
  rect layout: 'cut'
  rect layout: 'safe'
  

  text str: characterData['Name'], layout: 'title'
  text str: characterData['Health'], layout: 'health'
  png file: characterData['image'].map {|t| "#{t.downcase}.png" }, layout: 'characterImage'

  ## output file stuff

  save_png prefix: 'hero_ability_card_'
  #save_pdf trim: 37.5
end
