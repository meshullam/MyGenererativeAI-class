"""Tic Tac Toe in Jaclang"""

walker main {
    can run entry {
        spawn Game();
    }
}

node Game {
    has grid: list[list[str]];
    has current_player: str;

    can init {
        grid = [[" " for _ in range(3)] for _ in range(3)];
        current_player = "X";
        play();
    }

    can play {
        for turn in range(9) {
            show_board();
            row = int(input(f"Player {current_player}, enter row (0,1,2): "));
            col = int(input(f"Player {current_player}, enter col (0,1,2): "));

            if grid[row][col] == " " {
                grid[row][col] = current_player;

                if check_winner() {
                    show_board();
                    print(f"Player {current_player} wins!");
                    return;
                }

                if current_player == "X" {
                    current_player = "O";
                } else {
                    current_player = "X";
                }
            } else {
                print("That spot is already taken, try again.");
                turn -= 1; // retry same turn
            }
        }

        show_board();
        print("It's a draw!");
    }

    can show_board {
        print("\n");
        for row in grid {
            print(" | ".join(row));
            print("-" * 5);
        }
        print("\n");
    }

    can check_winner -> bool {
        // Check rows
        for row in grid {
            if row[0] != " " and row[0] == row[1] == row[2] {
                return true;
            }
        }

        // Check columns
        for c in range(3) {
            if grid[0][c] != " " and grid[0][c] == grid[1][c] == grid[2][c] {
                return true;
            }
        }

        // Check diagonals
        if grid[0][0] != " " and grid[0][0] == grid[1][1] == grid[2][2] {
            return true;
        }
        if grid[0][2] != " " and grid[0][2] == grid[1][1] == grid[2][0] {
            return true;
        }

        return false;
    }
}
