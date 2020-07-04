*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*

TYPE-POOLS:
 abap,
 vrm.

CLASS cl_main DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ts_no_sum,
        group   TYPE string,
        caption TYPE string,
        date    TYPE d,
      END OF ts_no_sum,

      " Random table data
      BEGIN OF ts_rand_data.
        INCLUDE TYPE ts_no_sum.
    TYPES:
      sum1 TYPE bf_rbetr, " P with sign
      sum2 TYPE bf_rbetr, " P with sign
      END OF ts_rand_data,
      tt_rand_data TYPE STANDARD TABLE OF ts_rand_data WITH DEFAULT KEY,

      " 1 example
      BEGIN OF ts_screen_opt,
        key              TYPE char5,
        show_row_count   TYPE abap_bool,
        show_colum_count TYPE abap_bool,
        show_block_count TYPE abap_bool,
        show_zip         TYPE abap_bool,
        class_name       TYPE string,
        template         TYPE string,
      END OF ts_screen_opt,
      tt_screen_opt TYPE SORTED TABLE OF ts_screen_opt WITH UNIQUE KEY key,

      " Tree structure
      BEGIN OF ts_tree_05.
        INCLUDE TYPE ts_rand_data. " random data
    TYPES:
      ch_count TYPE i, " New field for trees
      END OF ts_tree_05,
      tt_tree_05 TYPE STANDARD TABLE OF ts_tree_05 WITH DEFAULT KEY,

      BEGIN OF ts_tree_06,
        " Folders hierarchy
        dir          TYPE string,
        par_dir      TYPE string,

        " Empty field. Filled in on_prepare_tree_06
        level        TYPE i,

        sum          TYPE bf_rbetr,
        has_children TYPE abap_bool,
      END OF ts_tree_06,
      tt_tree_06 TYPE STANDARD TABLE OF ts_tree_06 WITH DEFAULT KEY,

      " 1 demo
      BEGIN OF ts_file,
        kind     TYPE string,
        template TYPE string,
        report   TYPE string,
      END OF ts_file,

      BEGIN OF ts_merge_param,
        key TYPE string,
        val TYPE REF TO data,
      END OF ts_merge_param,

      BEGIN OF ts_demo,
        id    TYPE num2,
        label TYPE string,
        files TYPE STANDARD TABLE OF ts_file WITH DEFAULT KEY,
        merge TYPE HASHED TABLE OF ts_merge_param WITH UNIQUE KEY key,
      END OF ts_demo,
      tt_demo TYPE STANDARD TABLE OF ts_demo WITH DEFAULT KEY.

    METHODS:
      " INITIALIZATION
      constructor,

      " AT SELECTION-SCREEN OUTPUT
      pbo,

      " AT SELECTION-SCREEN
      pai
        IMPORTING
          cv_cmd TYPE syucomm,

      " START-OF-SELECTION
      start_of_selection
        IMPORTING
          iv_file_name TYPE csequence OPTIONAL,

      check_break_point_id,

      f4_full_path
        IMPORTING
          iv_title    TYPE csequence
        CHANGING
          cv_fullpath TYPE csequence,

      f4_dir_browse
        IMPORTING
          iv_title TYPE csequence
        CHANGING
          cv_path  TYPE csequence,

      " Basic example
      example_01                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      example_02                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      example_03                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      example_04                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      example_05                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      on_prepare_tree_05 FOR EVENT prepare_tree OF zcl_xtt_replace_block
        IMPORTING
            ir_tree      " Type Ref To ZCL_XTT_REPLACE_BLOCK=>TS_TREE
            ir_data      " Type Ref To DATA
            ir_sub_data, " Type Ref To DATA

      example_06                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      on_prepare_tree_06 FOR EVENT prepare_tree OF zcl_xtt_replace_block
        IMPORTING
            ir_tree
            ir_data,

      fill_with_folders
        IMPORTING
          iv_dir    TYPE csequence
          iv_sep    TYPE char1
        CHANGING
          ct_folder TYPE tt_tree_06,

      example_07                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      on_prepare_raw_07 FOR EVENT prepare_raw OF zcl_xtt
        IMPORTING
            sender
            ir_content, " Type Ref To XSTRING

      on_pbo_07 FOR EVENT pbo_event OF zif_eui_manager
        IMPORTING
            sender
            io_container,

      check_ole_07
        IMPORTING
          io_ole_app TYPE ole2_object,

      example_08                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      example_09                                            "#EC CALLED
        IMPORTING
                  iv_class_name TYPE csequence
                  iv_template   TYPE csequence
        RETURNING VALUE(ro_xtt) TYPE REF TO zcl_xtt,

      jekyll_export_all
        IMPORTING
          it_list TYPE vrm_values,

      jekyll_add_json
        IMPORTING
                  iv_key          TYPE string DEFAULT 'R'
                  i_value         TYPE any
        RETURNING VALUE(rv_go_on) TYPE abap_bool.

    CLASS-METHODS:
      " Random data for tables
      get_random_table
        IMPORTING
          iv_column_cnt TYPE numc2 DEFAULT 2
        EXPORTING
          et_table      TYPE STANDARD TABLE.

    DATA:
      mt_screen_opt TYPE tt_screen_opt,
      ms_cur_demo   TYPE REF TO ts_demo.
ENDCLASS.
