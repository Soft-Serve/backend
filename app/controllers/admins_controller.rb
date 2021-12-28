class AdminsController < ActionController::Base
  def parse_csv
    file_path = File.expand_path(params[:file_path])
    Csv::Parser.new(file_path: file_path, restaurant_id: params[:restaurant_id]).call
  end
end
