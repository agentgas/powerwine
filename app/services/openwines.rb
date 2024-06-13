module Openwines
    class Retrieve
        def retrieve_datas
            mock_wine_datas = [
                {
                    "name": "Risline",
                    "year": 1986,
                    "producer": "Risprod",
                    "price": 125,
                    "shop": "The Wine Store"
                },
                {
                    "name": "Piquette 2000",
                    "year": 2000,
                    "producer": "bestOneEver",
                    "price": 25,
                    "shop": "The Wine Store"
                }
            ]

            return mock_wine_datas
        end
    end
end
