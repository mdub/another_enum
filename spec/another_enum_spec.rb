require 'another_enum'

RSpec.describe AnotherEnum, :fast do

  let(:direction_class) do
    Class.new(AnotherEnum) do
      define :north
      define :south
      define :east
      define :west
    end
  end

  describe ".define" do

    it "defines a new value" do
      expect(direction_class.north).to be_kind_of(direction_class)
    end

    context "with a block" do

      before do
        direction_class.define :up do
          def saying
            "Up up and away!"
          end
        end
      end

      it "extends the behaviour of the specified enum value" do
        expect(direction_class.up.saying).to eq("Up up and away!")
      end

      it "does not affect other classes" do
        expect(direction_class.north).to_not respond_to(:saying)
      end

    end

  end

  describe ".all" do

    it "returns all the defined values" do
      expect(direction_class.all).to eq([
        direction_class.north,
        direction_class.south,
        direction_class.east,
        direction_class.west
      ])
    end

  end

  describe ".codes" do

    it "returns all the codes" do
      expect(direction_class.codes).to eq(%w(north south east west))
    end

  end

  describe "#code" do

    it "returns the value's unique code" do
      expect(direction_class.north.code).to eq('north')
    end

  end

end
