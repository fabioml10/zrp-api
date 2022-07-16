module Api
  module V1
    class PokemonsController < ApplicationController
      def search_abilities
        search_term = params[:q].downcase
        pokemon = Pokemons::Find.call(name: search_term)

        if pokemon['abilities']
          abilities_names = pokemon['abilities'].map { |ability| ability['ability']['name'] }
          ordered_abilities_names = abilities_names.sort { |a, b| a <=> b }

          @abilities = { abilities: ordered_abilities_names }
        else
          puts pokemon
          render json: { error: pokemon[:error] }, status: pokemon[:status]
        end
      end
    end
  end
end
