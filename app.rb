require 'rubygems'
require 'sinatra'
require 'json'
require 'nokogiri'

#Taken from https://github.com/zurb/ink/issues/59
PREMAILER_SETTINGS = {  line_length: 65,
                        link_query_string: nil,
                        base_url: nil,
                        remove_classes: false,
                        remove_ids: false,
                        remove_comments: false,
                        remove_scripts: true,
                        css: [],
                        css_to_attributes: true,
                        with_html_string: true,
                        css_string: nil,
                        preserve_styles: false,
                        preserve_reset: true,
                        verbose: false,
                        debug: false,
                        io_exceptions: false,
                        include_link_tags: true,
                        include_style_tags: true,
                        input_encoding: 'ASCII-8BIT',
                        replace_html_entities: false,
                        warn_level: Premailer::Warnings::SAFE
                      }

# Main entry point
class PremailerServer < Sinatra::Base

  post '/' do
    # We expect nginx to do security for the app
    error 400 if !params[:html]
 
    with_warnings = params[:with_warnings] == '1' ? true : false
    html = params[:html]
 
    premailer = Premailer.new(html, PREMAILER_SETTINGS)
 
    content_type :json
    data = {:html => premailer.to_inline_css}
    data[:warnings] = premailer.warnings if with_warnings
    data.to_json
  end
  get '/heartbeat' do
    "Hello World!"
  end
end
