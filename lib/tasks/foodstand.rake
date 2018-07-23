require 'open-uri'
require 'nokogiri'

namespace :foodstand do
  desc "屋台情報を取得する"
  task :scraping => :environment do
    url = "http://www.fujirockfestival.com/news/shop.html"
    html = open(url).read

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, url)

    stands = []
    areas = {
      'area01' => {order: 10},
      'area02' => {order: 7},
      'area03' => {order: 11},
      'area04' => {order: 8},
      'area05' => {order: 1},
      'area06' => {order: 2},
      'area07' => {order: 3},
      'area08' => {order: 5},
      'area09' => {order: 4},
      'area10' => {order: 6},
      'area11' => {order: 9},
    }
    areas.each do |area, attrs|
      doc.xpath("//section[@id='#{area}']").each do |section|
        names = section.xpath('h1').children.map(&:text)
        descriptions = section.xpath('p[@class="mb80"]').children.map(&:text)
        images = section.children.xpath('img/@src').map(&:text)
        names.zip(images, descriptions).each do |name, image, description|
          stands << { area: area, name: name, image: image, description: description, order: attrs[:order]}
        end
      end
    end

    # Stand.import stands
    stands.each do |attrs|
      stand = Stand.find_or_initialize_by(name: attrs[:name])
      stand.update!(attrs)
    end

    puts "----- import complete 🎉"
    puts "stands: #{stands.count}"
  end
end
