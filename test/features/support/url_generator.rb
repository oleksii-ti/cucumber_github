require 'rest-client'
require 'redis'

module GitHub

  # TODO move to config or set ENVs during deploy
  @@host = 'https://api.github.com'
  @@username = 'oleksii-ti'
  redis = Redis.new(host: "redis-14562.c13.us-east-1-3.ec2.cloud.redislabs.com", port: 14562, db: 0)
  @@access_token =redis.get("access_token")


  def self.username=(name)
    @@username = name
  end

  def get_endpoint(path, repo)
    case path
      when 'commits'
        endpoint = @@host + '/repos/' + @@username + "/#{repo}" + '/commits?access_token=' + @@access_token
      when 'pulls'
        endpoint = @@host + '/repos/' + @@username + "/#{repo}" + '/pulls?access_token=' + @@access_token
    end
    endpoint
  end

  def add_parameters(parameters)
    payload = ''
    parameters.each_pair do |key, value|
      payload += "&#{key}=#{value}"
    end
    payload
  end

  def api_call(endpoint)
    puts endpoint
    response = RestClient.get(endpoint)
    return response
  end

  def get_tree(url)
    response = RestClient.get(url)
    return JSON.parse(response)
  end
end