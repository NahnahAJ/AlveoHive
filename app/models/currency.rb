class Currency < ApplicationRecord
    serialize :rates, Hash, coder: JSON
end
