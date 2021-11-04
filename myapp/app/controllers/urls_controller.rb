class UrlsController < ApplicationController
  protect_from_forgery with: :null_session
  def postshort
    if Url.count.zero?
      charset = Array('A'..'Z') + Array('a'..'z')
      @shurl = (Array.new(6) { charset.sample }.join ).to_s 
      @url = Url.new(longurl: params[:lurl],shorturl: @shurl, count: 0)
      @url.save     
    else
      @url = Url.find_by(longurl: params[:lurl])
      if @url.nil?      
        flag = 0
        @all = Url.all
        while flag==0 do
          charset = Array('A'..'Z') + Array('a'..'z')
          @shurl = (Array.new(6) { charset.sample }.join ).to_s     
          flag =1
          @all.each{|item|
            if item.shorturl == @shurl
              flag = 0
              break
            end
        }
        end
        @url = Url.new(longurl: params[:lurl],shorturl: @shurl, count: 0)
        @url.save
      else
        @shurl = @url.shorturl
      end
    end
    render plain: @shurl
  end
  def addcount
    @url = Url.find_by(shorturl: params[:short_url])
    @longurl = @url.longurl
    @url.count +=1
    @url.save
    render plain: @longurl
  end
  def showcount
    @url = Url.find_by(shorturl: params[:short_url])
    @count = @url.count
    render plain: @count
  end
end
