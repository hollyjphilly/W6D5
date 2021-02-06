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
        render :new
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        if @cat
            render :edit
        else
            render json: "this cat doesn't exist"
        end
    end

    def update
        @cat = Cat.find(params[:id])  #user = User.find(params[:id])
        
        if @cat.update(cat_params)
            redirect_to cat_url(@cat)
        else
            render json: @cat.errors.full_messages, status: 422
        end
    end

    private

    def cat_params
        params.require(:cat).permit( :name, :birth_date, :sex, :color, :description)
    end

end