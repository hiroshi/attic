class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  class HttpError < StandardError
    attr_accessor :status

    def initialize(msg, status)
      super(msg)
      @status = status
    end
  end

  rescue_from HttpError do |error|
    cleaner = ActiveSupport::BacktraceCleaner.new
    code = Rack::Utils::SYMBOL_TO_STATUS_CODE[error.status]
    log = "HttpError<status=#{error.status} (#{code}), message=\"#{error.message}\">\n  " + cleaner.clean(error.backtrace).join("\n  ")
    logger.error(ActiveSupport::LogSubscriber.new.send(:color, log, :red))
    render json: { message: error.message }, status: error.status
  end
end
