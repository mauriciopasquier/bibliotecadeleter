# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

# Explícito, por si un update agrega evil things™
use ::Rack::Protection::RemoteReferrer
use ::Rack::Protection::FrameOptions
use ::Rack::Protection::HttpOrigin
use ::Rack::Protection::IPSpoofing
use ::Rack::Protection::JsonCsrf
use ::Rack::Protection::PathTraversal
use ::Rack::Protection::XSSHeader

run Rails.application
