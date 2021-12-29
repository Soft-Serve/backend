class AdminsController < ActionController::Base

  def index
  end

  def parse_csv
    result = Csv::Parser.new(
      file: params[:csv][:file],
      restaurant_id: params[:csv][:restaurant_id].to_i
    ).call
    if result.successful?
      @restaurant = result.value
    else
      flash.alert = "Upload failed: #{result.errors}"
    end
  end
end
