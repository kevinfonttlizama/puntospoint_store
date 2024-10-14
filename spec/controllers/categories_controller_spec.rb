# spec/controllers/categories_controller_spec.rb
# encoding: utf-8

require 'spec_helper'

describe CategoriesController, type: :controller do
  before(:each) do
    authenticate_admin!
  end

  describe "GET 'index'" do
    it "devuelve http success" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "devuelve todas las categorias" do
      Category.create!(name: 'Electronics')
      Category.create!(name: 'Books')
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end
  end

  describe "GET 'show'" do
    it "devuelve http success" do
      category = Category.create!(name: 'Electronics')
      get :show, params: { id: category.id }
      expect(response).to have_http_status(:ok)
    end

    it "devuelve la categoria correcta" do
      category = Category.create!(name: 'Electronics')
      get :show, params: { id: category.id }
      json = JSON.parse(response.body)
      expect(json['name']).to eq('Electronics')
    end

    it "devuelve 404 si la categoria no existe" do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST 'create'" do
    context "con parametros validos" do
      it "crea una nueva categoria" do
        expect {
          post :create, params: { category: { name: 'New Category' } }
        }.to change(Category, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "con parametros invalidos" do
      it "no crea una nueva categoria" do
        expect {
          post :create, params: { category: { name: '' } }
        }.not_to change(Category, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT 'update'" do
    it "actualiza la categoria existente" do
      category = Category.create!(name: 'Old Name')
      put :update, params: { id: category.id, category: { name: 'New Name' } }
      expect(response).to have_http_status(:ok)
      expect(category.reload.name).to eq('New Name')
    end

    it "devuelve 404 si la categoria no existe" do
      put :update, params: { id: 999, category: { name: 'New Name' } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE 'destroy'" do
    it "elimina la categoria existente" do
      category = Category.create!(name: 'Electronics')
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "devuelve 404 si la categoria no existe" do
      delete :destroy, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
