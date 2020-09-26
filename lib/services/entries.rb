module Services
    class Entries

        URL_BASE = "https://od-api.oxforddictionaries.com/api/v2/entries/"
        URL_COMPLEMET ="?fields=definitions&strictMatch=false"


        APP_ID ='c2e7b1fe'
        APP_KEY = 'b41be5b3b08f91ebe3d849570f15c52a'

        def executeService

            url = complete_url

            begin
            response = RestClient.get(url,
            {
                'Authorization' => 'application/json',
                'app_id' => APP_ID,
                'app_key' => APP_KEY})   
                

            rescue RestClient::Unauthorized, RestClient::Forbidden => err
                singleTextDef = 'Access denied'
                return singleTextDef
            rescue RestClient::NotFound => err
                singleTextDef = 'THE WORD IS NOT FOUND'
                return singleTextDef
            else
                singleTextDef = getStringResponse(response)
            end
              


            

            return singleTextDef
            
        end


        def getStringResponse(response)
        
            parseResponse = JSON.parse(response)

            rp = parseResponse["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]

            singleTextDef =""
            
            rp.each do | i |
                singleTextDef = singleTextDef + i["definitions"][0] +"||"
            end 

            2.times do singleTextDef.chop! end

            return singleTextDef

        end


        def initialize(lang, textBase)  
            # atributos   
            @lang = lang  
            @textBase = textBase  
        end  


        def complete_url 
            return URL_BASE +  @lang + "/" + @textBase + URL_COMPLEMET
        end
    end
end
