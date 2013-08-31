module SongInformation
  require "json"

  def song_lastfm
    {
      "track"=>
      {
        "id"=>"214337334",
        "name"=>"Transfuzja",
        "mbid"=>"16eb2f88-0f22-4eb1-9c3b-aacb5acad1a2",
        "url"=>"http://www.last.fm/music/Coma/_/Transfuzja",
        "duration"=>"260000",
        "streamable"=> {
          "#text"=>"0",
          "fulltrack"=>"0"
        },
        "listeners"=>"39351",
        "playcount"=>"510309",
        "artist"=> {
          "name"=>"Coma",
          "mbid"=>"19df76fa-76e1-4801-8905-c3a620f96c4d",
          "url"=>"http://www.last.fm/music/Coma"
        },
        "album"=> {
          "artist"=>"Coma",
          "title"=>"Hipertrofia",
          "mbid"=>"56a5a8a6-37e8-4079-8b08-5cb1022bdb9b",
          "url"=>"http://www.last.fm/music/Coma/Hipertrofia",
          "image"=> [
            {
              "#text"=>"http://userserve-ak.last.fm/serve/64s/45865063.jpg",
              "size"=>"small"
            },
            {
              "#text"=>"http://userserve-ak.last.fm/serve/126/45865063.jpg",
              "size"=>"medium"
            },
            {
              "#text"=>"http://userserve-ak.last.fm/serve/174s/45865063.jpg",
              "size"=>"large"
            },
            {
              "#text"=>"http://userserve-ak.last.fm/serve/300x300/45865063.jpg",
              "size"=>"extralarge"
            }
          ],
          "@attr"=> {
            "position"=>"6"
          }
        },
        "toptags"=> {
          "tag"=> [
            {
              "name"=>"rock",
              "url"=>"http://www.last.fm/tag/rock"
            },
            {
              "name"=>"polish rock",
              "url"=>"http://www.last.fm/tag/polish%20rock"
            },
            {
              "name"=>"coma",
              "url"=>"http://www.last.fm/tag/coma"
            },
            {
              "name"=>"progressive rock",
              "url"=>"http://www.last.fm/tag/progressive%20rock"
            },
            {
              "name"=>"favourite",
              "url"=>"http://www.last.fm/tag/favourite"
            }
          ]
        }
      }
    }
  end

  def search_string
    '{"results":{"opensearch:Query":{"#text":"","role":"request","searchTerms":"transfuzja coma","startPage":"1"},"opensearch:totalResults":"29","opensearch:startIndex":"0","opensearch:itemsPerPage":"30","trackmatches":{"track":[{"name":"Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"39351","image":[{"#text":"http:\/\/userserve-ak.last.fm\/serve\/34s\/45865063.jpg","size":"small"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/64s\/45865063.jpg","size":"medium"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/126\/45865063.jpg","size":"large"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/300x300\/45865063.jpg","size":"extralarge"}],"mbid":"16eb2f88-0f22-4eb1-9c3b-aacb5acad1a2"},{"name":"Coma \/ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+%2F+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"192","mbid":""},{"name":"Coma - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"79","mbid":""},{"name":"Coma- Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"29","mbid":""},{"name":"coma-transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/coma-transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"Transfuzja (Symfonicznie)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Symfonicznie)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"350","mbid":""},{"name":"Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"15","mbid":""},{"name":"coma - transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/coma+-+transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"9","mbid":""},{"name":"06 - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"99","mbid":""},{"name":"Transfuzja (live)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(live)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"55","mbid":""},{"name":"Transfuzja","artist":"Coma Symfonicznie","url":"http:\/\/www.last.fm\/music\/Coma+Symfonicznie\/_\/Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"41","mbid":""},{"name":"06. Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06.+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"30","mbid":""},{"name":"06 Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"23","mbid":""},{"name":"Transfuzja (Wersja Symfoniczna)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Wersja+Symfoniczna)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"Transfuzja symfonicznie","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+symfonicznie","streamable":{"#text":"0","fulltrack":"0"},"listeners":"13","mbid":""},{"name":"Transfuzja (Remix Witosa)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Remix+Witosa)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"11","mbid":""},{"name":"06-Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06-Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Transfuzja [4:22]","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+%5B4:22%5D","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Transfuzja - Symfonicznie","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+-+Symfonicznie","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"\/ TRANSFUZJA","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/%2F+TRANSFUZJA","streamable":{"#text":"0","fulltrack":"0"},"listeners":"5","mbid":""},{"name":"06.Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06.Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"06-Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"142","mbid":""},{"name":"06-Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"17","mbid":""},{"name":"06 - Coma - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+-+Coma+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"coma - hipertrofia - transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/coma+-+hipertrofia+-+transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"11","mbid":""},{"name":"Coma_Hipertrofia CD 1_06-Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma_Hipertrofia+CD+1_06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"127","mbid":""},{"name":"Coma _ Transfuzja","artist":"Coma_Hipertrofia CD 1_06","url":"http:\/\/www.last.fm\/music\/Coma_Hipertrofia+CD+1_06\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"16","mbid":""},{"name":"Coma_Hipertrofia CD 1_06-Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/Coma_Hipertrofia+CD+1_06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"10","mbid":""}]},"@attr":{"for":"transfuzja coma"}}}'
  end

  def search_hash
    JSON.parse('{"results":{"opensearch:Query":{"#text":"","role":"request","searchTerms":"transfuzja coma","startPage":"1"},"opensearch:totalResults":"29","opensearch:startIndex":"0","opensearch:itemsPerPage":"30","trackmatches":{"track":[{"name":"Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"39351","image":[{"#text":"http:\/\/userserve-ak.last.fm\/serve\/34s\/45865063.jpg","size":"small"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/64s\/45865063.jpg","size":"medium"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/126\/45865063.jpg","size":"large"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/300x300\/45865063.jpg","size":"extralarge"}],"mbid":"16eb2f88-0f22-4eb1-9c3b-aacb5acad1a2"},{"name":"Coma \/ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+%2F+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"192","mbid":""},{"name":"Coma - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"79","mbid":""},{"name":"Coma- Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"29","mbid":""},{"name":"coma-transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/coma-transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"Transfuzja (Symfonicznie)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Symfonicznie)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"350","mbid":""},{"name":"Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"15","mbid":""},{"name":"coma - transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/coma+-+transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"9","mbid":""},{"name":"06 - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"99","mbid":""},{"name":"Transfuzja (live)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(live)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"55","mbid":""},{"name":"Transfuzja","artist":"Coma Symfonicznie","url":"http:\/\/www.last.fm\/music\/Coma+Symfonicznie\/_\/Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"41","mbid":""},{"name":"06. Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06.+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"30","mbid":""},{"name":"06 Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"23","mbid":""},{"name":"Transfuzja (Wersja Symfoniczna)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Wersja+Symfoniczna)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"Transfuzja symfonicznie","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+symfonicznie","streamable":{"#text":"0","fulltrack":"0"},"listeners":"13","mbid":""},{"name":"Transfuzja (Remix Witosa)","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+(Remix+Witosa)","streamable":{"#text":"0","fulltrack":"0"},"listeners":"11","mbid":""},{"name":"06-Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06-Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Transfuzja [4:22]","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+%5B4:22%5D","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"Transfuzja - Symfonicznie","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Transfuzja+-+Symfonicznie","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"\/ TRANSFUZJA","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/%2F+TRANSFUZJA","streamable":{"#text":"0","fulltrack":"0"},"listeners":"5","mbid":""},{"name":"06.Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06.Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"7","mbid":""},{"name":"06-Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"142","mbid":""},{"name":"06-Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"17","mbid":""},{"name":"06 - Coma - Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/06+-+Coma+-+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"20","mbid":""},{"name":"coma - hipertrofia - transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/coma+-+hipertrofia+-+transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"11","mbid":""},{"name":"Coma_Hipertrofia CD 1_06-Coma _ Transfuzja","artist":"Coma","url":"http:\/\/www.last.fm\/music\/Coma\/_\/Coma_Hipertrofia+CD+1_06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"127","mbid":""},{"name":"Coma _ Transfuzja","artist":"Coma_Hipertrofia CD 1_06","url":"http:\/\/www.last.fm\/music\/Coma_Hipertrofia+CD+1_06\/_\/Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"16","mbid":""},{"name":"Coma_Hipertrofia CD 1_06-Coma _ Transfuzja","artist":"[unknown]","url":"http:\/\/www.last.fm\/music\/%5Bunknown%5D\/_\/Coma_Hipertrofia+CD+1_06-Coma+_+Transfuzja","streamable":{"#text":"0","fulltrack":"0"},"listeners":"10","mbid":""}]},"@attr":{"for":"transfuzja coma"}}}')
  end
end