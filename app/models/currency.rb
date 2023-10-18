class Currency < ApplicationRecord
    serialize :rates, Hash
end
