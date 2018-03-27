class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

   # called before every action on controllers
   before_action :authorize_request
   attr_reader :current_user

  protected

    def self.set_pagination_headers(name, options = {})
      after_action(options) do |controller|
        binding.pry
        results = instance_variable_get("@#{name}")
        headers["X-Pagination"] = {
          total: results.total_entries,
          total_pages: results.total_pages,
          first_page: results.current_page == 1,
          last_page: results.next_page.blank?,
          previous_page: results.previous_page,
          next_page: results.next_page,
          out_of_bounds: results.out_of_bounds?,
          offset: results.offset
        }.to_json
      end
    end

  private

    # Check for valid request token and return user
    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

end
