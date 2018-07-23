# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TAG_DATA = [
  {name: 'PYRAMID GARDEN'},
  {name: '場外', hex: '#ccae62'},
  {name: 'キャンプサイト'},
  {name: 'THE PALACE OF WONDER'},
  {name: 'OASIS', hex: '#c23616'},
  {name: 'BLUE GALAXY', hex: '#40739e'},
  {name: 'ところ天国', hex: '#4bcffa'},
  {name: 'NEW POWER GEAR Field', hex: '#6D214F'},
  {name: 'FIELD OF HEAVEN'},
  {name: 'ORANGE CAFE', hex: '#ffa801'},
  {name: 'STONED CIRCLE', hex: '#485460'},
  {name: '🍛カレー'},
  {name: '🍜麺'},
  {name: '🌶エスニック'},
  {name: '🍺'},
  {name: '🍖'},
  {name: '🐟'},
]

ActiveRecord::Base.transaction do
  tags = TAG_DATA.map do |attrs|
    tag = Tag.find_or_initialize_by(name: attrs[:name])
    tag.update!(attrs)
    tag
  end

  AREA_TAG_DATA = {
    'area01' => tags[0][:id],
    'area02' => tags[1][:id],
    'area03' => tags[2][:id],
    'area04' => tags[3][:id],
    'area05' => tags[4][:id],
    'area06' => tags[5][:id],
    'area07' => tags[6][:id],
    'area08' => tags[7][:id],
    'area09' => tags[8][:id],
    'area10' => tags[9][:id],
    'area11' => tags[10][:id],
  }

  Stand.all.each do |stand|
    tag_id = AREA_TAG_DATA[stand.area]
    stand.stand_tags.find_or_create_by(tag_id: tag_id)
  end
end
