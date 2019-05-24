class ApplicationController < ActionController::Base
  http_basic_authenticate_with name:"childs", password: "123456"
end
