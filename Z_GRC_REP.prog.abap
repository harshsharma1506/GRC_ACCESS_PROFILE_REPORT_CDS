REPORT z_grc_rep.
"Includes which will serve various purpose
INCLUDE: z_grc_data,         "data declaration / constants
         z_grc_sel,          "selection screen
         z_grc_cls.          "class and methods

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_layout.
  DATA(lo_obj) = NEW lcl_grc_fun( ).
  lo_obj->get_f4_variant( ).

START-OF-SELECTION.

  DATA(lo_obj1) = NEW lcl_grc_fun( ).
  lo_obj1->get_data_cds( ).
  lo_obj1->get_data_bapi( ).
  IF sy-subrc = 0.
    lo_obj1->display_data( ).
  ENDIF.
