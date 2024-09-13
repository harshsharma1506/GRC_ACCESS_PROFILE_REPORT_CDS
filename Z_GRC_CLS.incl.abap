&---------------------------------------------------------------------*
*& Include          Z_GRC_CLS
*&---------------------------------------------------------------------*
CLASS lcl_grc_fun DEFINITION.
  PUBLIC SECTION.
    METHODS: get_data_cds,
      get_data_bapi,
      get_f4_variant,
      display_data.
  PROTECTED SECTION.
    METHODS: get_alv.
ENDCLASS.

CLASS lcl_grc_fun IMPLEMENTATION.
  METHOD get_data_cds.
    IF p_rad1 = 'X'.
      LOOP AT s_name[] INTO s_name.
        lv_name = s_name-low.
        SELECT *
         FROM z_grc_tst1( p_name = @lv_name )
         WHERE profile IN @s_prof
         AND   agr_name IN @s_role
         APPENDING CORRESPONDING FIELDS OF TABLE @lt_grc_cds.
        IF sy-subrc <> 0.
          DATA(lv_msg) = 'data not found for' && space && s_name-low.
          MESSAGE: lv_msg TYPE 'I'.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD get_data_bapi.
    IF p_rad2 = 'X'.
      LOOP AT s_name[] INTO s_name.
        CALL FUNCTION 'BAPI_USER_GET_DETAIL'
          EXPORTING
            username = s_name-low
          TABLES
            profiles = lt_prof
            return   = lt_return.
        APPEND LINES OF lt_prof to lt_prof1.
      ENDLOOP.
      lt_prof = lt_prof1.
    ENDIF.
  ENDMETHOD.
  METHOD get_f4_variant.
    ls_key-report = sy-repid.

    ls_layout = cl_salv_layout_service=>f4_layouts(
    s_key    = ls_key
    restrict = cl_salv_layout=>restrict_none  ).

    p_layout = ls_layout-layout.
  ENDMETHOD.

  METHOD get_alv.
    IF p_rad1 = 'X'.
      TRY.
          CALL METHOD cl_salv_table=>factory
            IMPORTING
              r_salv_table = lr_alv   " Basis Class Simple ALV Tables
            CHANGING
              t_table      = lt_grc_cds.
        CATCH cx_salv_wrong_call.
      ENDTRY.
      ELSE.
        TRY.
          CALL METHOD cl_salv_table=>factory
            IMPORTING
              r_salv_table = lr_alv   " Basis Class Simple ALV Tables
            CHANGING
              t_table      = lt_prof.
        CATCH cx_salv_wrong_call.
      ENDTRY.
    ENDIF.

    gr_display = lr_alv->get_display_settings( ). "Display Settings
*  Header
    gr_display->set_list_header( 'GRC Roles & Profile Report' ). " Heading for the ALV

*   Zebra pattern
    gr_display->set_striped_pattern( abap_true ). " To set the striped Pattern
    gr_functions = lr_alv->get_functions( ).
    gr_functions->set_all( ).
    DATA: gr_layout TYPE REF TO cl_salv_layout.
    DATA: key TYPE salv_s_layout_key.

    gr_layout = lr_alv->get_layout( ).
    key-report = sy-repid.
    gr_layout->set_initial_layout( p_layout ).
    gr_layout->set_key( key ).
    gr_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).

    lr_columns = lr_alv->get_columns( ).
    IF p_rad1 = 'X'.
      TRY.
          lr_column ?= lr_columns->get_column( 'TYPE_USER' ).
          lr_column->set_long_text('User Type').
        CATCH cx_salv_not_found.
      ENDTRY.
    ENDIF.
  ENDMETHOD.
  METHOD display_data.
    me->get_alv( ).
    lr_alv->display( ).
  ENDMETHOD.
ENDCLASS.
