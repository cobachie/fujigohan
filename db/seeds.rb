# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TAG_DATA = [
  {name: 'PYRAMID GARDEN', hex: '#ff6b6b'},
  {name: '場外', hex: '#009432'},
  {name: 'キャンプサイト', hex: '#16a085'},
  {name: 'THE PALACE OF WONDER', hex: '#663399'},
  {name: 'OASIS', hex: '#d63031'},
  {name: 'BLUE GALAXY', hex: '#192a56'},
  {name: 'ところ天国', hex: '#0097e6'},
  {name: 'NEW POWER GEAR Field', hex: '#6D214F'},
  {name: 'FIELD OF HEAVEN', hex: '#00d8d6'},
  {name: 'ORANGE CAFE', hex: '#e67e22'},
  {name: 'STONED CIRCLE', hex: '#485460'},
  {name: 'カレー'},
  {name: '麺'},
  {name: 'エスニック'},
  {name: 'Beer'},
  {name: '肉'},
  {name: '魚'},
  {name: 'Coffee️'},
  {name: 'バーガー'},
  {name: '和食'},
  {name: 'ベジタリアン'},
  {name: '定番'},
  {name: 'New'},
  {name: 'ピザ'},
  {name: 'スイーツ'},
  {name: 'SAKE/WINE/Cocktail'},
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

  category_tags = {
    curry:    tags[11].id,
    noodle:   tags[12].id,
    ethnic:   tags[13].id,
    beer:     tags[14].id,
    niku:     tags[15].id,
    fish:     tags[16].id,
    coffee:   tags[17].id,
    hamburger: tags[18].id,
    washoku:  tags[19].id,
    vege:     tags[20].id,
    standard: tags[21].id,
    new:      tags[22].id,
    piza:     tags[23].id,
    sweets:   tags[24].id,
    sake:     tags[25].id,
  }

  STAND_DATA = {
    "ピラミスカフェ" => [:curry],
    "Pyramid COFFEE STAND" => [:coffee],
    "PYRAMID SIDE BAR" => [],
    "アリエスカ" => [:curry],
    "Don's Bar ＠どん吉パーク" => [],
    "モザイクキッチン" => [],
    "FUTABA屋" => [:noodle],
    "苗場雪塾" => [:curry],
    "湯沢東映ホテルの鉄板焼きステーキハウス" => [:niku],
    "カレーショップ" => [:curry],
    "さかたや" => [],
    "長城菜館" => [],
    "広島お好み 鉄板ベイビー" => [],
    "湘南みはる" => [],
    "イスタンブールレストランGINZA" => [:hamburger],
    "鶏小屋" => [:noodle],
    "大衆食堂スタンドそのだ" => [:noodle],
    "タソガレコーヒースタンド" => [:coffee],
    "南魚沼 いなか茶屋 山彩" => [],
    "森の中のお肉レストラン アースガーデン" => [:vege],
    "Hyappa X Ja Nai!!" => [],
    "BLACK VELVET" => [],
    "VEGAS IN MILK" => [],
    "ミート&チーズバル レイジヤ" => [],
    "台湾佐記麺線" => [],
    "オアシス プリンス店" => [:curry, :niku],
    "うまいもんや越後" => [:noodle],
    "五平餅" => [],
    "たこ焼発祥のお店 大阪玉出 会津屋" => [],
    "ぞうめし屋" => [],
    "ジビエ・青空ベーカリー" => [:vege, :hamburger],
    "ガパオや" => [:ethnic],
    "京都 櫻川" => [:noodle],
    "ルクソールカバブ（エジプト料理）" => [],
    "JASMINE THAI" => [:ethnic],
    "麺屋「極」" => [:noodle],
    "博多一風堂" => [:noodle],
    "渡なべ" => [:noodle],
    "Bassic." => [],
    "インド料理ムンバイ" => [],
    "元祖 越後もち豚" => [:niku],
    "ラ・ロカンダ・デル・ピットーレ岩原本店" => [:piza],
    "葡呑" => [:washoku],
    "HOTDOG TRAILER" => [],
    "GAN-BAN BAR" => [:sake],
    "レッドシューズ" => [:sake],
    "KARMA" => [:sake],
    "RISING SUN ROCK FESTIVAL 日の出食堂" => [:niku],
    "Fruit collection kakumi" => [:hamburger],
    "KANNON COFFEE" => [:coffee],
    "神立商店" => [],
    "みつばや" => [],
    "森のステーキ屋ビトロー" => [:curry],
    "おむすび処 ゆた" => [:washoku],
    "Rainbow Café" => [:sweets],
    "ユキマツリ" => [:noodle, :washoku],
    "越後魚沼の地酒プロモーション" => [:sake],
    "鮎茶屋" => [:fish],
    "苗場食堂" => [:washoku],
    "big cake" => [:curry],
    "1066" => [],
    "パエリアおじいちゃん" => [],
    "ル・ヴァン・ナチュール" => [:sake],
    "らーめんえにし" => [:noodle],
    "LITTLE RED WING" => [],
    "SO星人" => [:niku],
    "ところ天国" => [:hamburger],
    "越後のきつね屋" => [],
    "森のハイジカレー" => [:curry],
    "石見食堂" => [],
    "三茶.KUNIKAGE" => [],
    "ミートバル仙台本店(ビストロ・ヤマライ)" => [],
    "みつばちカフェhonobono号" => [],
    "タナカクマキチ。" => [:noodle, :vege],
    "朝霧食堂" => [],
    "The Atomic cafe" => [],
    "太陽食堂 空いろ" => [],
    "天然酵母パン ルヴァン" => [],
    "東山食堂" => [],
    "SWNKA SHANKA" => [],
    "下町バル ながおか屋" => [:niku],
    "井の頭 ナムチャイ" => [],
    "PRIMAL" => [],
    "SAKURAGUMI" => [:piza],
    "新潟あさごはん" => [:washoku],
    "ラテン料理y" => [],
    "タイ国料理ジャイタイ" => [],
    "老舗肉問屋 小川畜産" => [],
    "Rans kamakura" => [:hamburger],
    "CRAFT BEER MARKET" => [:beer],
    "四代目徳次郎" => [:sweets],
    "Café de Paris" => [:sake],
    "neighbour naybar" => [:piza],
  }

  STAND_DATA.each do |name, tags|
    stand = Stand.find_by(name: name)
    next unless stand
    tags.each do |tag|
      stand.stand_tags.find_or_create_by(tag_id: category_tags[tag])
    end
  end
end


