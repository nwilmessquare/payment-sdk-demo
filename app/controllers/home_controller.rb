class HomeController < ApplicationController
    def show
        session[:user_id] = User.all.sample.id
        @catalog_items = CatalogItem.order(:name).all
    end
end
