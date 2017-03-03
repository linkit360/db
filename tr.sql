create schema tr;
CREATE TABLE tr.partners
(
  id SERIAL PRIMARY KEY NOT NULL,
  created_at TIMESTAMP DEFAULT now() NOT NULL,
  name VARCHAR(127) NOT NULL
);

CREATE TABLE tr.partners_destinations
(
  id SERIAL PRIMARY KEY NOT NULL,
  id_partner int NOT NULL,
  active bool not null default false,
  created_at TIMESTAMP DEFAULT now() NOT NULL,
  amount_limit INTEGER DEFAULT 0 NOT NULL,
  destination VARCHAR(2047) DEFAULT ''::character varying NOT NULL,
  rate_limit INT NOT NULL DEFAULT 0,
  price_per_hit DOUBLE PRECISION NOT NULL DEFAULT 0,
  operator_code INTEGER DEFAULT 0 NOT NULL,
  country_code INTEGER DEFAULT 0 NOT NULL,
  score INT NOT NULL DEFAULT 0
);

CREATE TABLE tr.destinations_hits
(
  id SERIAL PRIMARY KEY NOT NULL,
  id_partner int NOT NULL,
  id_destination int NOT NULL,
  tid VARCHAR(127) NOT NULL,
  created_at TIMESTAMP DEFAULT now() NOT NULL,
  sent_at TIMESTAMP DEFAULT now() NOT NULL,
  destination VARCHAR(2048) DEFAULT ''::character varying NOT NULL,
  msisdn VARCHAR(32) DEFAULT ''::character varying NOT NULL,
  price_per_hit DOUBLE PRECISION NOT NULL DEFAULT 0,
  operator_code INTEGER DEFAULT 0 NOT NULL,
  country_code INTEGER DEFAULT 0 NOT NULL
);

create index destinations_hits_sent_at_idx
  on tr.destinations_hits(sent_at);
create index destinations_hits_id_partner_idx
  on tr.destinations_hits(id_partner);
create index destinations_hits_id_destination_idx
  on tr.destinations_hits(id_destination);
