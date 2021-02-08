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

    def approve
        req = CatRentalRequest.find_by(id: params[:cat_rental_request_id])
        req.approve!
        cat = Cat.find_by(id: req.cat_id)
        redirect_to cat_url(cat)
    end

    def deny
        req = CatRentalRequest.find_by(id: params[:cat_rental_request_id])
        req.deny!
        cat = Cat.find_by(id: req.cat_id)
        redirect_to cat_url(cat)
    end
end