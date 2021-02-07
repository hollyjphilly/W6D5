class CatRentalRequestsController < ApplicationController
    # #show order requests by start date

    def new
        @request = CatRentalRequest.new
        render :new
    end

    def create
        @request = CatRentalRequest.new(request_params)
        if @request.save
            cat = Cat.find_by(id: @request.cat_id)
            redirect_to cat_url(cat)
        else
            render :new
        end
    end

    def request_params
        params.require(:request).permit(:cat_id, :start_date, :end_date)
    end
end