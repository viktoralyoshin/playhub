DROP SCHEMA IF EXISTS playhub CASCADE;
CREATE SCHEMA playhub;

CREATE TYPE playhub.game_status AS ENUM (
    'unspecified',  
    'plan',         
    'playing',      
    'completed',    
    'dropped',      
    'waiting'       
);

CREATE TABLE IF NOT EXISTS playhub.library (
    user_id UUID NOT NULL,
    game_id UUID NOT NULL,

    game_status playhub.game_status NOT NULL DEFAULT 'unspecified',

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),

    PRIMARY KEY (user_id, game_id)
);

CREATE INDEX idx_library_user_status ON playhub.library(user_id, game_status);