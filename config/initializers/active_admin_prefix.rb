module ActiveAdmin
    module Routing
      module UrlHelper
        def self.included(klass)
          klass.class_eval do
            private
  
            def with_data_prefix(path)
              Rails.application.config.relative_url_root + path
            end
  
            def without_data_prefix(path)
              path.gsub(/\A#{Rails.application.config.relative_url_root}/, '')
            end
  
            def data_admin_namespace
              ActiveAdmin.application.default_namespace
            end
          end
        end
      end
    end
  end
  