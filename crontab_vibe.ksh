#####################################################################
#
#       SONY MUSIC ENTERTAINMENT LTD
#	   root user cron jobs
#
#####################################################################
#Syntax
#*     *     *     *     *  command to be executed
#^     ^     ^     ^     ^
#|     |     |     |     |
#|     |     |     |     +----- day of week (0 - 6) (Sunday=0)
#|     |     |     +------- month (1 - 12)
#|     |     +--------- day of month (1 - 31)
#|     +----------- hour (0 - 23)
#+------------- min (0 - 59)
#
#---------------------------------------------------------------------------
#
#  Vibe jobs - Daily
#
#---------------------------------------------------------------------------
# Temporary
#0,15,30,45 * * * * /scripts/ssa_rebuild_status.ksh 1>/dev/null 2>/dev/null
#0 15 * * * /home/vibe/bin/export_vibe_sales.ksh 1>/dev/null 2>/dev/null
#0,15,30,45 * * * 0 /home/vibe/bin/run_exec_statspack.ksh 1>/dev/null 2>/dev/null
#
# coverart lists
3 0 * * * /home/vibe/bin/run_coverart_list.ksh 1>/dev/null 2>/dev/null
#
# refresh file for Amazon ACFF feed
0 19 * * * /home/vibe/bin/run_wk_amazon_update.ksh 1>/dev/null 2>/dev/null
#
# make all files in  /misc/nfs_vibe/upload read-write for everyoone
#   until permission issue can be addressed 
0,5,10,15,20,25,30,35,40,45,50,55 * * * * /home/vibe/bin/chmod_nfs_upload.ksh 1>/dev/null 2>/dev/null
#
# generate and upload product info to ARIA
0 6 * * * /home/vibe/bin/aria_prod_upd.ksh 1>/dev/null 2>/dev/null
#
#  check SMEA ftp is functioning
0 7,12,16,21 * * * /home/vibe/bin/smeaftp_check.ksh 1>/dev/null 2>/dev/null
#
# daily Vibe backup - backs up RMAN files to tape
# note: vibe backup done by user oradba
# agy 8-Sep-2016. done in /home/vibe/bin/vibe_backup.ksh
#0 4 * * 2-6 /scripts/vibe_backup_totape.ksh 1>/dev/null 2>/dev/null
30 18 * * 1-5 /home/vibe/bin/vibe_backup.ksh > /apps/oracle/admin/VIBE/rman/log/VIBE_backup.sh.out 2>&1
#
#  copy files to Staging server
#1 2 * * * /scripts/rcp_vibebackup_stag.ksh 1>/dev/null 2>/dev/null
#
# make copy of scripts used in Vibe
0 3 * * * /scripts/backup_vibe_scripts.ksh 1>/dev/null 2>/dev/null
#
# monitor /oraarch usage
0,30 * * * * /home/vibe/bin/oraarch_snapshot.ksh 1>/dev/null 2>/dev/null
#
# monitor VNC run time
0 * * * * /home/vibe/bin/vnc_check.ksh 1>/dev/null 2>/dev/null
#
##0 10 8 9 * /home/vibe/bin/ay.ksh > /tmp/ay_test_backup 2>&1
#============================================================================
# ***** FOLLOWING JOBS ARE PART OF CDS/EDC run *****
#
# upload edc transactions into VIBE database
# Normal - comment out next line if EOM extended
# last EDC run was on 28-Apr-2017
#30 19 * * 1-5 /home/vibe/bin/run_edc_load.ksh > /tmp/run_edc_load_new.out 2> /dev/null
#19 8 14 4 * /home/vibe/bin/run_edc_load_short.ksh > /tmp/find_edctape.out 2> /dev/null
#
# CDS End of Day
30 23 * * 1-5 /home/vibe/bin/run_cds_eod.ksh >/tmp/run_cds_eod.out 2> /dev/null
#adhoc#58 8 10 11 * /home/vibe/bin/run_cds_eod.ksh >/tmp/run_cds_eod.out 2> /dev/null
#test#53 13 10 11 * /home/vibe/bin/run_cds_eod_test.ksh >/tmp/run_cds_eod.out 2> /dev/null
#
# check for presence of files from previous day on SMEA ftp
0 8 * * * /home/vibe/bin/ftp_edc_eod_check.ksh 1>/dev/null 2>/dev/null
#
# Update sales budget - issue with timing of customer load so 
#                       rerun sales budget
# Normal - comment out next line if EOM extended
0 5 * * 2-6 /home/vibe/bin/update_sales_budgets.ksh > /tmp/update_sales_budgets.out 2> /dev/null
# uncomment next 2 lines and change day, month for extended EOM
#0 2 * * 2-5 /home/vibe/bin/update_sales_budgets.ksh > /tmp/update_sales_budgets.out 2> /dev/null
#0 2 29 3 * /home/vibe/bin/update_sales_budgets.ksh > /tmp/update_sales_budgets.out 2> /dev/null
#
# sms budgets to sales
# Normal - comment out next line if EOM extended
0 8 * * 2-6 /home/vibe/bin/sms_budget.ksh >/dev/null 2>/dev/null
#TMcLean#0 7 * * 2-6 /home/vibe/bin/sms_budget_overall.ksh >/dev/null 2>/dev/null
#
# ***** ABOVE JOBS ARE PART OF CDS run *****
#===========================================================================
# ***** BELOW JOBS ARE CONSIGNMENT RELATED ******
# temporary - email shipped qty to sales until intranet is changed
#2019Apr11 not req#0 7 * * 2-6 /home/vibe/bin/sanity_consign_ship.ksh >/dev/null 2>/dev/null
#2019Apr11 not req#5 7 * * 2-6 /home/vibe/bin/bigw_consign_ship.ksh >/dev/null 2>/dev/null
#
# Load consignment detailed transactions from Vnet VMI
#0 20-22 * * * /home/vibe/bin/consign_detailtrans_run.ksh >/dev/null 2>/dev/null
0 2-4 * * * /home/vibe/bin/consign_detailtrans_run.ksh >/dev/null 2>/dev/null
#30 20-22 * * * /home/vibe/bin/consign_detailtrans_run_bigw.ksh >/dev/null 2>/dev/null
10 2-4 * * * /home/vibe/bin/consign_detailtrans_run_target.ksh >/dev/null 2>/dev/null
20 2-4 * * * /home/vibe/bin/consign_detailtrans_run_coles.ksh >/dev/null 2>/dev/null
30 2-4 * * * /home/vibe/bin/consign_detailtrans_run_bigw.ksh >/dev/null 2>/dev/null
50 2-4 * * * /home/vibe/bin/consign_detailtrans_run_jb.ksh >/dev/null 2>/dev/null
55 23 * * * /home/vibe/bin/consign_detail_dailycheck.ksh >/dev/null 2>/dev/null
35 5 * * * /home/vibe/bin/consign_sync_month.ksh >/dev/null 2>/dev/null
#
# Load consignment product flag exceptions from V-net VMI
5,35 18-22 * * * /home/vibe/bin/consign_prodexcp_run.ksh >/dev/null 2>/dev/null
#
# Load consignment ship vs receipts from V-net VMI
# 11-Jan-2016  data not sent or required
##10,40 16-22 * * * /home/vibe/bin/consign_shiprecpt_run.ksh >/dev/null 2>/dev/null
#
# check for missing consignment detail transactions from Vnet
0 3 * * 1 /home/vibe/bin/consign_detail_missing.ksh >/dev/null 2>/dev/null
#
# ***** ABOVE JOBS ARE CONSIGNMENT RELATED ******
#===========================================================================
# ***** BELOW JOBS ARE DIGITAL RELATED ******
#
# STARS
# process monthly STARS files
#0 7 15-27 * 6 /home/vibe/bin/run_stars_proc_exec.ksh 1>dev/null 2>/dev/null
3 5 15-27 * 6 /home/vibe/bin/run_stars_proc_exec.ksh 1>dev/null 2>/dev/null
0 10,12,14,16,18,20,22 15-27 * 6 /home/vibe/bin/stars_salesrev_status.ksh 1>dev/null 2>/dev/null
# review rejects
0 3 * * 3 /home/vibe/bin/stars_reject_review.ksh 1>dev/null 2>/dev/null
# re-process rejects
#0 7 26 1 * /home/vibe/bin/run_stars_reprocess_rejects.ksh 1>dev/null 2>/dev/null
# check for presence of STARS files on ftp
30 9 * * * /home/vibe/bin/stars_smeftp_check.ksh 1>dev/null 2>/dev/null
# check for presence of files in 'unprocessed' dir on Vibe server
33 9 * * * /home/vibe/bin/stars_dirfiles_check.ksh 1>dev/null 2>/dev/null
#
# CRDB daily dig prelim
# 22-Mar-2018 CRDB may be causing mv_dig_mkt_sales_refresh to fail. Blackout period
23 4-22 * * * /home/vibe/bin/run_crdb_prelim_daily.ksh 1>dev/null 2>/dev/null
#
# Bandit monthly sales
#11 5 3 * * /home/vibe/bin/digisales_banditfm_au.ksh 1>dev/null 2>/dev/null
#21 5 3 * * /home/vibe/bin/digisales_banditfm_nz.ksh 1>dev/null 2>/dev/null
#
# Spotify charts
#0,15,30,45 8-20 * * * /home/vibe/bin/spotify_charts_tdrive.ksh 1>dev/null 2>/dev/null
0 21 * * 0,6 /home/vibe/bin/run_spotify_charts_weekly.ksh 1>dev/null 2>/dev/null
15 * * * * /home/vibe/bin/run_spotify_charts_daily.ksh 1>dev/null 2>/dev/null
#
# Spotify Daily streams
#superceded by CRDB 21-Nov-2017# 8 0,5,12 * * * /home/vibe/bin/run_spotify_daily.ksh 1>dev/null 2>/dev/null
##45 8 10 11 * /home/vibe/bin/spotify_au_daily_backfill.ksh 1>dev/null 2>/dev/null
#
#
# check expiry date of Apple Reporter token
0 8 * * * /home/vibe/bin/apple_token_checkdate.ksh 1>dev/null 2>/dev/null
#
# check CRDB missing files
#done in BI#0 7,12,17 * * * /home/vibe/bin/crdb_check_content.ksh 1>dev/null 2>/dev/null
#
# Apple Daily streams
#autoingest#5,35 * * * * /home/vibe/bin/run_apple_sub_daily.ksh 1>dev/null 2>/dev/null
# do not run between 4am-7am as reports are refreshed
#superceded by CRDB 21-Nov-2017# 5,35 7-23 * * * /home/vibe/bin/run_apple_strm_daily_v2.ksh 1>dev/null 2>/dev/null
#superceded by CRDB 21-Nov-2017# 5,35 0-3 * * * /home/vibe/bin/run_apple_strm_daily_v2.ksh 1>dev/null 2>/dev/null
##6 14 2 12 * /home/vibe/bin/temp_apple_strm.ksh 1>dev/null 2>/dev/null
#
#  iTunes daily sales
#autoingest#0,15,30,45 10-23 * * * /home/vibe/bin/run_itunes_sales_daily.ksh 1>dev/null 2>/dev/null
0,15,30,45 10-23 * * * /home/vibe/bin/run_itunes_sales_daily_v2.ksh 1>dev/null 2>/dev/null
#temp - create java script to get itunes sales files and send to VIBESTAG#
#0 10-23 * * * /home/vibe/bin/itunes_sales_daily_get_v2_pc.ksh 1>dev/null 2>/dev/null
#temp - ingest files FTPed from VIBESTAG
#45 10,15,21 * * * /home/vibe/bin/itunes_sales_vibestag.ksh 1>dev/null 2>/dev/null
#
# iTunes daily pre orders
#autoingest#3,18,33,48 10-23 * * * /home/vibe/bin/run_itunes_presales_daily.ksh  1>dev/null 2>/dev/null
3,18,33,48 10-23 * * * /home/vibe/bin/run_itunes_presales_daily_v2.ksh  1>dev/null 2>/dev/null
#temp - create java script to get itunes presales files and send to VIBESTAG#
#5 10-23 * * * /home/vibe/bin/itunes_presales_daily_get_v2_pc.ksh  1>dev/null 2>/dev/null
#temp - ingest files FTPed from VIBESTAG
#58 19 * * * /home/vibe/bin/itunes_presales_vibestag.ksh 1>dev/null 2>/dev/null
#
# iTunes market share
#    redundant with Apple Reporter sales and trends
##3 7-17 * * * /home/vibe/bin/run_itunes_mktshare.ksh 1>dev/null 2>/dev/null
#
# ***** ABOVE JOBS ARE DIGITAL RELATED ******
#===========================================================================
#
# load ARIA survey (email from Adam Nicotera
55 13-20 * * 3 /home/vibe/bin/run_aria_survey_load_sched.ksh > /dev/null 2>/dev/null
55 7-18 * * 4-5 /home/vibe/bin/run_aria_survey_load_sched.ksh > /dev/null 2>/dev/null
#
# Anomaly - product master file
##0 20 * * * /home/vibe/bin/run_anomaly_prod_master.ksh > /dev/null 2>/dev/null
#
# Sharespace - create and send sales to CADREON
#  program ended Sun 12-Nov-2017
#18 * * * * /home/vibe/bin/run_sharespace_cadreon_sales.ksh > /dev/null 2>/dev/null
#
# JBHiFi non SBT sell scanned sales from Vnet
3 15 * * * /home/vibe/bin/jbhifi_nsbt_sellthru_run.ksh > /dev/null 2>/dev/null
#
# GRPS
0,30 0-6,20-21 * * * /home/vibe/bin/grps_unproc_msg.ksh > /dev/null 2>/dev/null
0,10,20,30,40,50 7-19 * * * /home/vibe/bin/grps_unproc_msg.ksh > /dev/null 2>/dev/null
#
# run Sophos AntiVirus
3 5  * * * /apps/sophos/scripts/sophos_run_daily.ksh 1>/dev/null 2>/dev/null
#41 11 * * * /apps/sophos/scripts/sophos_run_daily.ksh 1>/dev/null 2>/dev/null
#
# monitor Vibe disk usage
0 7,19 * * * /home/vibe/bin/vibe_disk_usage.ksh 1>/dev/null 2>/dev/null
#
# lock in release date/week
0 18 * * * /home/vibe/bin/set_cutoff_relweek.ksh 1>/dev/null 2>/dev/null
#
# GRAS updates from Oracle-GRAS replica
30 20 * * * /home/vibe/bin/gras_ora_sync.ksh 1>dev/null 2>/dev/null
#
# function to change catalogue numbers
3 5 * * 2-5 /home/vibe/bin/update_catalog_nos.ksh > /tmp/update_catalog_nos.out 2 >/dev/null
#
# send label copy requests to RAAS
0 22 * * 1-5 /home/vibe/bin/send_raas_request.ksh 1>/dev/null 2>/dev/null
#
# retrieve and load RAAS label copy
30 14 * * 2-6 /home/vibe/bin/get_raas_request.ksh 1>/dev/null 2>/dev/null
#
# Send Vibe reminders
0 8-20 * * * /home/vibe/bin/send_reminders.ksh 1>/dev/null 2>/dev/null
#
# Send Vibe emails for new release status change
0,30 7-20 * * 1-5 /home/vibe/bin/new_release_mail.ksh 1>/dev/null 2>/dev/null
#
# Run daily NZ jobs
#5 2 * * * /home/vibe/bin/run_nz_jobs.ksh > /dev/null 2> /dev/null
0 22 * * * /home/vibe/bin/run_nzti_eod.ksh > /dev/null 2> /dev/null
#
# materialized views
#3-may-2018 HMc# 5 4 * * * /home/vibe/bin/mv_catalog_refresh.ksh > /dev/null 2> /dev/null
30 7 * * * /home/vibe/bin/mv_integrity_check.ksh > /dev/null 2> /dev/null
11 3 * * * /home/vibe/bin/mv_dig_mthly_sales_refresh.ksh 1>dev/null 2>/dev/null
#25-may-2018 HMc# 31 3 * * * /home/vibe/bin/mv_dig_arch_mthly_sales_refresh.ksh 1>dev/null 2>/dev/null
#16-jan-2017 not required replaced with
#30 3 * * * /home/vibe/bin/run_bi_project_pl.ksh 1>dev/null 2>/dev/null
#
# EROS exception report
2 7 * * * /home/vibe/bin/eros_send_errpt.ksh > /dev/null 2> /dev/null
#
# interfaces from NAV
#SAP#12 5 * * * /home/vibe/bin/find_nav_label.ksh 1>/dev/null 2>/dev/null
#SAP#22 5 * * * /home/vibe/bin/find_nav_project.ksh 1>/dev/null 2>/dev/null
#SAP#32 5 * * * /home/vibe/bin/find_nav_vendor.ksh 1>/dev/null 2>/dev/null
#
# Load Supplier info from JDE (ftp'ed directly onto Vibe server from JDE)
0,10,20,30,40,50 7-20 * * 1-5 /home/vibe/bin/find_fin_supplier.ksh >/dev/null 2>/dev/null
#
# Close approved PO lines
0 20 * * 1-5 /home/vibe/bin/close_approved_polines.ksh > /dev/null 2>/dev/null
#
# Send Vibe Revision Notes every 15 minutes
0,15,30,45 7-20 * * 1-5 /home/vibe/bin/send_rev_notes.ksh > /dev/null 2> /dev/null
#
# Carry out VIBE catalogue checks
0 4 * * 1-6 /home/vibe/bin/vibe_catalog_check > /dev/null 2> /dev/null
#
# Disable the EDC catalogue triggers at 10pm
# 17Nov2016 - not req.
#0 22 * * 1-5 /home/vibe/bin/disable_edc_triggers.ksh > /dev/null 2> /dev/null
#
# Enable the EDC catalogue triggers at 6am
# 17Nov2016 - not req.
#0 6 * * 1-6 /home/vibe/bin/enable_edc_triggers.ksh > /dev/null 2> /dev/null
# disable GRPS message processing
0 22 * * 1-5 /home/vibe/bin/grps_msg_translate_disable.ksh > /dev/null 2> /dev/null
#
# Enable GRPS message processing
0 6 * * 1-6 /home/vibe/bin/grps_msg_translate_enable.ksh > /dev/null 2> /dev/null
#
# Send VIBE Cata updates file to SonyDADC every 15 minutes
#cds#0,15,30,45 8-20 * * 1-5 /home/vibe/bin/create_edc_cata.ksh >/dev/null 2> /dev/null
#cds#0 8-20 * * 6 /home/vibe/bin/create_edc_cata.ksh >/dev/null 2> /dev/null
#cds#0 9 * * 0 /home/vibe/bin/create_edc_cata.ksh >/dev/null 2> /dev/null
0,15,30,45 8-20 * * 1-5 /home/vibe/bin/create_cds_cata.ksh >/dev/null 2> /dev/null
0 8-20 * * 6 /home/vibe/bin/create_cds_cata.ksh >/dev/null 2> /dev/null
0 9 * * 0 /home/vibe/bin/create_cds_cata.ksh >/dev/null 2> /dev/null
#
# NZ Total Interactive catalogue updates
#not req- only returns#0 5-18 * * 1-5 /home/vibe/bin/create_nzti_cata.ksh >/dev/null 2> /dev/null
#
# Send SonyDADC Cata with Dealer Grp and consign flag file twice a day
#cds#45 11,16 * * 1-5 /home/vibe/bin/create_edc_catadlrgrp.ksh
#cds#45 16 * * 6 /home/vibe/bin/create_edc_catadlrgrp.ksh
45 11,16 * * 1-5 /home/vibe/bin/create_cds_catadlrgrp.ksh
45 16 * * 6 /home/vibe/bin/create_cds_catadlrgrp.ksh
#
# Process manufacturing PO from SonyDADC
#edc#10,25,40,55 7-20 * * 1-5 /home/vibe/bin/find_edc_po.ksh > /dev/null 2> /dev/null
10,25,40,55 7-20 * * 1-5 /home/vibe/bin/find_cds_po.ksh > /dev/null 2> /dev/null
#
# Update Online Artist Catalogues every night
45 4 * * 1-6 /home/vibe/bin/online_artist_update.ksh > /dev/null 2> /dev/null
#
# Update Financial Reports
0 8 * * 1-5 /home/vibe/bin/proj_reports.ksh > /dev/null 2> /dev/null
#
# Create Dummy Price Code
0 8 * * 1-5 /home/vibe/bin/create_dummy_price_code.ksh > /dev/null 2> /dev/null
#
# Send VIBE Project Mmgmnt emails
0,30 8-20 * * 1-5  /home/vibe/bin/vibe_invoice_email.ksh > /dev/null 2> /dev/null
#
# load open orders and expected delivery dates from DADC
#edc#0 9,13,17 * * 1-5 /home/vibe/bin/davi_01_openorders.ksh > /dev/null 2>/dev/null
#
# Send email from Vibe db
0 7-21 * * * /home/vibe/bin/email_vibe_msg.ksh > /dev/null 2>/dev/null
#
# Update track listing for Intranet/B2B
30 4 * * 1-5 /home/vibe/bin/update_sales_tracklist.ksh >/dev/null 2>/dev/null
#
# Calculate ACTUAL sales and spend values for Project Management System
0 7 * * 1-5 /home/vibe/bin/proj_cal_actual.ksh >/dev/null 2>&1
#
# Send Catalogue updates to Vnet VMI
0 21 * * * /home/vibe/bin/visionvmi_catupd.ksh > /dev/null 2>&1
#
# Create and send artist info to smeanet_sql
40 4 * * 1-5 /home/vibe/bin/push_notes_artist.ksh > /dev/null 2>&1
#
# Backup /home/vibe (application scripts)
#0 19 * * 1-5 /scripts/backup_vibeHOME.ksh > /dev/null 2> /dev/null
#
# Run Compass SOH report
#0 06 * * 1-5 /home/vibe/bin/compass_soh.ksh > /dev/null 2> /dev/null
#
# List locked objects in Vibe
30 16 * * 1-5 /home/vibe/bin/list_locks.ksh > /dev/null 2>/dev/null
#
#
# snapshots of the budget/PO tables for EOM
30 23 * * * /home/vibe/bin/vibe_po_snapshot.ksh >/dev/null 2>/dev/null
#
# set status of catas to AAS
0 5 * * * /home/vibe/bin/set_recent_release_status.ksh > /dev/null 2>/dev/null
#
# cleanup interface directories
30 5 * * * /home/vibe/bin/vibe_ifs_cleanup.ksh > /dev/null 2>/dev/null
#
# cleanup /misc dir
30 4 * * * /home/vibe/bin/miscdir_cleanup.ksh > /dev/null 2>/dev/null
#
# cleanup /vibeupload dir
30 4 * * * /home/vibe/bin/vibeupload_cleanup.ksh > /dev/null 2>/dev/null
#
# Vibe - invalid db packages
30 16 * * * /home/vibe/bin/vibe_invalid_pkg.ksh > /dev/null 2>/dev/null
#
#---------------------------------------------------------------------------
#
#  Vibe jobs - Weekly
#
#---------------------------------------------------------------------------
#
#MJ req removal 18jun2018#0 8 * * 1 /home/vibe/bin/temp_stream_rpt.ksh > /dev/null 2>/dev/null
#
# match previously unmatched daily prelim
0 8 * * 0 /home/vibe/bin/dig_daily_prelim_match.ksh > /dev/null 2>/dev/null
#
# Radio Airplay
#deal expired#8 7 * * 1 /home/vibe/bin/run_radio_airplay_rcs.ksh > /dev/null 2>/dev/null
#user not downloading files#10 7-18 * * 1-3 /home/vibe/bin/run_tmn_airplay.ksh > /dev/null 2>/dev/null
#user not downloading files#15 7-18 * * 1-3 /home/vibe/bin/run_shazam_airplay.ksh > /dev/null 2>/dev/null
15 16 * * * /home/vibe/bin/run_tmn_hot100.ksh > /dev/null 2>/dev/null
#
# Radio Monitor
0 8 * * 1 /home/vibe/bin/run_radio_monitor.ksh > /dev/null 2>/dev/null
#
# product master audit trail report
0 21 * * 0 /home/vibe/bin/prod_master_updates.ksh > /dev/null 2>/dev/null
#
# active SMEA catas for MMS
#   disabled 7-Apr-2017
#30 7 * * 1 /home/vibe/bin/smea_active_prod.ksh > /dev/null 2>/dev/null
#
0 12 * * 0 /home/vibe/bin/vibe_weekly_checks.ksh > /dev/null 2>/dev/null
#
# Sanity Consignment SOH
30 2 * * 0 /home/vibe/bin/consign_soh_value.ksh > /dev/null 2>/dev/null
#
# purge recycle bin
0 3 * * 1 /home/vibe/bin/create_purge_recyclebin.ksh /dev/null 2>/dev/null
#
# backup Vibe sales journals created during month end
0 6 * * 1 /home/vibe/bin/salesjrnl_backup.ksh > /dev/null 2>/dev/null
#
# List of DSPs where no sales have been received
#not needed 26-mar-2018#45 3 * * 1 /home/vibe/bin/digisales_dsp_nosales.ksh /dev/null 2>/dev/null
#
# get Sunday date for iTunes sales
0 1,12,20 * * 0 /home/vibe/bin/get_sunday_date.ksh >/dev/null 2>/dev/null
#
30 6 * * 1 /home/vibe/bin/email_recent_catalogues.ksh > /dev/null 2>/dev/null
#
# email SOR=N catas
#    disabled 7-Apr-2017
#0 6 * * 1 /home/vibe/bin/email_sor_cats.ksh > /dev/null 2>/dev/null
#
# FTP indent Germany orders
#0 7 * * * /home/vibe/bin/run_indent_germany.ksh >/dev/null 2>/dev/null
#
# one stop email
0 22 * * 6 /home/vibe/bin/onestop_email.ksh >/dev/null 2>/dev/null
# Set Sales reports - weekly
0 5 * * 0 /home/vibe/bin/set_salesrpt_weekly.ksh >/dev/null 2>/dev/null
#
# Load ARIA charts
#8 17 * * 5 /home/vibe/bin/run_ariaxml_load_new.ksh > /dev/null 2>/dev/null
#44 21 2 9 * /home/vibe/bin/run_ariaxml_load_new.ksh > /dev/null 2>/dev/null
30 16 * * 5 /home/vibe/bin/aria_chart_loop.ksh > /dev/null 2>/dev/null
##46 9 8 1 * /home/vibe/bin/aria_chart_loop.ksh > /dev/null 2>/dev/null
8 10 * * 1-5 /home/vibe/bin/ariachart_reissue_check.ksh > /dev/null 2>/dev/null
# check Aria's ftp server in case password has changed
0 9,16 * * 2-5 /home/vibe/bin/ariachart_smeftp_check.ksh > /dev/null 2>/dev/null
# generate Monday's date - used to check Aria Chart file for old data
0 8 * * 1 /home/vibe/bin/aria_chart_date.ksh > /dev/null 2>/dev/null
#
# iTunes charts
0 12 * * * /home/vibe/bin/itunes_charts_xml_run.ksh > /dev/null 2>/dev/null
##0 * * * * /home/vibe/ifs/itunes_charts/script/itunes_charts_au_builddate.ksh > /dev/null 2>/dev/null
#
# archive sales data
#0 1 * * 0 /home/vibe/bin/arch_sales_edc_tape.ksh > /dev/null 2>/dev/null
0 3 * * 0 /home/vibe/bin/arch_sales_daily_sales.ksh > /dev/null 2>/dev/null
0 4 * * 0 /home/vibe/bin/arch_sales_journals.ksh > /dev/null 2>/dev/null
#0 5 * * 0 /home/vibe/bin/arch_sales_edc_stk.ksh > /dev/null 2>/dev/null
#0 11 * * 0 /home/vibe/bin/arch_sales_digital_sales.ksh > /dev/null 2>/dev/null
#
#---------------------------------------------------------------------------
#
#  Vibe jobs - Monthly
#
#---------------------------------------------------------------------------
# document server info
0 3 1 * * /scripts/rsx04_server_info.ksh > /dev/null 2>/dev/null
#
# Classification report for aria
0 3 10 * * /home/vibe/bin/send_mthly_classification.ksh > /dev/null 2>/dev/null
#
# Digital REvenue Tracker upload file
#   disabled 7-Apr-2017
#0 3 3 * * /home/vibe/bin/dig_revenue_tracker.ksh > /dev/null 2>/dev/null
#
# Label copy for RAPNZ
0 3 15 * * /home/vibe/bin/run_rapnz_labcopy.ksh > /dev/null 2>/dev/null
#
#---------------------------------------------------------------------------
#
#  Vibe jobs - One offs
#
#---------------------------------------------------------------------------
#
#2 3 22 3 * /home/vibe/bin/vibe_oneoff.ksh > /dev/null 2>/dev/null
##0 4 1 10 * /home/vibe/bin/pd_roy_pay.ksh > /dev/null 2>/dev/null
#
#---------------------------------------------------------------------
#
# Unix system jobs 
#
#---------------------------------------------------------------------
# send logs of sulog, failed logins and root logins to T drive
1 0 * * * /apps/sys/scripts/sysadminlogs.ksh > /apps/sys/scripts/sysadminlogs.log 2>/apps/sys/scripts/sysadminlogs.err
#
# disk and Vibe tablespace usage
0 6 * * * /scripts/sys_db_daily_info.ksh > /dev/null 2>/dev/null
#
#  check free space in RBSLARGE
#30 16 * * * /home/vibe/bin/rbslarge_check.ksh > /dev/null 2>/dev/null
#
# monitor paging space
0,10,20,30,40,50 7-23 * * * /scripts/paging_space_check.ksh > /dev/null 2>/dev/null
#
# monitor CPU usage
18 8,13,17 * * * /scripts/monitor_cpu.ksh > /dev/null 2>/dev/null
#
#start daylight savings - Not required on Vibe720
#1 2 7 10 * /usr/bin/date 10070306
#
#end daylight savings  - Not required on Vibe720
#5 3 7 4 * /scripts/end_dst.ksh
#
# backup cron files
0 0,12 * * * /scripts/cron_backup.ksh > /dev/null 2>/dev/null
#
# clear dpid2 log files - fills up /var
# agy 6/8/05 stopped - not required?
#0,10,20,30,40,50 * * * * /scripts/rm_dpid2_log.ksh
#
# File system check every 1 hour
0 * * * * /scripts/fs_check.ksh > /dev/null 2> /dev/null
#
# Check disk usage of /vibebackup
0 4,8,12,16,22 * * * /scripts/vibebackup_fs_check.ksh > /dev/null 2>/dev/null
#
# check system error log
0 8-20 * * * /scripts/email_errlog.ksh > /dev/null 2> /dev/null
#
# check disk usage
0 8,12,16 * * * /scripts/check_diskusage.ksh > /dev/null 2> /dev/null
#0 8,12,16 * * * /scripts/email_diskuse.ksh > /dev/null 2> /dev/null
#
#45 2 * * 0 /usr/lib/spell/compress
#45 23 * * * ulimit 5000; /usr/lib/smdemon.cleanu > /dev/null
#
################# THE END  ###################
