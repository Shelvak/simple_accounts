Fabricator(:movement) do
    client { reference }
    amount { rand * 1000 }
    kind { rand(1000) }
    user { reference }
end
