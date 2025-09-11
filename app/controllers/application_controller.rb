class ApplicationController < ActionController::API
  include Pagy::Backend
  include ActiveRecordErrors
end
