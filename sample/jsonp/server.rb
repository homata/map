# -*- coding: utf-8 -*-
#
# JSONP Proxy Server with sinatra
# 
#    e.g. ruby server.rb -p # set the port (default is 4567)
#
require 'rubygems'
require 'sinatra'
require 'sinatra/jsonp'
require 'open-uri'
require 'logger'  
require 'active_support/core_ext'
require 'json'

if development?
  require 'sinatra/reloader'   # reload re-write file 
end

#
# set Loggin file
# 
if production?
  Dir.mkdir('logs') unless File.exist?('logs')

  Log = Logger.new('logs/common.log','weekly')
  Log.level = Logger::WARN

  # Spit stdout and stderr to a file during production
  # in case something goes wrong
  $stdout.reopen("logs/output.log", "w")
  $stdout.sync = true
  $stderr.reopen($stdout)
end

if development?
  Log = Logger.new(STDOUT)
end

#
# Sinatra Proxy Server 
# 
get "/" do

  # get url data
  url = params[:url]
  # get jsonp calback function name
  callback = params[:callback]

  Log.debug  "url=#{url}, callback=#{callback}" 

  # response content-type
  content_type "text/javascript"

  # read xml data from url
  xmldata = open(url).read
  # convert from xml to json string
  jsondata = Hash.from_xml(xmldata).to_json

  # return jsonp response: e.g. "callback(json)"
  jsonp jsondata, callback
end

