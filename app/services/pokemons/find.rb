module Pokemons
  class Find < ApplicationService
    API = 'https://pokeapi.co/api/v2/pokemon/'.freeze

    def initialize(name:)
      @name = name
    end

    def call
      raise 'Name cannot be blank.' if @name.nil? || @name.blank?

      res = RestClient.get(API + @name)
      JSON.parse(res)
    rescue RestClient::NotFound => e
      { error: e, status: :not_found }
    rescue StandardError => e
      { error: e, status: :unprocessable_entity }
    end
  end
end
