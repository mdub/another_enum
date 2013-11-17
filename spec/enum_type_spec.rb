require 'enum_type'

describe EnumType, :fast do

  let(:direction_class) do
    Class.new do
      extend EnumType
      define :north
      define :south
      define :east
      define :west
    end
  end

  describe ".define" do

    it "defines a new value" do
      direction_class.north.should be_kind_of(direction_class)
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
        direction_class.up.saying.should eq("Up up and away!")
      end

      it "does not affect other classes" do
        direction_class.north.should_not respond_to(:saying)
      end

    end

  end

  describe ".all" do

    it "returns all the defined values" do
      direction_class.all.should eq([
        direction_class.north,
        direction_class.south,
        direction_class.east,
        direction_class.west
      ])
    end

  end

  describe ".codes" do

    it "returns all the codes" do
      direction_class.codes.should eq(%w(north south east west))
    end

  end

  describe "#code" do

    it "returns the value's unique code" do
      direction_class.north.code.should eq('north')
    end

  end

end
