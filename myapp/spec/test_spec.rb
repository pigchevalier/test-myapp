require 'rspec'
require_relative "rails_helper.rb"
require_relative "../app/controllers/urls_controller.rb"

describe UrlsController, type: :controller do
    render_views
    it 'should do ok for test1' do
        longurl = "www.github.com"        
        post :postshort, params: {lurl: longurl}
        shurl = response.body
        get :showcount, params: {short_url: shurl}
        expect(response.body).to eq("0")
        get :addcount, params: {short_url: shurl}
        expect(response.body).to eq(longurl)
        get :showcount, params: {short_url: shurl}
        expect(response.body).to eq("1")
        get :addcount, params: {short_url: shurl}
        expect(response.body).to eq(longurl)
        get :showcount, params: {short_url: shurl}
        expect(response.body).to eq("2")
        post :postshort, params: {lurl: longurl}
        expect(response.body).to eq(shurl)
    end

    it 'should do ok for test2' do
        longurl = "www.ytoube.com"        
        post :postshort, params: {lurl: longurl}
        shurl = response.body
        get :showcount, params: {short_url: shurl}
        expect(response.body).to eq("0")
        get :addcount, params: {short_url: shurl}
        expect(response.body).to eq(longurl)
        get :addcount, params: {short_url: shurl}
        expect(response.body).to eq(longurl)
        get :addcount, params: {short_url: shurl}
        expect(response.body).to eq(longurl)
        get :showcount, params: {short_url: shurl}
        expect(response.body).to eq("3")
        post :postshort, params: {lurl: longurl}
        expect(response.body).to eq(shurl)
    end

    it 'should do ok for test3' do
        longurl1 = "www.1.com" 
        longurl2 = "www.2.com" 
        post :postshort, params: {lurl: longurl1}
        shurl1 = response.body
        post :postshort, params: {lurl: longurl2}
        shurl2 = response.body
        get :showcount, params: {short_url: shurl1}
        expect(response.body).to eq("0")
        get :showcount, params: {short_url: shurl2}
        expect(response.body).to eq("0")
        get :addcount, params: {short_url: shurl1}
        expect(response.body).to eq(longurl1)
        get :addcount, params: {short_url: shurl2}
        expect(response.body).to eq(longurl2)
        get :addcount, params: {short_url: shurl2}
        expect(response.body).to eq(longurl2)
        get :showcount, params: {short_url: shurl1}
        expect(response.body).to eq("1")
        get :showcount, params: {short_url: shurl2}
        expect(response.body).to eq("2")
        post :postshort, params: {lurl: longurl1}
        expect(response.body).to eq(shurl1)
        post :postshort, params: {lurl: longurl2}
        expect(response.body).to eq(shurl2)
    end
end