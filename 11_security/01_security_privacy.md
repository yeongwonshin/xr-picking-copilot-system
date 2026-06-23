# Security & Privacy Design

## 보안 목표
- WMS 재고·주문 데이터 보호
- 작업자 개인정보와 영상 데이터 최소화
- 디바이스 분실·탈취 대응
- 감사 가능한 운영 이벤트 보관
- 테넌트 격리와 권한 통제

## 인증·인가
- SSO/SAML/OIDC 지원
- 작업자: 디바이스 인증 + 사원 QR/PIN
- 관리자: MFA 필수
- RBAC: Worker, Supervisor, WMS Admin, Auditor, Tenant Admin
- API: OAuth2/JWT, mTLS 옵션

## 데이터 보호
| 데이터 | 정책 |
|---|---|
| 원본 영상 | 기본 저장 금지, 예외 시 단기 저장 |
| 작업자 음성 | 명령 텍스트만 저장, 원본 음성 저장 금지 기본값 |
| SKU/재고 | 암호화 저장, 접근 로그 |
| 감사 로그 | 위변조 방지 저장소, 보존기간 정책 |
| 모델 학습 데이터 | 비식별화, 고객 승인 기반 반출 |

## 디바이스 보안
- 디바이스 인증서 발급/폐기
- 앱 서명 검증
- 루팅/탈옥 탐지
- 분실 시 원격 세션 revoke
- 모델 파일 서명 검증

## 감사 이벤트
- 로그인/로그아웃
- 작업 할당/완료/오버라이드
- 관리자 승인
- 설정 변경
- 데이터 다운로드
- 모델 배포/rollback

## 위협 모델 요약
| 위협 | 완화 |
|---|---|
| 분실 글래스에서 작업 데이터 노출 | 짧은 세션 TTL, 인증서 revoke, 로컬 암호화 |
| WMS API 키 유출 | secret manager, rotation, least privilege |
| 영상 개인정보 과수집 | edge crop/blur, 기본 원본 미저장 |
| 테넌트 간 데이터 혼선 | tenant_id 강제 필터, DB row-level policy |
| AI 모델 변조 | signed model, registry approval workflow |
