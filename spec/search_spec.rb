require "spec_helper"

describe "Testing search" do

  it "Insert and find" do

    Tire.index "saloons" do
      delete
      create

      store name: "Cameron",
        slug: "cameron-matthew-hair",
        services: [
          {
            name: "Cut & blow dry / finish",
            id: 1
          },
          {
            name: "Blow dry / finish",
            id: 2
          },
          {
            name: "Testing is fun",
            id: 3
          }
        ]

      store name: "Nejc",
        slug: "nejc-wuz-here",
        services: [
          {
            name: "Testing is fun",
            id: 3
          }
        ]

      store name: "Oto",
        slug: "nejc-wuz-here-and-there",
        services: [
          {
            name: "Testing with love",
            id: 4
          }
        ]

      refresh
    end

    # Do some sleeping. Code is faster than Ruby.
    sleep 1


    ###
    ###   SEARCH
    ###

    # Saloons that have id 3 in service
    search = Tire.search("saloons") do
      query do
        boolean do
          must { term "services.id", 3 }
        end
      end
    end

    # QUERY:
    # curl -X GET 'http://localhost:9200/saloons/_search?pretty' -d '{"query":{"bool":{"must":[{"term":{"services.id":{"term":3}}}]}}}'

    r_1 = search.results.to_a.map(&:name)
    r_1.should =~ %w{Cameron Nejc}


    # Saloons that have id love in service
    search = Tire.search("saloons") do
      query do
        boolean do
          must { match "services.name", "love" }
        end
      end
    end

    # QUERY:
    # curl -X GET 'http://localhost:9200/saloons/_search?pretty' -d '{"query":{"bool":{"must":[{"match":{"services.name":{"query":"love"}}}]}}}'

    r_1 = search.results.to_a.map(&:name)
    r_1.should =~ %w{Oto}


  end


end

