class CatsController < ApplicationController

    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find(params[:id])
        render :show
    end

    def new
        @cat = Cat.new
        @colors = %w(black white ginger striped wild)
        @sexes = %w(M F Q A)
        render :new
    end

end