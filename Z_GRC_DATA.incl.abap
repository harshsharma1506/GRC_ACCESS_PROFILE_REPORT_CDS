*&---------------------------------------------------------------------*
*& Include          Z_GRC_DATA
*&---------------------------------------------------------------------*
TABLES: usr02,
        ust04,
        agr_define.

DATA: lv_name      TYPE usr02-bname,
      lr_columns   TYPE REF TO cl_salv_columns_table,
      lr_column    TYPE REF TO cl_salv_column_table,
      lr_alv       TYPE REF TO cl_salv_table,
      lt_grc_cds   TYPE STANDARD TABLE OF z_grc_tst1,
      gr_functions TYPE REF TO cl_salv_functions,
      gr_display   TYPE REF TO cl_salv_display_settings,
      ls_layout    TYPE salv_s_layout_info,
      ls_key       TYPE salv_s_layout_key,
      lt_prof      TYPE STANDARD TABLE OF bapiprof,
      lt_prof1     TYPE STANDARD TABLE OF bapiprof,
      lt_return    TYPE STANDARD TABLE OF bapiret2.
