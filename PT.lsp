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
(defun copy-object-y-down (obj distance / new_obj offset result)
  (setq new_obj nil)
  (princ (strcat "\n[DEBUG] copy-object-y-down 시작 - distance: " (rtos distance 2 3)))
  
  (setq result
    (vl-catch-all-apply
      '(lambda ()
         (princ "\n[DEBUG] vla-copy 시작")
         (setq new_obj (vla-copy obj))
         (princ (strcat "\n[DEBUG] 복사 완료 - new_obj: " (if new_obj "존재함" "nil")))
         
         ;; 이동 벡터 계산 (Y축 방향으로 -distance)
         (setq offset (vlax-make-safearray vlax-vbDouble '(0 . 2)))
         (vlax-safearray-put-element offset 0 0.0)
         (vlax-safearray-put-element offset 1 (- distance))
         (vlax-safearray-put-element offset 2 0.0)
         (princ "\n[DEBUG] offset 생성 완료")
         
         ;; 객체 이동
         (princ "\n[DEBUG] vla-move 시작")
         (vla-move new_obj 
                   (vlax-3d-point '(0 0 0))
                   (vlax-3d-point (list 0.0 (- distance) 0.0)))
         (princ "\n[DEBUG] 이동 완료")
      )
    )
  )
  
  (if (vl-catch-all-error-p result)
    (princ (strcat "\n[ERROR] copy-object-y-down 오류: " (vl-catch-all-error-message result)))
    (princ "\n[DEBUG] copy-object-y-down 정상 완료")
  )
  
  new_obj
)

;; 원본 객체와 마지막 객체의 양 끝점을 연결하는 세로선을 그리는 함수
(defun draw-vertical-lines (orig_obj last_obj / result 
                            orig_coords last_coords
                            orig_left orig_right last_left last_right
                            min_x max_x temp_pt)
  (princ "\n[DEBUG] draw-vertical-lines 시작")
  
  (if (and orig_obj last_obj)
    (progn
      (setq result
        (vl-catch-all-apply
          '(lambda ()
             ;; 원본 객체의 모든 정점 가져오기
             (princ "\n[DEBUG] 원본 객체 정점 가져오기...")
             (setq orig_coords (get-all-vertices orig_obj))
             (princ (strcat "\n[DEBUG] 원본 정점 수: " (itoa (length orig_coords))))
             
             ;; X 좌표가 가장 작은 점과 가장 큰 점 찾기
             (setq min_x 1e99)
             (setq max_x -1e99)
             (foreach pt orig_coords
               (if (< (car pt) min_x)
                 (progn
                   (setq min_x (car pt))
                   (setq orig_left pt)
                 )
               )
               (if (> (car pt) max_x)
                 (progn
                   (setq max_x (car pt))
                   (setq orig_right pt)
                 )
               )
             )
             (princ (strcat "\n[DEBUG] 원본 왼쪽: " (vl-princ-to-string orig_left)))
             (princ (strcat "\n[DEBUG] 원본 오른쪽: " (vl-princ-to-string orig_right)))
             
             ;; 마지막 객체의 모든 정점 가져오기
             (princ "\n[DEBUG] 마지막 객체 정점 가져오기...")
             (setq last_coords (get-all-vertices last_obj))
             (princ (strcat "\n[DEBUG] 마지막 정점 수: " (itoa (length last_coords))))
             
             ;; X 좌표가 가장 작은 점과 가장 큰 점 찾기
             (setq min_x 1e99)
             (setq max_x -1e99)
             (foreach pt last_coords
               (if (< (car pt) min_x)
                 (progn
                   (setq min_x (car pt))
                   (setq last_left pt)
                 )
               )
               (if (> (car pt) max_x)
                 (progn
                   (setq max_x (car pt))
                   (setq last_right pt)
                 )
               )
             )
             (princ (strcat "\n[DEBUG] 마지막 왼쪽: " (vl-princ-to-string last_left)))
             (princ (strcat "\n[DEBUG] 마지막 오른쪽: " (vl-princ-to-string last_right)))
             
             ;; 세로선 그리기
             (if (and orig_left last_left)
               (progn
                 (princ "\n[DEBUG] 왼쪽 세로선 그리기")
                 (command "_.line" orig_left last_left "")
               )
             )
             
             (if (and orig_right last_right)
               (progn
                 (princ "\n[DEBUG] 오른쪽 세로선 그리기")
                 (command "_.line" orig_right last_right "")
               )
             )
          )
        )
      )
      
      (if (vl-catch-all-error-p result)
        (princ (strcat "\n[ERROR] draw-vertical-lines 오류: " (vl-catch-all-error-message result)))
        (princ "\n[DEBUG] draw-vertical-lines 정상 완료")
      )
    )
    (princ "\n[ERROR] draw-vertical-lines - 객체가 nil입니다")
  )
)

;; 객체의 모든 정점을 가져오는 함수
(defun get-all-vertices (obj / coords pt_list i n pt)
  (setq pt_list '())
  
  (if (vlax-property-available-p obj 'Coordinates)
    (progn
      ;; LWPOLYLINE, POLYLINE 등의 좌표 가져오기
      (setq coords (vlax-safearray->list (vlax-variant-value (vlax-get-property obj 'Coordinates))))
      (setq i 0)
      (setq n (length coords))
      (while (< i n)
        (setq pt (list (nth i coords) (nth (+ i 1) coords) (nth (+ i 2) coords)))
        (setq pt_list (append pt_list (list pt)))
        (setq i (+ i 3))
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

;; 두 객체 사이에 텍스트를 추가하는 함수
(defun add-text-between-objects (top_obj bottom_obj text_string / result
                                  top_coords bottom_coords
                                  top_left top_right bottom_left bottom_right
                                  mid_pt angle deg_angle)
  (princ (strcat "\n[DEBUG] add-text-between-objects 시작 - 텍스트: " text_string))
  
  (if (and top_obj bottom_obj)
    (progn
      (setq result
        (vl-catch-all-apply
          '(lambda ()
             ;; 원본 객체의 정점 가져오기
             (princ "\n[DEBUG] 원본 객체 정점 가져오기...")
             (setq top_coords (get-all-vertices top_obj))
             
             ;; X 좌표가 가장 작은/큰 점 찾기
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
             (princ (strcat "\n[DEBUG] 원본 왼쪽: " (vl-princ-to-string top_left)))
             (princ (strcat "\n[DEBUG] 원본 오른쪽: " (vl-princ-to-string top_right)))
             
             ;; 첫 복사본 객체의 정점 가져오기
             (princ "\n[DEBUG] 첫 복사본 객체 정점 가져오기...")
             (setq bottom_coords (get-all-vertices bottom_obj))
             
             ;; X 좌표가 가장 작은/큰 점 찾기
             (setq min_x 1e99)
             (setq max_x -1e99)
             (foreach pt bottom_coords
               (if (< (car pt) min_x)
                 (progn
                   (setq min_x (car pt))
                   (setq bottom_left pt)
                 )
               )
               (if (> (car pt) max_x)
                 (progn
                   (setq max_x (car pt))
                   (setq bottom_right pt)
                 )
               )
             )
             (princ (strcat "\n[DEBUG] 첫 복사본 왼쪽: " (vl-princ-to-string bottom_left)))
             (princ (strcat "\n[DEBUG] 첫 복사본 오른쪽: " (vl-princ-to-string bottom_right)))
             
             ;; 원본 객체 중심점 계산 (왼쪽과 오른쪽 끝의 중간)
             (setq top_center (list (/ (+ (car top_left) (car top_right)) 2.0)
                                    (/ (+ (cadr top_left) (cadr top_right)) 2.0)
                                    (/ (+ (caddr top_left) (caddr top_right)) 2.0)))
             
             ;; 첫 복사본 객체 중심점 계산
             (setq bottom_center (list (/ (+ (car bottom_left) (car bottom_right)) 2.0)
                                       (/ (+ (cadr bottom_left) (cadr bottom_right)) 2.0)
                                       (/ (+ (caddr bottom_left) (caddr bottom_right)) 2.0)))
             
             ;; 두 중심점의 정확한 중간점 계산
             (setq mid_pt (list (/ (+ (car top_center) (car bottom_center)) 2.0)
                                (/ (+ (cadr top_center) (cadr bottom_center)) 2.0)
                                (/ (+ (caddr top_center) (caddr bottom_center)) 2.0)))
             (princ (strcat "\n[DEBUG] 텍스트 중간점: " (vl-princ-to-string mid_pt)))
             
             ;; 원본 객체의 기울기 계산 (왼쪽 → 오른쪽)
             (setq angle (atan (- (cadr top_right) (cadr top_left))
                               (- (car top_right) (car top_left))))
             (setq deg_angle (* (/ angle pi) 180.0))
             (princ (strcat "\n[DEBUG] 텍스트 각도(도): " (rtos deg_angle 2 2)))
             
             ;; 텍스트 삽입 (회전 적용)
             (princ "\n[DEBUG] TEXT 명령 실행 (회전 적용)")
             (command "_.text" "_J" "_MC" mid_pt "0.05" (rtos angle 2 6) text_string)
             (princ "\n[DEBUG] 텍스트 삽입 완료")
          )
        )
      )
      
      (if (vl-catch-all-error-p result)
        (princ (strcat "\n[ERROR] add-text-between-objects 오류: " (vl-catch-all-error-message result)))
        (princ "\n[DEBUG] add-text-between-objects 정상 완료")
      )
    )
    (princ "\n[ERROR] add-text-between-objects - 객체가 nil입니다")
  )
)

(princ "\n객체 복사 프로그램이 로드되었습니다.")
(princ "\n명령어: PT")
(princ)
