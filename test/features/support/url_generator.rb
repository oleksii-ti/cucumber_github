require 'rest-client'

module GitHub
  @@host = 'https://api.github.com'
  @@access_token = '7c8c8650c02aed356f9301160d46acc384a3ddb0'
  @@username = 'oleksii-ti'

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