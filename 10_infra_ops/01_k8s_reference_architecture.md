# Kubernetes Reference Architecture

## 서비스 목록
| 서비스 | 역할 | 스케일링 기준 |
|---|---|---|
| api-gateway | 인증, 라우팅, rate limit | RPS |
| xr-session-service | 글래스 세션과 작업 카드 | active sessions |
| task-orchestrator | 작업 큐·경로·할당 | pending tasks |
| verification-service | 검증 룰과 AI 결과 결합 | verification RPS |
| integration-service | WMS 연동 | outbound queue |
| event-bus | 이벤트 스트림 | partition lag |
| ops-console | 관리자 UI | users |
| analytics-worker | KPI 집계 | event volume |
| model-registry | 모델 버전 관리 | model count |

## 배포 환경
- dev: 단일 네임스페이스, mock WMS
- staging: 실제 WMS sandbox, synthetic load
- prod: 멀티 AZ, tenant 격리, 백업/DR

## 운영 전략
- 무중단 배포: rolling update + readiness probe
- 위험 서비스: canary release
- 데이터베이스: PITR 백업, read replica
- 이벤트 버스: dead-letter queue와 replay 지원

## 리소스 예시
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: verification-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: verification-service
  template:
    metadata:
      labels:
        app: verification-service
    spec:
      containers:
        - name: app
          image: registry.example.com/xr/verification:1.0.0
          ports:
            - containerPort: 8080
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 8080
          resources:
            requests:
              cpu: "500m"
              memory: "512Mi"
            limits:
              cpu: "2"
              memory: "2Gi"
```
