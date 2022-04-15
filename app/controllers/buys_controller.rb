class BuysController < ApplicationController
    before_action :user_required

    def show
        @catalog_item = CatalogItem.find(params[:id])
    end
end
