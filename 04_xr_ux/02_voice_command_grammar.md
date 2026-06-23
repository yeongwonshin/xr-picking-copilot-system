# Voice Command Grammar

## 기본 명령
| 명령 | 의도 | 예시 처리 |
|---|---|---|
| “다음” | 다음 작업 카드 요청 | next_task |
| “완료” | 현재 라인 완료 시도 | complete_line |
| “다시 보여줘” | 현재 카드 재표시 | repeat_instruction |
| “수량 하나/둘/셋” | 수량 입력 | set_quantity |
| “문제” | 예외 메뉴 열기 | open_exception_menu |
| “재고 없음” | 재고 부족 신고 | report_stockout |
| “라벨 불량” | 라벨/바코드 문제 신고 | report_label_issue |
| “관리자 호출” | supervisor alert | call_supervisor |
| “일시정지” | 작업 세션 중지 | pause_session |
| “로그아웃” | 세션 종료 | logout |

## 소음 환경 처리
- 명령어는 1~4음절 위주로 짧게 유지한다.
- 중요 명령은 확인 절차를 둔다. 예: “라인 완료할까요?” → “확인”
- 음성 인식 실패율이 높은 존은 버튼/스캐너 트리거 fallback을 기본 제공한다.

## 다국어 정책
- 작업자 프로필에 언어 설정 저장
- SKU명은 로컬 언어 alias 제공
- 관리자 콘솔은 원문/번역 병기 가능

## 금지 UX
- 작업자에게 긴 문장 읽기를 요구하지 않는다.
- 걷는 중 복잡한 메뉴 탐색을 강요하지 않는다.
- 경고를 너무 자주 띄워 알림 피로를 만들지 않는다.
