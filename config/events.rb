WebsocketRails::EventMap.describe do
  subscribe :update_board, to: BoardsController, with_method: :update
end
