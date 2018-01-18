require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user) { User.create!(email: "user@example.com", password: "password", confirmed_at: Date.today) }
  let(:my_wiki) { Wiki.create!(title: "new wiki title", body: "new wiki body", private: false, user: user)}

  before do
    sign_in(user)
  end

  #-------------------------------------------------------
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_wiki to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end
  #--------------------------------------------------------

  describe "Get #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new template" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).to_not be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Wiki by 1" do
      expect{ post :create, params: {user_id: user.id, wiki: { title: "wiki title", body: "wiki body", private: false} } }.to change(Wiki,:count).by(1)
    end

    it "assigns my_wiki to @wiki" do
      post :create, params: {user_id: user.id, wiki: {title: "wiki title", body: "wiki body", private: false} }
      expect(assigns(:wiki)).to eq Wiki.last
    end
  end

  describe "GET #show" do
    it "returns http sucess" do
      get :show, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: my_wiki.id }
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, params: {id: my_wiki.id }
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to render_template :edit
    end
    it "assigns my_wiki to @wiki" do
      get :edit, params: {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = "Update Title"
      new_body = "Update Body"

      put :update, params: { user_id: user.id, id: my_wiki.id, wiki: { title: new_title, body: new_body } }

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
    end

    it "redirects to the updated wiki" do
      new_title = "Updated Title"
      new_body = "Updated Body"

      put :update, params: {user_id: user.id, id: my_wiki.id, wiki: { title: new_title, body: new_body } }
      expect(response).to redirect_to [my_wiki]
    end
  end

  describe "DELETE destory" do
    it "deletes the post" do
      delete :destroy, params: { id: my_wiki.id }
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to wikis index" do
      delete :destroy, params: { id: my_wiki.id }
      expect(response).to redirect_to wikis_path
    end
  end
end
