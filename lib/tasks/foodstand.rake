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
    areas = %w(area01 area02 area03 area04 area05 area06 area07 area08 area09 area10)
    areas.each do |area|
      doc.xpath("//section[@id='#{area}']").each do |section|
        names = section.xpath('h1').children.map(&:text)
        descriptions = section.xpath('p[@class="mb80"]').children.map(&:text)
        names.zip(descriptions).each do |name, description|
          stands << { area: area, name: name, description: description}
        end
      end
    end

    Stand.import stands
  end
end
