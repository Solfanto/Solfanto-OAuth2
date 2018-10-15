require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SiteOAuth
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe

      form_fields = [
        'textarea',
        'input',
        'select'
      ]

      elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

      elements.each do |e|
        if e.node_name.eql? 'label'
          html = %(<span class="control-group error">#{e}</span>).html_safe
        elsif form_fields.include? e.node_name
          if instance.error_message.kind_of?(Array)
            html = %(<span class="control-group error">#{html_tag}</span>).html_safe
          else
            html = %(<span class="control-group error">#{html_tag}</span>).html_safe
          end
        end
      end
      html
    }
  end
end
