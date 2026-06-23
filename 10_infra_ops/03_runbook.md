# Operations Runbook

## WMS 연동 장애
1. Integration dashboard에서 실패율과 응답코드 확인
2. Dead-letter queue 샘플 확인
3. idempotency key 중복 여부 확인
4. WMS sandbox 또는 health endpoint 상태 확인
5. 복구 후 replay 실행
6. 누락된 pick confirm이 없는지 reconciliation report 확인

## Edge Node 장애
1. Ops Console에서 heartbeat 상태 확인
2. 창고 Supervisor에게 바코드-only fallback 안내
3. 원격 재시작 또는 현장 전원 점검
4. 최근 모델/앱 업데이트 여부 확인
5. 장애 로그와 temperature/disk/gpu 지표 수집
6. 필요시 예비 Edge Node로 전환

## AI 오차단 급증
1. 모델 버전별 false block rate 확인
2. 특정 SKU/존/작업자/조도 조건으로 필터링
3. 새 패키지 이미지 또는 라벨 변경 여부 확인
4. confidence threshold 임시 완화
5. 샘플 이미지 라벨링 큐에 등록
6. rollback 또는 canary 중지

## 글래스 앱 크래시
1. app_version별 crash rate 확인
2. 최근 OTA 배포 중지
3. 문제가 있는 디바이스 그룹 격리
4. 작업자는 PDA/스캐너 fallback으로 전환
5. crash dump 분석 후 hotfix 배포
