require 'squib'
require 'game_icons'


if ARGV[0].nil?
  default = "Castle_Defense_Data-Hero-Characters.csv"
  output = "no argument given, using default, " + default + "\n"
  print output
  abilityData = Squib.csv file: default
else
  output = "using argument, " + ARGV[0] + "\n"
  print output
  abilityData = Squib.csv file: ARGV[0]
end

output = "indexing into Hero Card Name column of given csv\n"
print output
something = abilityData['Name']
output = "off of this index, number of cards is: "
print output
sizeOfSomething = something.size
output = sizeOfSomething
print output
output = "\n"
print output

#abilityData = Squib.csv file: 'Tactile_Tabletop_Data-Level_2_CC.csv'
#grabbing icons from https://game-icons.net/
#using gem game_icons to be able to load them

#width/height/dpi measurements provided by template from BoardGameMaker.com, see poker-size.pdf
Squib::Deck.new(dpi: 300, width: 750, height: 1050, cards: abilityData['Name'].size, layout: 'herocardabilitylayout.yml')  do

  ## overall card stuff

  background color: 'white'
  rect layout: 'cut'
  rect layout: 'safe'
  

  text str: abilityData['Name'], layout: 'ttitle'
  text str: abilityData['Rules'], layout: 'rrules'
  text str: "Cost:", layout: 'ccostTitle'
  text str: abilityData['Cost'], layout: 'ccost'
  text str: abilityData['Range'], layout: 'rrange'

  ## output file stuff

  save_png prefix: 'hero_ability_card_'
  #save_pdf trim: 37.5
end
