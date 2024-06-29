class Currency < ApplicationRecord
    serialize :rates, Hash
    # serialize :rates, Hash, coder: JSON
end
