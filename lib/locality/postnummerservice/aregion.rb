require 'locality/postnummerservice'
require 'locality/postnummerservice/collection'

module Locality
  module Postnummerservice
    class Aregion
      include Postnummerservice::Collection

      # See https://sv.wikipedia.org/wiki/A-region
      def self.codes
        {
          1 => 'Stockholm/Södertälje',
          2 => 'Norrtälje',
          3 => 'Enköping',
          4 => 'Uppsala',
          5 => 'Nyköping',
          6 => 'Katrineholm',
          7 => 'Eskilstuna',
          8 => 'Mjölby/Motala',
          9 => 'Linköping',
          10 => 'Norrköping',
          11 => 'Jönköping',
          12 => 'Tranås',
          13 => 'Eksjö/Nässjö/Vetlanda',
          14 => 'Värnamo',
          15 => 'Ljungby',
          16 => 'Växjö',
          17 => 'Västervik',
          18 => 'Hultsfred/Vimmerby',
          19 => 'Oskarshamn',
          20 => 'Kalmar/Nybro',
          21 => 'Visby',
          22 => 'Karlskrona',
          23 => 'Karlshamn',
          24 => 'Kristianstad',
          25 => 'Hässleholm',
          26 => 'Ängelholm',
          27 => 'Helsingborg/Landskrona',
          28 => 'Malmö/Lund/Trelleborg',
          29 => 'Ystad/Simrishamn',
          30 => 'Eslöv',
          31 => 'Halmstad',
          32 => 'Falkenberg/Varberg',
          33 => 'Göteborg/Alingsås',
          34 => 'Uddevalla',
          35 => 'Trollhättan/Vänersborg',
          36 => 'Borås',
          37 => 'Lidköping/Skara',
          38 => 'Falköping',
          39 => 'Skövde',
          40 => 'Mariestad',
          41 => 'Kristinehamn/Filipstad',
          42 => 'Karlstad',
          43 => 'Säffle/Åmål',
          44 => 'Arvika',
          45 => 'Örebro',
          46 => 'Karlskoga',
          47 => 'Lindesberg',
          48 => 'Västerås',
          49 => 'Köping',
          50 => 'Fagersta',
          51 => 'Sala',
          52 => 'Borlänge/Falun',
          53 => 'Avesta/Hedemora',
          54 => 'Ludvika',
          55 => 'Mora',
          56 => 'Gävle/Sandviken',
          57 => 'Bollnäs/Söderhamn',
          58 => 'Hudiksvall/Ljusdal',
          59 => 'Sundsvall',
          60 => 'Härnösand/Kramfors',
          61 => 'Sollefteå',
          62 => 'Örnsköldsvik',
          63 => 'Östersund',
          64 => 'Umeå',
          65 => 'Skellefteå',
          66 => 'Lycksele',
          67 => 'Piteå',
          68 => 'Luleå/Boden',
          69 => 'Haparanda/Kalix',
          70 => 'Kiruna/Gällivare',
        }
      end

      def code
        raw_code.to_i
      end

      def name
        self.class.codes[code]
      end

      private

      def self.backend
        Postnummerservice.aregions
      end

    end
  end
end
