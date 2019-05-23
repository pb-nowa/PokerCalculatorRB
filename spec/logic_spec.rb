require "logic"

describe "Logic" do
  let (low_pair) do 
    Game.new 
    game_1.i_have('2h')
    game_2.i_have('2d')
  end
  let (ten_pair) do 
    Game.new 
    game_1.i_have('10h')
    game_2.i_have('10d')
  end
  let (face_pair) do 
    Game.new 
    game_1.i_have('qh')
    game_2.i_have('Qd')
  end
  let (suited_disconnect) do 
    Game.new 
    game_1.i_have('2h')
    game_2.i_have('7h')
  end 
  let (unsuited_disconnect) do 
    Game.new 
    game_1.i_have('3d')
    game_2.i_have('8s')
  end
  let (low_suited_connector) do 
    Game.new 
    game_1.i_have('4s')
    game_2.i_have('5s')
  end
  let (hi_suited_connector) do 
    Game.new 
    game_1.i_have('qd')
    game_2.i_have('kd')
  end


  describe "Poker Logic Tests!!!!!!!!!!!" do
    describe "#prob_of_pair" do
      it "should accept: my_hand(object), my_card, table, deck)" do
        low_pair.prob_of_pair(low_pair.my_hand, low_pair.my_card, low_pair.table, low_pair.deck)
      end

      it "should return 8%" do
        low_pair.table_has("4h")
        low_pair.table_has("6h")
        low_pair.table_has("qs")
        expect(low_pair.prob_of_pair(low_pair.my_hand, low_pair.my_card, low_pair.table, low_pair.deck).to eq("8%"))
      end
    end

  
  end
end
