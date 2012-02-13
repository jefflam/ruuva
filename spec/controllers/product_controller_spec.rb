require 'spec_helper'

describe ProductController do

  describe "GET 'name:string'" do
    it "returns http success" do
      get 'name:string'
      response.should be_success
    end
  end

  describe "GET 'description:string'" do
    it "returns http success" do
      get 'description:string'
      response.should be_success
    end
  end

  describe "GET 'price:string'" do
    it "returns http success" do
      get 'price:string'
      response.should be_success
    end
  end

  describe "GET 'likes:integer'" do
    it "returns http success" do
      get 'likes:integer'
      response.should be_success
    end
  end

  describe "GET 'collection_id:integer'" do
    it "returns http success" do
      get 'collection_id:integer'
      response.should be_success
    end
  end

end
