CREATE OR REPLACE FUNCTION  xmp_pixel_transactions_create_partition_and_insert() RETURNS trigger AS
$BODY$
DECLARE
  partition_date TEXT;
  partition TEXT;
BEGIN
  partition_date := to_char(NEW.sent_at,'YYYY_MM_DD');
  partition := TG_TABLE_NAME || '_' || partition_date;
  IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname=partition) THEN
    RAISE NOTICE 'A partition has been created %',partition;

    EXECUTE 'CREATE TABLE ' || partition || ' ( ' ||
            'check ( date(sent_at) = ''' || partition_date||
            ''' ) ) INHERITS (' || TG_TABLE_NAME || ');';

    EXECUTE 'CREATE INDEX ' || partition || '_sent_at_idx ON ' || partition || '(sent_at);';
    EXECUTE 'CREATE INDEX ' || partition || '_pixel_idx ON ' || partition || '(pixel);';
    EXECUTE 'CREATE INDEX ' || partition || '_msisdn_idx ON ' || partition || '(msisdn);';
    EXECUTE 'CREATE INDEX ' || partition || '_publisher_idx ON ' || partition || '(publisher);';
    EXECUTE 'CREATE INDEX ' || partition || '_id_campaign_idx ON ' || partition || '(id_campaign);';
  END IF;
  EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_TABLE_NAME || ' ' || quote_literal(NEW) || ').* ';
  RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER xmp_pixel_transactions_insert_trigger
BEFORE INSERT ON xmp_pixel_transactions
FOR EACH ROW EXECUTE PROCEDURE xmp_pixel_transactions_create_partition_and_insert();


alter table xmp_pixel_transactions disable trigger  xmp_pixel_transactions_insert_trigger;