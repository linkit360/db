INSERT INTO public.xmp_services_old (id, name, description, keyword, url, price, id_payment_type, id_subscription_type, keep_days, wording, status, id_currency, created_at, channel_sms, channel_wap, channel_web, start_date, price_option, link, pull_msisdn_ttr, pull_retry_delay, sms_send, paid_hours, delay_hours, send_not_paid_text_enabled, not_paid_text, send_content_allowed_time, sms_content_template, send_content_day) VALUES (888, 'Mobilink Service CPA', 'Mobilink Service CPA', '', '80f18d196bccf27562e56fe654f87a4d', 36, 2, 2, 10, 'Thank you for downloading, you will be charged in next ten days', 1, 115, '2016-08-10 08:24:12.792309', 0, 0, 0, '1970-01-01 03:00:00.000000', '36', null, 1440, 360, 0, 24, 10, false, null, '{}', '', '{}');
INSERT INTO public.xmp_services_old (id, name, description, keyword, url, price, id_payment_type, id_subscription_type, keep_days, wording, status, id_currency, created_at, channel_sms, channel_wap, channel_web, start_date, price_option, link, pull_msisdn_ttr, pull_retry_delay, sms_send, paid_hours, delay_hours, send_not_paid_text_enabled, not_paid_text, send_content_allowed_time, sms_content_template, send_content_day) VALUES (777, 'Mobilink Virtual Service', 'Mobilink Virtual Service', '', '80f18d196bccf27562e56fe654f87a4d', 36, 2, 2, 10, 'Thank you for downloading, you will be charged in next ten days', 1, 115, '2016-08-10 08:24:12.792309', 0, 0, 0, '1970-01-01 03:00:00.000000', '36', null, 1440, 360, 0, 24, 10, false, null, '{}', '', '{}');
select count(*) from pg_stat_activity where datname ='linkit_cheese';
SELECT
  pg_terminate_backend(pid)
FROM
  pg_stat_activity
WHERE
  -- don't kill my own connection!
  pid <> pg_backend_pid()
  -- don't kill the connections to other databases
  AND datname = 'linkit_cheese'