-- Create the appUsers table
CREATE TABLE appUsers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username text NOT NULL UNIQUE,
  email text NOT NULL UNIQUE,
  fullName text NOT NULL,
  role text NOT NULL,                          -- e.g., 'user', 'admin'
  status text DEFAULT 'active',               -- e.g., 'active', 'suspended'
  createdAt timestamp with time zone DEFAULT now()
);

-- Create the transactions table
CREATE TABLE transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  userId uuid NOT NULL REFERENCES appUsers(id),
  matchId uuid REFERENCES matches(id),        -- null if not a match-related transaction
  amount numeric(14,2) NOT NULL CHECK (amount <> 0), -- Positive or negative as needed
  transaction_type text NOT NULL,             -- e.g., 'cash_in', 'cash_out', 'bet_hold', 'bet_release'
  reference_note text,                        -- Optional note or receipt
  createdAt timestamp with time zone DEFAULT now(),
  deletedAt timestamp with time zone DEFAULT NULL -- Default to NULL for soft delete
);

-- Create the matches table
CREATE TABLE matches (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  creatorId uuid NOT NULL REFERENCES appUsers(id),
  opponentId uuid NOT NULL REFERENCES appUsers(id),
  winnerId uuid REFERENCES appUsers(id),                -- Nullable until match is resolved
  matchTitle text NOT NULL,
  matchDescription text NOT NULL,
  schedule timestamp with time zone,
  creatorBetAmount numeric(14,2) NOT NULL CHECK (creatorBetAmount > 0),
  totalCreatorBetAmount numeric(14,2) DEFAULT 0,        -- Total contributions from creator team
  opponentBetAmount numeric(14,2) NOT NULL CHECK (opponentBetAmount > 0), -- Fixed reference
  totalOpponentBetAmount numeric(14,2) DEFAULT 0,       -- Total contributions from opponent team
  status text NOT NULL,                                 -- e.g., 'pending', 'ongoing', 'completed', 'canceled'
  creatorUpdatedAt timestamp with time zone,
  opponentUpdatedAt timestamp with time zone,
  adminUpdatedAt timestamp with time zone,
  createdAt timestamp with time zone DEFAULT now(),
  deletedAt timestamp with time zone DEFAULT NULL       -- Default to NULL for soft delete
);

-- Create the matchParticipants table
CREATE TABLE matchParticipants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  matchId uuid NOT NULL REFERENCES matches(id),         -- No cascade behavior; rely on soft delete
  userId uuid NOT NULL REFERENCES appUsers(id),
  team text NOT NULL CHECK (team IN ('creator', 'opponent')), -- To distinguish teams
  contributionAmount numeric(14,2) NOT NULL CHECK (contributionAmount > 0), -- Individual contribution
  createdAt timestamp with time zone DEFAULT now(),
  deletedAt timestamp with time zone DEFAULT NULL,      -- For soft delete
  UNIQUE (matchId, userId)                              -- Prevent duplicate entries for the same user in the same match
);

-- Add index on email in appUsers
CREATE UNIQUE INDEX idx_appUsers_email ON appUsers (email);

-- Add index on username in appUsers
CREATE UNIQUE INDEX idx_appUsers_username ON appUsers (username);

-- Add index on userId in transactions
CREATE INDEX idx_transactions_userId ON transactions (userId);

-- Add index on matchId in transactions
CREATE INDEX idx_transactions_matchId ON transactions (matchId);

-- Add index on status in matches for filtering
CREATE INDEX idx_matches_status ON matches (status);

-- Function to auto-update the total bet amounts
CREATE OR REPLACE FUNCTION update_total_bet_amounts()
RETURNS TRIGGER AS $$
BEGIN
  -- Update totalCreatorBetAmount
  UPDATE matches
  SET totalCreatorBetAmount = (
    SELECT COALESCE(SUM(contributionAmount), 0)
    FROM matchParticipants
    WHERE matchId = COALESCE(NEW.matchId, OLD.matchId) AND team = 'creator' AND deletedAt IS NULL
  )
  WHERE id = COALESCE(NEW.matchId, OLD.matchId);

  -- Update totalOpponentBetAmount
  UPDATE matches
  SET totalOpponentBetAmount = (
    SELECT COALESCE(SUM(contributionAmount), 0)
    FROM matchParticipants
    WHERE matchId = COALESCE(NEW.matchId, OLD.matchId) AND team = 'opponent' AND deletedAt IS NULL
  )
  WHERE id = COALESCE(NEW.matchId, OLD.matchId);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update the table every time there are changes in match participants
CREATE TRIGGER trigger_update_bet_amounts
AFTER INSERT OR UPDATE OR DELETE
ON matchParticipants
FOR EACH ROW
EXECUTE FUNCTION update_total_bet_amounts();
