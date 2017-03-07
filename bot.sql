CREATE TABLE messages
(
  id             SERIAL PRIMARY KEY      NOT NULL,
  created_at     TIMESTAMP DEFAULT now() NOT NULL,
  sent_at        TIMESTAMP DEFAULT now() NOT NULL,
  sent_timestamp VARCHAR(127)            NOT NULL DEFAULT '',
  id_sender      VARCHAR(1023)           NOT NULL DEFAULT 0,
  id_recipient   VARCHAR(1023)           NOT NULL DEFAULT 0,
  text           TEXT,
  raw            TEXT                    NOT NULL
);

CREATE INDEX messages_created_at_idx ON messages (created_at);
CREATE INDEX messages_sent_at_idx ON messages (sent_at);
CREATE INDEX messages_sent_timestamp_idx ON messages (sent_timestamp);
CREATE INDEX messages_id_sender_idx ON messages (id_sender);
CREATE INDEX messages_id_recipient_idx ON messages (id_recipient);

CREATE TABLE survey
(
  id         SERIAL PRIMARY KEY      NOT NULL,
  created_at TIMESTAMP DEFAULT now() NOT NULL,
  id_creator INT                     NOT NULL,
  image_url  VARCHAR(4047)           NOT NULL DEFAULT '',
  item_url   VARCHAR(4047)           NOT NULL DEFAULT '',
  title      VARCHAR(4047)           NOT NULL DEFAULT '',
  subtitle   VARCHAR(4047)           NOT NULL DEFAULT ''
);

CREATE TABLE questions
(
  id             SERIAL PRIMARY KEY      NOT NULL,
  created_at     TIMESTAMP DEFAULT now() NOT NULL,
  id_creator VARCHAR(1023)               NOT NULL,
  id_survey  VARCHAR(1023)               NOT NULL,
  options    JSONB DEFAULT '{}' :: JSONB NOT NULL
);

CREATE TABLE answers
(
  id          SERIAL PRIMARY KEY          NOT NULL,
  created_at  TIMESTAMP DEFAULT now()     NOT NULL,
  sent_at     TIMESTAMP DEFAULT now()     NOT NULL,
  id_sender   VARCHAR(1023)               NOT NULL,
  id_survey   INT                         NOT NULL,
  id_question INT                         NOT NULL,
  answer      JSONB DEFAULT '{}' :: JSONB NOT NULL
);

CREATE INDEX answers_created_at_idx ON answers (created_at);
CREATE INDEX answers_sent_at_idx ON answers (sent_at);
CREATE INDEX answers_id_sender_idx ON answers (id_sender);
CREATE INDEX answers_id_survey_idx ON answers (id_survey);
CREATE INDEX answers_id_question_idx ON answers (id_question);

CREATE TABLE sender
(
  id         VARCHAR(1023)               NOT NULL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT now()     NOT NULL,
  status     VARCHAR(127)                NOT NULL DEFAULT 'active'
);

CREATE INDEX sender_id_sender_idx ON sender (id);
CREATE INDEX sender_created_at_idx ON sender (created_at);
CREATE INDEX sender_status_idx ON sender (status);


--   survey contains questions
--   questions contain options of answers
--   answers could be from different users
--
--   description - for what
--   question - 1
--
--   options