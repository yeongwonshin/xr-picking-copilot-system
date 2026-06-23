# Device Management

## 디바이스 유형
- Smart Glass
- Bluetooth Ring Scanner
- Edge AI Node
- Charging Dock
- Supervisor Tablet

## 디바이스 생애주기
```text
REGISTERED -> PROVISIONED -> ACTIVE -> MAINTENANCE -> RETIRED
```

## 프로비저닝
1. 시리얼 번호 등록
2. 창고/존 할당
3. 디바이스 인증서 발급
4. 앱/모델 버전 설치
5. 헬스체크 통과 후 활성화

## 정책
- 분실 시 원격 세션 폐기 및 인증서 revoke
- 앱 업데이트는 웨이브 종료 후 자동 적용
- 배터리 20% 미만이면 작업 신규 할당 금지
- 발열 또는 렌즈 오류 감지 시 MAINTENANCE 상태 전환

## 관제 지표
- active_devices
- device_battery_avg
- app_crash_rate
- camera_error_rate
- scan_latency_p95
- model_version_distribution
