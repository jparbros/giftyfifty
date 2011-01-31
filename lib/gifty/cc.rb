module Gifty
  module Cc
    CARD_COMPANIES = { 
      "visa" => /^4\d{12}(\d{3})?$/,
      "master" => /^(5[1-5]\d{4}|677189)\d{10}$/,
      "discover" => /^(6011|65\d{2}|64[4-9]\d)\d{12}|(62\d{14})$/,
      "american_express" => /^3[47]\d{13}$/,
      "diners_club" => /^3(0[0-5]|[68]\d)\d{11}$/,
      "jcb" => /^35(28|29|[3-8]\d)\d{12}$/,
      "switch" => /^6759\d{12}(\d{2,3})?$/,
      "solo" => /^6767\d{12}(\d{2,3})?$/,
      "dankort" => /^5019\d{12}$/,
      "maestro" => /^(5[06-8]|6\d)\d{10,17}$/,
      "forbrugsforeningen" => /^600722\d{10}$/,
      "laser" => /^(6304|6706|6771|6709)\d{8}(\d{4}|\d{6,7})?$/
    }
    
    COMPANIES_NAMES = {
      "visa" => "visa",
      "master" => "master",
      "discover" => "discover",
      "american_express" => "american_express",
      "diners_club" => "diners_club",
      "jcb" => "jcb",
      "switch" => "switch",
      "solo" => "solo",
      "dankort" => "dankort",
      "maestro" => "maestro",
      "forbrugsforeningen" => "forbrugsforeningen",
      "laser" => "laser"
    }
    
    def formated_params
      type = cc_type(self.credit_card)
      {:first_name => self.name.split(" ").first,
      :last_name => self.name.split(" ").last,
      :month => self.month,
      :year => self.year,
      :type => COMPANIES_NAMES[type],
      :number => self.credit_card,
      :verification_value => self.verification_value
      }
    end
    
    def cc_type(cc_number)
      CARD_COMPANIES.each do |card_company|
        return card_company.first.to_s if cc_number.match(card_company.last)
      end
    end
  end  
end