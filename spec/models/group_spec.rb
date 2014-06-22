require "rails_helper"

describe Group do

  it { should belong_to(:user) }

end