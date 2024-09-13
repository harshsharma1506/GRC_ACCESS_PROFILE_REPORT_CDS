*&---------------------------------------------------------------------*
*& Include          Z_GRC_SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_name    FOR usr02-bname NO INTERVALS,
                  s_role    FOR agr_define-agr_name,
                  s_prof    FOR ust04-profile.
SELECTION-SCREEN: END OF BLOCK b1.

SELECTION-SCREEN: BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_layout    TYPE disvariant-variant.
SELECTION-SCREEN: END OF BLOCK b2.

SELECTION-SCREEN: BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP rad1,
              p_rad2 RADIOBUTTON GROUP rad1.
SELECTION-SCREEN: END OF BLOCK b3.
