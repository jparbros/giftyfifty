module Scrap
  class Amazon
    require 'open-uri'
    
    attr_accessor :hp
    
    def initialize(url)
      @hp = Hpricot(open(url))
    end
    
    def price
      (@hp/"tr>td>b.priceLarge").inner_text.gsub('$','').to_f
    end
    
    def image
      (@hp/"#prodImageCell>a >img").attr('src')
    end
    
    def name
      (@hp/"h1.parseasinTitle > span#btAsinTitle").inner_text
    end
    
    def asin
      (@hp/"td.bucket > .content > ul > li").select {|t| t.inner_text.include?'ASIN'}.first.inner_text.gsub('ASIN: ','')
    end
    
    def category
      (@hp/".navCatSpc >.navCatA").inner_text
    end
    
    def weight
      element = (@hp/"td.bucket > .content > ul > li").select {|t| t.inner_text.include?'Shipping Weight'}.first
      element.inner_text.gsub(/\D/,'').to_i if element
    end
  end
end