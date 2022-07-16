module Pokemons
  class Find < ApplicationService
    def initialize(name:)
      @name = name
    end

    def call
      raise 'Name cannot be blank.' if @name.nil? || @name.blank?

      res = RestClient.get(ENV['POKE_API'] + @name)
      JSON.parse(res)
    rescue RestClient::NotFound => e
      { error: e, status: :not_found }
    rescue StandardError => e
      { error: e, status: :unprocessable_entity }
    end
  end
end
