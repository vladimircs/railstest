class ArticlesController < ApplicationController

    def index
        @requests = Request.all.reverse
    end

    def new
       @requests = Request.last(5).reverse
       @request = Request.new()
       @request.response = ""
       render "create"
    end

 
    def create

        @request = Request.new(article_params)

        entry = Services::Entries.new(@request.lang,@request.text)

        response = entry.executeService

        @request.response = response

        @request.save

        @requests = Request.last(5).reverse
             
       
    end



    private
        def article_params
            params.require(:request).permit(:lang, :text, :response)
        end

      
end
