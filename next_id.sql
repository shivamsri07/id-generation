CREATE OR REPLACE FUNCTION "user_id_1-500".next_id(OUT result bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    our_epoch bigint := 1314220021721;
    seq_id bigint;
    now_millis bigint;
    shard_id int := 5;
BEGIN
    SELECT nextval('"table_id_seq"') % 1024::BIGINT INTO seq_id;
    SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
    result := (now_millis - our_epoch) << 23;
    result := result | (shard_id <<10);
    result := result | (seq_id);
END;
    $function$
