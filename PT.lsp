(defun C:PT (/ dcl_id dcl_file result option custom_val ss ent obj_list obj thickness sub_option 
              custom_val1 custom_val2 custom_val3)
  
  ;; DCL 파일 자동 생성
  (setq dcl_file (strcat (getvar "ROAMABLEROOTPREFIX") "copy_object.dcl"))
  
  (setq f (open dcl_file "w"))
  (write-line "copy_object : dialog {" f)
  (write-line "  label = \"포장 TYPE\";" f)
  (write-line "  : radio_row {" f)
  (write-line "    : column {" f)
  (write-line "      label = \"ASP\";" f)
  (write-line "      : radio_button { key = \"asp1\"; label = \"5-10-22\"; value = \"1\"; }" f)
  (write-line "      : radio_button { key = \"asp2\"; label = \"5-12-20\"; }" f)
  (write-line "      : radio_button { key = \"asp3\"; label = \"5-6-12-22\"; }" f)
  (write-line "    }" f)
  (write-line "    : column {" f)
  (write-line "      label = \"ASP덧씌우기\";" f)
  (write-line "      : radio_button { key = \"asp_over\"; label = \"5\"; }" f)
  (write-line "    }" f)
  (write-line "    : column {" f)
  (write-line "      label = \"CON'C\";" f)
  (write-line "      : radio_button { key = \"conc\"; label = \"20-20\"; }" f)
  (write-line "    }" f)
  (write-line "    : column {" f)
  (write-line "      label = \"보도\";" f)
  (write-line "      : radio_button { key = \"sido1\"; label = \"6-4-10\"; }" f)
  (write-line "      : radio_button { key = \"sido2\"; label = \"8-3-15\"; }" f)
  (write-line "    }" f)
  (write-line "    : column {" f)
  (write-line "      label = \"자전거도로\";" f)
  (write-line "      : radio_button { key = \"bike\"; label = \"도막-10-20\"; }" f)
  (write-line "    }" f)
  (write-line "    : column {" f)
  (write-line "      label = \"직접작성(cm)\";" f)
  (write-line "      : radio_button { key = \"custom\"; label = \"[  ]-[  ]-[  ]\"; }" f)
  (write-line "    }" f)
  (write-line "  }" f)
  (write-line "  : row {" f)
  (write-line "    : text {" f)
  (write-line "      label = \"직접작성 값(cm):\";" f)
  (write-line "    }" f)
  (write-line "    : edit_box {" f)
  (write-line "      key = \"custom_input1\";" f)
  (write-line "      edit_width = 8;" f)
  (write-line "    }" f)
  (write-line "    : text {" f)
  (write-line "      label = \"-\";" f)
  (write-line "    }" f)
  (write-line "    : edit_box {" f)
  (write-line "      key = \"custom_input2\";" f)
  (write-line "      edit_width = 8;" f)
  (write-line "    }" f)
  (write-line "    : text {" f)
  (write-line "      label = \"-\";" f)
  (write-line "    }" f)
  (write-line "    : edit_box {" f)
  (write-line "      key = \"custom_input3\";" f)
  (write-line "      edit_width = 8;" f)
  (write-line "    }" f)
  (write-line "  }" f)
  (write-line "  : row {" f)
  (write-line "    fixed_width = true;" f)
  (write-line "    alignment = centered;" f)
  (write-line "    : button {" f)
  (write-line "      key = \"accept\";" f)
  (write-line "      label = \"확인\";" f)
  (write-line "      is_default = true;" f)
  (write-line "      fixed_width = true;" f)
  (write-line "      width = 12;" f)
  (write-line "    }" f)
  (write-line "    : button {" f)
  (write-line "      key = \"cancel\";" f)
  (write-line "      label = \"취소\";" f)
  (write-line "      is_cancel = true;" f)
  (write-line "      fixed_width = true;" f)
  (write-line "      width = 12;" f)
  (write-line "    }" f)
  (write-line "  }" f)
  (write-line "}" f)
  (close f)
  
  ;; DCL 파일 로드
  (setq dcl_id (load_dialog dcl_file))
  
  (if (not (new_dialog "copy_object" dcl_id))
    (progn
      (alert "DCL 파일을 로드할 수 없습니다.")
      (exit)
    )
  )
  
  ;; 기본값 설정
  (set_tile "asp1" "1")
  (setq option "asp1")
  
  ;; 모든 라디오 버튼 해제 함수
  (defun unset-all-radios ()
    (set_tile "asp1" "0")
    (set_tile "asp2" "0")
    (set_tile "asp3" "0")
    (set_tile "asp_over" "0")
    (set_tile "conc" "0")
    (set_tile "sido1" "0")
    (set_tile "sido2" "0")
    (set_tile "bike" "0")
    (set_tile "custom" "0")
  )
  
  ;; 액션 설정 - 각 버튼 클릭 시 다른 버튼 모두 해제
  (action_tile "asp1" "(unset-all-radios)(set_tile \"asp1\" \"1\")(setq option \"asp1\")")
  (action_tile "asp2" "(unset-all-radios)(set_tile \"asp2\" \"1\")(setq option \"asp2\")")
  (action_tile "asp3" "(unset-all-radios)(set_tile \"asp3\" \"1\")(setq option \"asp3\")")
  (action_tile "asp_over" "(unset-all-radios)(set_tile \"asp_over\" \"1\")(setq option \"asp_over\")")
  (action_tile "conc" "(unset-all-radios)(set_tile \"conc\" \"1\")(setq option \"conc\")")
  (action_tile "sido1" "(unset-all-radios)(set_tile \"sido1\" \"1\")(setq option \"sido1\")")
  (action_tile "sido2" "(unset-all-radios)(set_tile \"sido2\" \"1\")(setq option \"sido2\")")
  (action_tile "bike" "(unset-all-radios)(set_tile \"bike\" \"1\")(setq option \"bike\")")
  (action_tile "custom" "(unset-all-radios)(set_tile \"custom\" \"1\")(setq option \"custom\")")
  (action_tile "custom_input1" "(setq custom_val1 $value)")
  (action_tile "custom_input2" "(setq custom_val2 $value)")
  (action_tile "custom_input3" "(setq custom_val3 $value)")
  (action_tile "accept" "(setq result T)(done_dialog)")
  (action_tile "cancel" "(setq result nil)(done_dialog)")
  
  (start_dialog)
  (unload_dialog dcl_id)
  
  ;; 대화상자가 확인으로 닫혔으면 처리
  (if result
    (progn
      ;; 객체 선택
      (princ "\n객체를 선택하세요: ")
      (setq ss (ssget))
      
      (if ss
        (progn
          ;; 선택한 모든 객체 처리
          (setq idx 0)
          (repeat (sslength ss)
            (setq ent (ssname ss idx))
            (setq obj (vlax-ename->vla-object ent))
            
            (cond
              ;; ASP 옵션 1: 5-10-22 (0.05, 0.1, 0.22 순차적으로 아래로)
              ((= option "asp1")
               (setq new_obj1 (copy-object-y-down obj 0.05))
               (setq new_obj2 (copy-object-y-down new_obj1 0.1))
               (setq last_obj (copy-object-y-down new_obj2 0.22))
              )
              
              ;; ASP 옵션 2: 5-12-20 (0.05, 0.12, 0.2 순차적으로)
              ((= option "asp2")
               (setq new_obj1 (copy-object-y-down obj 0.05))
               (setq new_obj2 (copy-object-y-down new_obj1 0.12))
               (setq last_obj (copy-object-y-down new_obj2 0.2))
              )
              
              ;; ASP 옵션 3: 5-6-12-22 (0.05, 0.06, 0.12, 0.22 순차적으로)
              ((= option "asp3")
               (setq new_obj1 (copy-object-y-down obj 0.05))
               (setq new_obj2 (copy-object-y-down new_obj1 0.06))
               (setq new_obj3 (copy-object-y-down new_obj2 0.12))
               (setq last_obj (copy-object-y-down new_obj3 0.22))
              )
              
              ;; ASP덧씌우기: 5 (0.05)
              ((= option "asp_over")
               (setq last_obj (copy-object-y-down obj 0.05))
              )
              
              ;; CON'C: 20-20 (0.2, 0.2 순차적으로)
              ((= option "conc")
               (setq new_obj1 (copy-object-y-down obj 0.2))
               (setq last_obj (copy-object-y-down new_obj1 0.2))
               (add-text-between-objects obj new_obj1 "CON'C")
              )
              
              ;; 보도 옵션 1: 6-4-10 (0.06, 0.04, 0.1 순차적으로)
              ((= option "sido1")
               (setq new_obj1 (copy-object-y-down obj 0.06))
               (setq new_obj2 (copy-object-y-down new_obj1 0.04))
               (setq last_obj (copy-object-y-down new_obj2 0.1))
              )
              
              ;; 보도 옵션 2: 8-3-15 (0.08, 0.03, 0.15 순차적으로)
              ((= option "sido2")
               (setq new_obj1 (copy-object-y-down obj 0.08))
               (setq new_obj2 (copy-object-y-down new_obj1 0.03))
               (setq last_obj (copy-object-y-down new_obj2 0.15))
              )
              
              ;; 자전거도로: 도막-10-20 (원본 두께 0.003, 0.1 아래 복사 두께 0, 다시 0.2 아래)
              ((= option "bike")
               ;; 원본 객체 두께를 0.003으로 변경
               (if (vlax-property-available-p obj 'Thickness)
                 (vlax-put-property obj 'Thickness 0.003)
               )
               ;; 0.1 아래 복사 (두께 0)
               (setq new_obj1 (copy-object-y-down obj 0.1))
               (if (and new_obj1 (vlax-property-available-p new_obj1 'Thickness))
                 (vlax-put-property new_obj1 'Thickness 0.0)
               )
               ;; 그 위치에서 0.2 아래 복사
               (setq last_obj (copy-object-y-down new_obj1 0.2))
               (add-text-between-objects obj new_obj1 "자전거도로")
              )
              
              ;; 직접작성 (cm를 m로 변환)
              ((= option "custom")
               (if (and custom_val1 custom_val2 custom_val3)
                 (progn
                   ;; cm를 m로 변환 (10cm = 0.1m)
                   (setq dist1 (/ (atof custom_val1) 100.0))
                   (setq dist2 (/ (atof custom_val2) 100.0))
                   (setq dist3 (/ (atof custom_val3) 100.0))
                   (if (and (> dist1 0) (> dist2 0) (> dist3 0))
                     (progn
                       (setq new_obj1 (copy-object-y-down obj dist1))
                       (setq new_obj2 (copy-object-y-down new_obj1 dist2))
                       (setq last_obj (copy-object-y-down new_obj2 dist3))
                     )
                     (alert "모든 값은 0보다 커야 합니다.")
                   )
                 )
                 (alert "직접작성 값 3개를 모두 입력하세요.")
               )
              )
            )
            (setq idx (1+ idx))
          )
          (princ (strcat "\n" (itoa (sslength ss)) "개의 객체가 처리되었습니다."))
        )
        (princ "\n선택된 객체가 없습니다.")
      )
    )
  )
  
  (princ)
)

;; 객체를 Y축 아래로 복사하는 함수
(defun copy-object-y-down (obj distance / new_obj offset result)
  (setq new_obj nil)
  
  (setq result
    (vl-catch-all-apply
      '(lambda ()
         (setq new_obj (vla-copy obj))
         
         ;; 이동 벡터 계산 (Y축 방향으로 -distance)
         (setq offset (vlax-make-safearray vlax-vbDouble '(0 . 2)))
         (vlax-safearray-put-element offset 0 0.0)
         (vlax-safearray-put-element offset 1 (- distance))
         (vlax-safearray-put-element offset 2 0.0)
         
         ;; 객체 이동
         (vla-move new_obj 
                   (vlax-3d-point '(0 0 0))
                   (vlax-3d-point (list 0.0 (- distance) 0.0)))
      )
    )
  )
  
  (if (vl-catch-all-error-p result)
    (princ (strcat "\n오류: " (vl-catch-all-error-message result)))
  )
  
  new_obj
)



;; 객체의 모든 정점을 가져오는 함수 (2D LWPOLYLINE용)
(defun get-all-vertices (obj / coords pt_list i n pt z_val)
  (setq pt_list '())
  
  (if (vlax-property-available-p obj 'Coordinates)
    (progn
      ;; LWPOLYLINE의 좌표 가져오기 (2D는 X,Y만 있음)
      (setq coords (vlax-safearray->list (vlax-variant-value (vlax-get-property obj 'Coordinates))))
      
      ;; Elevation 속성으로 Z 좌표 가져오기 (없으면 0.0)
      (setq z_val (if (vlax-property-available-p obj 'Elevation)
                    (vlax-get-property obj 'Elevation)
                    0.0))
      
      (setq i 0)
      (setq n (length coords))
      
      ;; 2D LWPOLYLINE은 X,Y만 있으므로 2씩 증가
      (while (< i n)
        (setq pt (list (nth i coords) (nth (+ i 1) coords) z_val))
        (setq pt_list (append pt_list (list pt)))
        (setq i (+ i 2))
      )
    )
    (progn
      ;; LINE 객체의 경우
      (if (vlax-property-available-p obj 'StartPoint)
        (setq pt_list (append pt_list (list (vlax-safearray->list (vlax-get obj 'StartPoint)))))
      )
      (if (vlax-property-available-p obj 'EndPoint)
        (setq pt_list (append pt_list (list (vlax-safearray->list (vlax-get obj 'EndPoint)))))
      )
    )
  )
  
  pt_list
)

;; 선택한 객체와 첫 번째 복사 객체 사이에 텍스트를 추가하는 함수
(defun add-text-between-objects (top_obj bottom_obj text_string / 
                                  top_coords bottom_coords
                                  top_left top_right min_x max_x mid_x
                                  temp_line_pt1 temp_line_pt2 temp_line vertical_line
                                  vert_pt1 vert_pt2 ss_trim trimmed_line
                                  line_start line_end mid_y mid_z angle
                                  orig_layer orig_color old_osmode)
  (princ (strcat "\n텍스트 삽입 시작: " text_string))
  
  (if (and top_obj bottom_obj)
    (progn
      ;; 원본 객체의 레이어와 색상 가져오기
      (setq orig_layer (vlax-get-property top_obj 'Layer))
      (setq orig_color (vlax-get-property top_obj 'Color))
      
      ;; OSNAP 끄기
      (setq old_osmode (getvar "OSMODE"))
      (setvar "OSMODE" 0)
      
      ;; 원본 객체의 정점 가져오기
      (setq top_coords (get-all-vertices top_obj))
      
      ;; X 좌표가 가장 작은/큰 점 찾기 (양 끝점)
      (setq min_x 1e99)
      (setq max_x -1e99)
      (foreach pt top_coords
        (if (< (car pt) min_x)
          (progn
            (setq min_x (car pt))
            (setq top_left pt)
          )
        )
        (if (> (car pt) max_x)
          (progn
            (setq max_x (car pt))
            (setq top_right pt)
          )
        )
      )
      
      ;; 중간 X 좌표 계산
      (setq mid_x (/ (+ (car top_left) (car top_right)) 2.0))
      (setq mid_z (/ (+ (caddr top_left) (caddr top_right)) 2.0))
      
      ;; 1. 임시 가로선 생성 (왼쪽 끝점 - 오른쪽 끝점)
      (setq temp_line_pt1 (list (car top_left) (cadr top_left) mid_z))
      (setq temp_line_pt2 (list (car top_right) (cadr top_right) mid_z))
      (setq temp_line (entmakex (list
                                  (cons 0 "LINE")
                                  (cons 10 temp_line_pt1)
                                  (cons 11 temp_line_pt2)
                                )))
      
      ;; 2. 세로선 생성 (중간 X 좌표, 충분히 긴 길이)
      (setq vert_pt1 (list mid_x (+ (cadr top_left) 1.0) mid_z))
      (setq vert_pt2 (list mid_x (- (cadr top_left) 1.0) mid_z))
      (setq vertical_line (entmakex (list
                                      (cons 0 "LINE")
                                      (cons 10 vert_pt1)
                                      (cons 11 vert_pt2)
                                    )))
      
      ;; 3. TRIM 명령 실행 (원본, 첫 복사본을 경계로 세로선 자르기)
      (command "_.TRIM" 
               (vlax-vla-object->ename top_obj)
               (vlax-vla-object->ename bottom_obj)
               ""
               vertical_line
               "")
      
      ;; 4. 남은 세로선 찾기 (TRIM 후)
      (setq trimmed_line (entlast))
      
      ;; 5. 세로선의 시작점과 끝점 가져오기
      (if trimmed_line
        (progn
          (setq line_start (cdr (assoc 10 (entget trimmed_line))))
          (setq line_end (cdr (assoc 11 (entget trimmed_line))))
          
          ;; 6. 세로선의 중간점 계산
          (setq mid_y (/ (+ (cadr line_start) (cadr line_end)) 2.0))
          
          ;; 7. 원본 객체의 기울기 계산
          (setq angle (atan (- (cadr top_right) (cadr top_left))
                            (- (car top_right) (car top_left))))
          
          ;; 8. 텍스트 생성
          (entmake (list
                     (cons 0 "TEXT")
                     (cons 8 orig_layer)
                     (cons 62 orig_color)
                     (cons 10 (list mid_x mid_y mid_z))
                     (cons 11 (list mid_x mid_y mid_z))
                     (cons 40 0.05)
                     (cons 1 text_string)
                     (cons 50 angle)
                     (cons 72 1)
                     (cons 73 2)
                   ))
          
          ;; 9. 세로선 삭제
          (entdel trimmed_line)
          
          (princ "\n텍스트 삽입 완료")
        )
        (princ "\n오류: TRIM 후 세로선을 찾을 수 없습니다")
      )
      
      ;; 10. 임시 가로선 삭제
      (entdel temp_line)
      
      ;; OSNAP 복원
      (setvar "OSMODE" old_osmode)
    )
    (princ "\n오류: 객체가 nil입니다")
  )
)

(princ "\n포장 TYPE 프로그램이 로드되었습니다.")
(princ "\n명령어: PT")
(princ)
