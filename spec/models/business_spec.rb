require 'spec_helper'

describe Business do
	it { should validate_presence_of(:name) }
end