module Scrap
  class Amazon
    require 'open-uri'
    
    attr_accessor :hp
    
    def initialize(url)
      @url = url
      @hp = Hpricot(open(url))
    end
    
    def price
      (@hp.search "tr>td>b.priceLarge").inner_text.gsub('$','').gsub(',','').to_f
    end
    
    def image
      normal_image || kindle_image
    end
    
    def name
      (@hp.search "h1.parseasinTitle > span#btAsinTitle").inner_text
    end
    
    def asin
      normal_asin || kindle_asin
    end
    
    def category
      (@hp.search ".navCatSpc >.navCatA").inner_text
    end
    
    def weight
      normal_weight || kindle_weight
    end
    
    private
     def normal_image
       image = (@hp.search "#prodImageCell>a >img")
       unless image.blank?
         image.attr('src')
       else
         nil
       end
     end
     
     def kindle_image
       image = (@hp.search ".at-a-glance-outer>tbody>tr>td>div #kindle-at-a-glance-image")
       unless image.blank?
         image.attr('src')
       else
         nil
       end
     end
     
     def normal_weight
       element = (@hp.search "td.bucket > .content > ul > li").select {|t| t.inner_text.include?'Shipping Weight'}.first
       element.inner_text.gsub(/\D/,'').to_i unless element.blank?
     end
     
     def kindle_weight
       element = ((@hp.search '#technical-details > table')[1].search 'tr').select {|t| t.inner_text.include?'Weight'}.first
       element.inner_text.gsub(/ounces.*$/,'').gsub('Weight','').to_f
     end
     
     def normal_asin
        element = (@hp.search "td.bucket > .content > ul > li")
        (@hp.search "td.bucket > .content > ul > li").select {|t| t.inner_text.include?'ASIN'}.first.inner_text.gsub('ASIN: ','') unless element.blank?
     end
     
     def kindle_asin
        @url.to_s.split('/').select {|t| t.size == 10}.first
     end
  end
end