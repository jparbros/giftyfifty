module Scrap
  class Ebay
    require 'open-uri'
    
    attr_accessor :hp
    
    def initialize(url)
      @hp = Hpricot(open(url))
    end
    
    def price
      (@hp.search ".vi-is1-solid.vi-is1-tbll>span").inner_text.gsub(/^.*\$/,'').gsub('$','').gsub(',','').to_f
    end
    
    def image
      (@hp.search ".ic-m> center > img").attr('src')
    end
    
    def name
      (@hp.search ".vi-is1-titleH1").inner_text
    end
    
    def asin
      (@hp.search ".z_b>.sp1>tr>td")[1].inner_text
    end
    
    def shipping
      (@hp.search ".vi-is1-clr > #fshippingCost").inner_text
    end
    
    def category
      (@hp.search ".in>li>a").last.inner_text
    end
  end
end
