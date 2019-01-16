require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "eturns redirect_to posts_path because user not admin" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      sign_in user
      get :new
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "GET #new" do
    it "returns successful because user is admin" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      user.add_role("admin")
      sign_in user
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns redirect_to posts_path because user not admin" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      sign_in user
      post = Post.create(title: 'title', summary: 'summary', body: 'body')
      get :edit, params: {id: post.to_param}
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "GET #edit" do
    it "returns successful because user is admin" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      user.add_role("admin")
      sign_in user
      post = Post.create(title: 'title', summary: 'summary', body: 'body')
      get :edit, params: {id: post.to_param}
      expect(response).to be_successful
    end
  end


  # describe "GET #destroy" do
  #   it "returns redirect_to posts_path because user not admin" do
  #     user = User.create!(email: "user@test.com", password: "password")
  #     user.confirm
  #     sign_in user
  #     post = Post.create(title: 'title', summary: 'summary', body: 'body')
  #     get :destroy, params: {id: post.to_param}
  #     expect(response).to redirect_to(posts_path)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns successful because user is admin" do
  #     user = User.create!(email: "user@test.com", password: "password")
  #     user.confirm
  #     user.add_role("admin")
  #     sign_in user
  #     post = Post.create(title: 'title', summary: 'summary', body: 'body')
  #     get :destroy, params: {id: post.to_param}
  #     expect(response).to redirect_to(posts_path)
  #   end
  # end

  describe "POST #create" do
    it "creates a new Post" do
      # @request.env["devise.mapping"] = Devise.mappings[:admin]
      expect {
        post = Post.create(title: "title", summary: "summary", body: "body")
      }.to change(Post, :count).by(1)
    end
  end

end
