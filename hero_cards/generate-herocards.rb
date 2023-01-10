require 'squib'
require 'game_icons'


if ARGV[0].nil?
  output = "no argument given, using default, Castle_Defense_Data-Heros.csv\n"
  print output
  data = Squib.csv file: 'Castle_Defense_Data-Hero-Archer.csv'
  print output
else
  output = "using argument, " + ARGV[0] + "\n"
  print output
  data = Squib.csv file: ARGV[0]
end

output = "indexing into Hero Card Name column of given csv\n"
print output
something = data['Name']
output = "off of this index, number of cards is: "
print output
sizeOfSomething = something.size
output = sizeOfSomething
print output
output = "\n"
print output

#data = Squib.csv file: 'Tactile_Tabletop_Data-Level_2_CC.csv'
#grabbing icons from https://game-icons.net/
#using gem game_icons to be able to load them

#width/height/dpi measurements provided by template from BoardGameMaker.com, see poker-size.pdf
Squib::Deck.new(dpi: 300, width: 750, height: 1050, cards: data['Name'].size, layout: 'herocardlayout.yml')  do

  ## overall card stuff

  background color: 'white'
  rect layout: 'cut'
  rect layout: 'safe'
  

  text str: data['Name'], layout: 'ttitle'
  text str: data['Rules'], layout: 'rrules'
  text str: "Cost:", layout: 'ccostTitle'
  text str: data['Cost'], layout: 'ccost'
  text str: data['Range'], layout: 'rrange'

  ## output file stuff

  save_png prefix: 'archer_card_'
  #save_pdf trim: 37.5
end

# Squib::Deck.new(dpi: 300, width: 750, height: 1050, cards: 1, layout: 'consumablecardlayout.yml')  do

  # ## overall card stuff

  # background color: 'white'
  # rect layout: 'cut'
  # rect layout: 'backOfCards'
  # svg data: GameIcons.get('rolling-dices').recolor(fg: 'fff', bg: '000', fg_opacity: 1, bg_opacity: 0).string, layout: 'diceBack'
  # svg data: GameIcons.get('card-random').recolor(fg: 'fff', bg: '000', fg_opacity: 1, bg_opacity: 0).string, layout: 'cardBack'
  # svg data: GameIcons.get('two-coins').recolor(fg: 'fff', bg: '000', fg_opacity: 1, bg_opacity: 0).string, layout: 'tokensBack'
  # ## output file stuff

  # save_png prefix: 'ttcc_BACK'
  # #save_pdf trim: 37.5
# end