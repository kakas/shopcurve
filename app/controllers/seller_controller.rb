class SellerController < ApplicationController
  before_action :authenticate_user!
end
