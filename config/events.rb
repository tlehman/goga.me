WebsocketRails::EventMap.describe do
  subscribe :show_board, to: BoardsController, with_method: :show
  subscribe :update_board, to: BoardsController, with_method: :update
end
