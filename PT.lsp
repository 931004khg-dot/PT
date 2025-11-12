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
               (draw-vertical-lines obj last_obj)
              )
              
              ;; ASP 옵션 2: 5-12-20 (0.05, 0.12, 0.2 순차적으로)
              ((= option "asp2")
               (setq new_obj1 (copy-object-y-down obj 0.05))
               (setq new_obj2 (copy-object-y-down new_obj1 0.12))
               (setq last_obj (copy-object-y-down new_obj2 0.2))
               (draw-vertical-lines obj last_obj)
              )
              
              ;; ASP 옵션 3: 5-6-12-22 (0.05, 0.06, 0.12, 0.22 순차적으로)
              ((= option "asp3")
               (setq new_obj1 (copy-object-y-down obj 0.05))
               (setq new_obj2 (copy-object-y-down new_obj1 0.06))
               (setq new_obj3 (copy-object-y-down new_obj2 0.12))
               (setq last_obj (copy-object-y-down new_obj3 0.22))
               (draw-vertical-lines obj last_obj)
              )
              
              ;; ASP덧씌우기: 5 (0.05)
              ((= option "asp_over")
               (setq last_obj (copy-object-y-down obj 0.05))
               (draw-vertical-lines obj last_obj)
              )
              
              ;; CON'C: 20-20 (0.2, 0.2 순차적으로)
              ((= option "conc")
               (setq new_obj1 (copy-object-y-down obj 0.2))
               (setq last_obj (copy-object-y-down new_obj1 0.2))
               (draw-vertical-lines obj last_obj)
               (add-text-between-objects obj new_obj1 "CON'C")
              )
              
              ;; 보도 옵션 1: 6-4-10 (0.06, 0.04, 0.1 순차적으로)
              ((= option "sido1")
               (setq new_obj1 (copy-object-y-down obj 0.06))
               (setq new_obj2 (copy-object-y-down new_obj1 0.04))
               (setq last_obj (copy-object-y-down new_obj2 0.1))
               (draw-vertical-lines obj last_obj)
              )
              
              ;; 보도 옵션 2: 8-3-15 (0.08, 0.03, 0.15 순차적으로)
              ((= option "sido2")
               (setq new_obj1 (copy-object-y-down obj 0.08))
               (setq new_obj2 (copy-object-y-down new_obj1 0.03))
               (setq last_obj (copy-object-y-down new_obj2 0.15))
               (draw-vertical-lines obj last_obj)
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
               (draw-vertical-lines obj last_obj)
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
                       (draw-vertical-lines obj last_obj)
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
(defun copy-object-y-down (obj distance / new_obj offset)
  (setq new_obj nil)
  
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
  
  new_obj
)

;; 원본 객체와 마지막 객체의 양 끝점을 연결하는 세로선을 그리는 함수
(defun draw-vertical-lines (orig_obj last_obj / orig_start orig_end last_start last_end)
  (if (and orig_obj last_obj)
    (vl-catch-all-apply
      '(lambda ()
         ;; 원본 객체의 시작점과 끝점 가져오기
         (if (vlax-property-available-p orig_obj 'StartPoint)
           (setq orig_start (vlax-get orig_obj 'StartPoint))
         )
         (if (vlax-property-available-p orig_obj 'EndPoint)
           (setq orig_end (vlax-get orig_obj 'EndPoint))
         )
         
         ;; 마지막 객체의 시작점과 끝점 가져오기
         (if (vlax-property-available-p last_obj 'StartPoint)
           (setq last_start (vlax-get last_obj 'StartPoint))
         )
         (if (vlax-property-available-p last_obj 'EndPoint)
           (setq last_end (vlax-get last_obj 'EndPoint))
         )
         
         ;; 세로선 그리기 (시작점 연결)
         (if (and orig_start last_start)
           (progn
             (command "_.line" 
                      (vlax-safearray->list orig_start)
                      (vlax-safearray->list last_start)
                      "")
           )
         )
         
         ;; 세로선 그리기 (끝점 연결)
         (if (and orig_end last_end)
           (progn
             (command "_.line" 
                      (vlax-safearray->list orig_end)
                      (vlax-safearray->list last_end)
                      "")
           )
         )
      )
    )
  )
)

;; 두 객체 사이에 텍스트를 추가하는 함수
(defun add-text-between-objects (top_obj bottom_obj text_string / top_pt bottom_pt mid_pt mid_x mid_y mid_z)
  (if (and top_obj bottom_obj)
    (vl-catch-all-apply
      '(lambda ()
         ;; 위쪽 객체의 시작점 가져오기
         (if (vlax-property-available-p top_obj 'StartPoint)
           (setq top_pt (vlax-safearray->list (vlax-get top_obj 'StartPoint)))
         )
         
         ;; 아래쪽 객체의 시작점 가져오기
         (if (vlax-property-available-p bottom_obj 'StartPoint)
           (setq bottom_pt (vlax-safearray->list (vlax-get bottom_obj 'StartPoint)))
         )
         
         ;; 중간점 계산
         (if (and top_pt bottom_pt)
           (progn
             (setq mid_x (/ (+ (car top_pt) (car bottom_pt)) 2.0))
             (setq mid_y (/ (+ (cadr top_pt) (cadr bottom_pt)) 2.0))
             (setq mid_z (/ (+ (caddr top_pt) (caddr bottom_pt)) 2.0))
             (setq mid_pt (list mid_x mid_y mid_z))
             
             ;; 텍스트 삽입
             (command "_.text" "_J" "_MC" mid_pt "0.05" "0" text_string)
           )
         )
      )
    )
  )
)

(princ "\n객체 복사 프로그램이 로드되었습니다.")
(princ "\n명령어: PT")
(princ)
