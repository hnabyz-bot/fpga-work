# doc-writer - 상세 참고 문서

이 문서는 doc-writer 스킬의 고급 패턴, 상세 예시, 심화 주제를 다룹니다.

---

## 목차

1. [문서 유형별 상세 가이드](#문서-유형별-상세-가이드)
2. [고급 패턴](#고급-패턴)
3. [실전 예제](#실전-예제)
4. [문서 유지 관리](#문서-유지-관리)
5. [자주 묻는 질문](#자주-묻는-질문)

---

## 문서 유형별 상세 가이드

### 1. README.md 상세 가이드

README는 프로젝트의 얼굴입니다. 첫인상이 중요해요!

#### 필수 구성 요소 상세

**프로젝트 제목과 설명:**

```markdown
# Awesome Library

매우 빠르고 사용하기 쉬운 JavaScript 라이브러리입니다.
복잡한 데이터 처리를 단 5줄의 코드로 구현할 수 있어요.
```

**배지 추가 (선택사항):**

```markdown
[![npm version](https://badge.fury.io/js/awesome-library.svg)](https://www.npmjs.com/package/awesome-library)
[![Build Status](https://travis-ci.org/username/awesome-library.svg?branch=main)](https://travis-ci.org/username/awesome-library)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
```

**빠른 시작 섹션:**

```markdown
## 빠른 시작

### 설치

\`\`\`bash
npm install awesome-library
\`\`\`

### 기본 사용법

\`\`\`javascript
import { Awesome } from 'awesome-library';

const awesome = new Awesome();
const result = awesome.process(data);
\`\`\`

### 5분 완성 튜토리얼

1. 라이브러리 설치
2. 데이터 준비
3. 프로세서 초기화
4. 결과 확인
```

**주요 기능 나열:**

```markdown
## 주요 기능

- ⚡️ **초고속 성능**: 100만 개 레코드를 1초 내 처리
- 🎯 **TypeScript 지원**: 완전한 타입 정의 제공
- 🔧 **간편한 설정**: 단 3줄의 설정으로 사용 가능
- 📊 **유연한 데이터 처리**: JSON, CSV, XML 지원
- 🌍 **다국어 지원**: 한국어, 영어, 일본어, 중국어
```

**설치 방법 상세:**

```markdown
## 설치 방법

### npm 사용

\`\`\`bash
npm install awesome-library
\`\`\`

### yarn 사용

\`\`\`bash
yarn add awesome-library
\`\`\`

### CDN 사용 (브라우저)

\`\`\`html
<script src="https://cdn.jsdelivr.net/npm/awesome-library@latest/dist/awesome.min.js"></script>
\`\`\`

### 개발 의존성으로 설치

\`\`\`bash
npm install --save-dev awesome-library
\`\`\`
```

**사용 예제:**

```markdown
## 사용 예제

### 기본 예제

\`\`\`javascript
import { Awesome } from 'awesome-library';

const awesome = new Awesome();
const result = awesome.process([
  { id: 1, name: 'Item 1' },
  { id: 2, name: 'Item 2' }
]);

console.log(result);
// 출력: { processed: 2, success: true }
\`\`\`

### 고급 예제

\`\`\`javascript
const awesome = new Awesome({
  debug: true,
  maxRetries: 3,
  timeout: 5000
});

const result = await awesome.processAsync(largeDataset, {
  batchSize: 1000,
  concurrent: 5
});
\`\`\`
```

**기여 방법 안내:**

```markdown
## 기여 방법

기여를 환영합니다! 다음 단계를 따라주세요:

1. 저장소를 포크합니다
2. 기능 브랜치를 생성합니다 (`git checkout -b feature/AmazingFeature`)
3. 변경사항을 커밋합니다 (`git commit -m 'Add some AmazingFeature'`)
4. 브랜치를 푸시합니다 (`git push origin feature/AmazingFeature`)
5. Pull Request를 엽니다

### 기여 가이드라인

- 하나의 기능/버그 수정당 하나의 PR
- 명확한 커밋 메시지 사용
- 테스트 코드 포함
- 문서 업데이트

### 코드 스타일

- ESLint 규칙 준수
- Prettier로 포맷팅
- 타입 정의 포함 (TypeScript)
```

**라이선스 정보:**

```markdown
## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

Copyright (c) 2025 Your Name
```

---

### 2. API 문서 상세 가이드

API 문서는 개발자를 위한 지침서입니다.

#### API 엔드포인트 완전한 문서 구조

```markdown
## 사용자 정보 가져오기

인증된 사용자의 상세 정보를 조회합니다.

### HTTP Request

\`GET /api/users/{id}\`

### 요청 헤더

| Header | Type | Required | Description |
|--------|------|----------|-------------|
| Authorization | string | Yes | Bearer 토큰 |
| Accept | string | No | 응답 형식 (application/json) |

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | string | Yes | 사용자 고유 ID (UUID 형식) |

### Query Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| include | string | No | null | 포함할 관련 데이터 (쉼표로 구분: posts,comments) |
| fields | string | No | * | 반환할 필드 (쉼표로 구분) |

### Request Example

\`\`\`bash
curl -X GET "https://api.example.com/users/user_123?include=posts,comments" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Accept: application/json"
\`\`\`

### Response

**Success Response (200 OK):**

\`\`\`json
{
  "data": {
    "id": "user_123",
    "type": "user",
    "attributes": {
      "name": "홍길동",
      "email": "hong@example.com",
      "createdAt": "2025-01-15T10:30:00Z",
      "updatedAt": "2025-01-15T10:30:00Z"
    },
    "relationships": {
      "posts": {
        "links": {
          "self": "/users/user_123/relationships/posts",
          "related": "/users/user_123/posts"
        }
      }
    }
  },
  "included": [
    {
      "id": "post_456",
      "type": "post",
      "attributes": {
        "title": "첫 번째 게시글"
      }
    }
  ],
  "meta": {
    "total": 1,
    "page": 1,
    "perPage": 10
  }
}
\`\`\`

**Error Response (404 Not Found):**

\`\`\`json
{
  "errors": [
    {
      "id": "error_123",
      "code": "USER_NOT_FOUND",
      "title": "사용자를 찾을 수 없습니다",
      "detail": "ID가 'user_123'인 사용자가 존재하지 않습니다",
      "status": 404,
      "links": {
        "about": "https://api.example.com/docs/errors/user-not-found"
      }
    }
  ]
}
\`\`\`

**Error Response (401 Unauthorized):**

\`\`\`json
{
  "errors": [
    {
      "code": "INVALID_TOKEN",
      "title": "인증 토큰이 유효하지 않습니다",
      "status": 401
    }
  ]
}
\`\`\`

### Status Codes

| Code | Description |
|------|-------------|
| 200 | 성공적으로 사용자 정보를 조회함 |
| 401 | 인증 토큰이 유효하지 않음 |
| 403 | 권한이 없음 (다른 사용자 정보 접근) |
| 404 | 사용자를 찾을 수 없음 |
| 500 | 서버 내부 오류 |

### Rate Limiting

이 엔드포인트는 분당 100회의 요청으로 제한됩니다.

Rate Limit 헤더:
\`\`\`
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1642246600
\`\`\`

### Code Examples

**JavaScript (Fetch):**

\`\`\`javascript
const response = await fetch('/api/users/user_123?include=posts', {
  method: 'GET',
  headers: {
    'Authorization': \`Bearer \${token}\`,
    'Accept': 'application/json'
  }
});

if (!response.ok) {
  throw new Error(\`HTTP error! status: \${response.status}\`);
}

const data = await response.json();
console.log(data.attributes.name); // "홍길동"
\`\`\`

**JavaScript (Axios):**

\`\`\`javascript
import axios from 'axios';

const response = await axios.get('/api/users/user_123', {
  headers: {
    'Authorization': \`Bearer \${token}\`
  },
  params: {
    include: 'posts,comments'
  }
});

console.log(response.data);
\`\`\`

**Python (requests):**

\`\`\`python
import requests

headers = {
    'Authorization': f'Bearer {token}',
    'Accept': 'application/json'
}

params = {
    'include': 'posts,comments'
}

response = requests.get(
    'https://api.example.com/users/user_123',
    headers=headers,
    params=params
)

data = response.json()
print(data['data']['attributes']['name'])
\`\`\`
```

---

### 3. 사용자 가이드 상세 가이드

사용자 가이드는 단계별 튜토리얼입니다.

#### 완전한 튜토리얼 구조

```markdown
# 사용자 인증 구현하기

이 가이드에서는 Awesome Library를 사용하여 사용자 인증 시스템을 구현하는 방법을 단계별로 배웁니다.

## 목차

1. [전제 조건](#전제-조건)
2. [프로젝트 설정](#프로젝트-설정)
3. [인증 서버 구성](#인증-서버-구성)
4. [로그인 구현](#로그인-구현)
5. [토큰 관리](#토큰-관리)
6. [보안 고려사항](#보안-고려사항)
7. [문제 해결](#문제-해결)

## 전제 조건

시작하기 전에 다음이 필요합니다:

- Node.js 18.x 이상
- npm 또는 yarn
- JavaScript 기본 지식
- 텍스트 에디터 (VS Code 권장)

### 필요한 지식

- ES6+ 문법
- Promise 및 async/await
- HTTP 기본 개념
- JWT (JSON Web Token) 기본 이해

## 프로젝트 설정

### 1단계: 새 프로젝트 생성

\`\`\`bash
mkdir auth-tutorial
cd auth-tutorial
npm init -y
\`\`\`

### 2단계: 의존성 설치

\`\`\`bash
npm install awesome-library express dotenv
npm install --save-dev nodemon
\`\`\`

### 3단계: 프로젝트 구조

\`\`\`
auth-tutorial/
├── src/
│   ├── config/
│   │   └── auth.js
│   ├── middleware/
│   │   └── auth.js
│   ├── routes/
│   │   └── auth.js
│   └── index.js
├── .env
├── .gitignore
└── package.json
\`\`\`

## 인증 서버 구성

### 환경 변수 설정

\.env 파일을 생성하고 다음을 추가합니다:

\`\`\`env
# 서버 설정
PORT=3000
NODE_ENV=development

# 인증 설정
JWT_SECRET=your-super-secret-key-change-this-in-production
JWT_EXPIRES_IN=24h
REFRESH_TOKEN_EXPIRES_IN=7d

# 클라이언트 설정
CLIENT_URL=http://localhost:3001
\`\`\`

**중요**: 프로덕션 환경에서는 강력한 JWT_SECRET을 사용하세요!

### 인증 구성

src/config/auth.js:

\`\`\`javascript
require('dotenv').config();

module.exports = {
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: process.env.JWT_EXPIRES_IN || '24h',
    refreshTokenExpiresIn: process.env.REFRESH_TOKEN_EXPIRES_IN || '7d'
  },
  client: {
    url: process.env.CLIENT_URL
  }
};
\`\`\`

## 로그인 구현

### 인증 미들웨어

src/middleware/auth.js:

\`\`\`javascript
const { Awesome } = require('awesome-library');
const config = require('../config/auth');

const awesome = new Awesome(config.jwt);

// 토큰 검증 미들웨어
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // "Bearer TOKEN"

  if (!token) {
    return res.status(401).json({
      error: 'Access token이 필요합니다'
    });
  }

  try {
    const decoded = awesome.verifyToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(403).json({
      error: '유효하지 않은 토큰입니다'
    });
  }
};

// 선택적 인증 미들웨어
const optionalAuth = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (token) {
    try {
      const decoded = awesome.verifyToken(token);
      req.user = decoded;
    } catch (error) {
      // 토큰이 있지만 유효하지 않으면 무시
    }
  }

  next();
};

module.exports = {
  authenticateToken,
  optionalAuth
};
\`\`\`

### 인증 라우트

src/routes/auth.js:

\`\`\`javascript
const express = require('express');
const { Awesome } = require('awesome-library');
const config = require('../config/auth');

const router = express.Router();
const awesome = new Awesome(config.jwt);

// 로그인
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // 1. 사용자 확인 (실제로는 데이터베이스 조회)
    if (!email || !password) {
      return res.status(400).json({
        error: '이메일과 비밀번호를 입력해주세요'
      });
    }

    // 2. 사용자 인증 (실제로는 데이터베이스에서 비밀번호 확인)
    const user = await authenticateUser(email, password);

    if (!user) {
      return res.status(401).json({
        error: '이메일 또는 비밀번호가 올바르지 않습니다'
      });
    }

    // 3. 토큰 생성
    const accessToken = awesome.generateToken({
      userId: user.id,
      email: user.email
    });

    const refreshToken = awesome.generateRefreshToken({
      userId: user.id
    });

    // 4. 응답
    res.json({
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
        name: user.name
      }
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      error: '서버 오류가 발생했습니다'
    });
  }
});

// 토큰 갱신
router.post('/refresh', async (req, res) => {
  try {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      return res.status(400).json({
        error: 'Refresh token이 필요합니다'
      });
    }

    // 리프레시 토큰 검증
    const decoded = awesome.verifyRefreshToken(refreshToken);

    // 새 액세스 토큰 생성
    const newAccessToken = awesome.generateToken({
      userId: decoded.userId
    });

    res.json({
      accessToken: newAccessToken
    });

  } catch (error) {
    res.status(403).json({
      error: '유효하지 않은 refresh token입니다'
    });
  }
});

// 로그아웃
router.post('/logout', (req, res) => {
  // 실제로는 토큰을 블랙리스트에 추가
  res.json({
    message: '성공적으로 로그아웃되었습니다'
  });
});

module.exports = router;
\`\`\`

## 토큰 관리

### 클라이언트에서 토큰 저장

\`\`\`javascript
// 로그인 후 토큰 저장
const login = async (email, password) => {
  const response = await fetch('/api/auth/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ email, password })
  });

  const data = await response.json();

  // 액세스 토큰은 메모리에 저장 (XSS 방지)
  sessionStorage.setItem('accessToken', data.accessToken);

  // 리프레시 토큰은 httpOnly 쿠키에 저장 (CSRF 방지)
  // 또는 localStorage에 저장 (CSRF 토큰과 함께 사용)

  return data.user;
};

// 인증이 필요한 요청
const fetchProtectedData = async () => {
  const token = sessionStorage.getItem('accessToken');

  const response = await fetch('/api/protected', {
    headers: {
      'Authorization': \`Bearer \${token}\`
    }
  });

  if (response.status === 401) {
    // 토큰 만료: 리프레시 토큰으로 갱신
    await refreshAccessToken();
    // 재시도
    return fetchProtectedData();
  }

  return response.json();
};
\`\`\`

## 보안 고려사항

### 1. 토큰 저장

- **액세스 토큰**: 짧은 수명 (15-30분), 메모리에 저장
- **리프레시 토큰**: 긴 수명 (7일), httpOnly 쿠키에 저장

### 2. HTTPS 사용

모든 인증 요청은 HTTPS를 통해 전송해야 합니다.

### 3. 솔트 및 해시

비밀번호는 bcrypt와 같은 라이브러리로 해싱해야 합니다:

\`\`\`javascript
const bcrypt = require('bcrypt');

const hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(password, salt);
};

const comparePassword = async (password, hash) => {
  return bcrypt.compare(password, hash);
};
\`\`\`

### 4. Rate Limiting

\`\`\`javascript
const rateLimit = require('express-rate-limit');

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15분
  max: 5, // 5회 시도
  message: '너무 많은 로그인 시도가 있었습니다. 나중에 다시 시도해주세요.'
});

app.use('/api/auth/login', loginLimiter);
\`\`\`

## 완료!

축하합니다! 이제 기본적인 인증 시스템을 구현했습니다.

### 다음 단계

- [고급 보안 기능 구현](./advanced-security.md)
- [소셜 로그인 추가](./social-login.md)
- [2단계 인증 구현](./two-factor-auth.md)
- [API 참조 문서](./api-reference.md)

## 문제 해결

### "유효하지 않은 토큰입니다" 오류

**원인**: 토큰이 만료되었거나 손상되었습니다.

**해결**:
1. 새 토큰으로 갱신 시도
2. 로그아웃 후 다시 로그인

### "CORS 오류" 발생

**원인**: 클라이언트와 서버의 도메인이 다릅니다.

**해결**: 서버에서 CORS 설정을 추가하세요:

\`\`\`javascript
const cors = require('cors');

app.use(cors({
  origin: process.env.CLIENT_URL,
  credentials: true
}));
\`\`\`

### 토큰이 localStorage에 노출됨

**해결**: httpOnly 쿠키를 사용하여 XSS 공격을 방지하세요.
```

---

### 4. 아키텍처 문서 상세 가이드

아키텍처 문서는 시스템의 큰 그림을 보여줍니다.

#### 완전한 아키텍처 문서 구조

```markdown
# Awesome App 시스템 아키텍처

## 문서 정보

- **버전**: 1.0.0
- **마지막 업데이트**: 2025-01-15
- **작성자**: 아키텍처 팀
- **유지 관리자**: tech-lead@example.com

## 개요

이 문서는 Awesome App의 시스템 아키텍처를 설명합니다. Awesome App은 마이크로서비스 기반의 실시간 데이터 처리 플랫폼입니다.

### 시스템 목표

- **확장성**: 초당 10,000개의 요청 처리
- **가용성**: 99.9% 가동 시간 보장
- **지연 시간**: 평균 100ms 이하의 응답 시간
- **데이터 일관성**: 강한 일관성 보장

## 아키텍처 원칙

### 1. 서비스 분리

비즈니스 도메인별로 서비스를 분리합니다:
- 사용자 서비스 (User Service)
- 주문 서비스 (Order Service)
- 결제 서비스 (Payment Service)
- 알림 서비스 (Notification Service)

### 2. 데이터베이스 분리

각 서비스는 독립적인 데이터베이스를 가집니다:
- 데이터 소유권 명확화
- 서비스 간 결합도 감소
- 독립적인 확장 가능

### 3. 비동기 통신

서비스 간 통신은 메시지 큐를 사용합니다:
- 이벤트 기반 아키텍처
- 서비스 간 결합도 최소화
- 내결함성 향상

## 시스템 아키텍처 다이어그램

### 전체 아키텍처

\`\`\`mermaid
graph TB
    subgraph "클라이언트 계층"
        WEB[Web App]
        MOBILE[Mobile App]
    end

    subgraph "API 게이트웨이 계층"
        GW[API Gateway]
        LB[Load Balancer]
    end

    subgraph "서비스 계층"
        US[User Service]
        OS[Order Service]
        PS[Payment Service]
        NS[Notification Service]
    end

    subgraph "메시징 계층"
        KAFKA[Kafka Cluster]
        REDIS[(Redis Cache)]
    end

    subgraph "데이터 계층"
        PG_US[(User DB)]
        PG_OS[(Order DB)]
        PG_PS[(Payment DB)]
        MONGO[(MongoDB)]
    end

    WEB --> GW
    MOBILE --> GW
    GW --> LB
    LB --> US
    LB --> OS
    LB --> PS
    LB --> NS

    US --> KAFKA
    OS --> KAFKA
    PS --> KAFKA
    NS --> KAFKA

    US --> REDIS
    OS --> REDIS

    US --> PG_US
    OS --> PG_OS
    PS --> PG_PS
    NS --> MONGO
\`\`\`

### 데이터 흐름

\`\`\`mermaid
sequenceDiagram
    participant User
    participant API
    participant OrderSvc
    participant PaymentSvc
    participant Kafka
    participant NotificationSvc

    User->>API: 주문 요청
    API->>OrderSvc: 주문 생성
    OrderSvc->>PaymentSvc: 결제 처리
    PaymentSvc-->>OrderSvc: 결제 완료
    OrderSvc->>Kafka: 주문 완료 이벤트
    OrderSvc-->>API: 주문 응답
    API-->>User: 주문 완료

    Kafka->>NotificationSvc: 이벤트 수신
    NotificationSvc->>User: 알림 발송
\`\`\`

## 구성 요소 상세

### API Gateway

**역할**: 클라이언트 요청 라우팅, 인증, 속도 제한

**기술 스택**:
- Kong Gateway 3.x
- Nginx 1.24
- Redis (rate limiting)

**주요 기능**:
- 요청 라우팅
- 인증 및 인가 (JWT)
- 속도 제한 (100 req/min per user)
- SSL 종료
- 요청/응답 로깅

**포트**: 80 (HTTP), 443 (HTTPS)

**확장 전략**: 수평 확장 (Auto Scaling Group)

### User Service

**역할**: 사용자 관리, 인증, 프로필

**기술 스택**:
- Node.js 20
- Express 4.x
- PostgreSQL 15

**데이터베이스 스키마**:

| 테이블 | 주요 컬럼 | 인덱스 |
|--------|-----------|--------|
| users | id, email, password_hash, created_at | email (unique) |
| profiles | user_id, name, avatar_url | user_id (unique) |
| sessions | id, user_id, token, expires_at | token (unique) |

**API 엔드포인트**:
- POST /users - 사용자 생성
- GET /users/:id - 사용자 조회
- PUT /users/:id - 사용자 업데이트
- POST /auth/login - 로그인
- POST /auth/logout - 로그아웃

**확장 전략**: 수평 확장, Read Replica

### Order Service

**역할**: 주문 관리, 재고 확인, 주문 처리

**기술 스택**:
- Python 3.11
- FastAPI 0.104
- PostgreSQL 15

**데이터베이스 스키마**:

| 테이블 | 주요 컬럼 | 인덱스 |
|--------|-----------|--------|
| orders | id, user_id, status, total_amount | user_id, created_at |
| order_items | id, order_id, product_id, quantity | order_id, product_id |

**API 엔드포인트**:
- POST /orders - 주문 생성
- GET /orders/:id - 주문 조회
- GET /users/:userId/orders - 사용자 주문 목록
- PUT /orders/:id/cancel - 주문 취소

### Payment Service

**역할**: 결제 처리, 환불, 결제 정보 관리

**기술 스택**:
- Go 1.21
- Gin 1.9
- PostgreSQL 15

**결제 게이트웨이 통합**:
- Stripe (신용카드)
- PayPal (PayPal 계정)
- Kakao Pay (카카오페이)

**보안**:
- PCI DSS 준수
- 결제 정보 암호화
- 결제 로그 보관 5년

### Notification Service

**역할**: 알림 발송 (이메일, SMS, 푸시)

**기술 스택**:
- Node.js 20
- BullMQ (Redis 기반)
- MongoDB (알림 기록)

**알림 채널**:
- 이메일 (SendGrid)
- SMS (Twilio)
- 푸시 알림 (Firebase Cloud Messaging)

**메시지 큐**:
\`\`\`javascript
// 알림 작업 정의
const notificationQueue = new Queue('notifications', {
  connection: redis
});

// 이메일 발송
notificationQueue.add('email', {
  to: 'user@example.com',
  template: 'order-confirmation',
  data: { orderId: '123' }
});

// SMS 발송
notificationQueue.add('sms', {
  to: '+821012345678',
  message: '주문이 완료되었습니다'
});
\`\`\`

## 데이터 모델링

### ERD (Entity Relationship Diagram)

\`\`\`mermaid
erDiagram
    USERS ||--o{ ORDERS : places
    USERS ||--|| PROFILES : has
    ORDERS ||--o{ ORDER_ITEMS : contains
    ORDERS ||--|| PAYMENTS : has
    PRODUCTS ||--o{ ORDER_ITEMS : "ordered in"

    USERS {
        uuid id PK
        string email UK
        string password_hash
        timestamp created_at
    }

    PROFILES {
        uuid user_id PK, FK
        string name
        string avatar_url
    }

    ORDERS {
        uuid id PK
        uuid user_id FK
        string status
        decimal total_amount
        timestamp created_at
    }

    ORDER_ITEMS {
        uuid id PK
        uuid order_id FK
        uuid product_id FK
        int quantity
        decimal unit_price
    }

    PAYMENTS {
        uuid id PK
        uuid order_id FK, UK
        string status
        string payment_method
        decimal amount
        timestamp paid_at
    }

    PRODUCTS {
        uuid id PK
        string name
        string description
        decimal price
        int stock
    }
\`\`\`

## 보안 아키텍처

### 인증 및 인가

**인증 흐름**:

\`\`\`mermaid
sequenceDiagram
    participant User
    participant Client
    participant Auth
    participant API
    participant Service

    User->>Client: 로그인 요청
    Client->>Auth: POST /auth/login
    Auth-->>Client: Access Token, Refresh Token
    Client->>API: API 요청 + Token
    API->>Auth: 토큰 검증
    Auth-->>API: 사용자 정보
    API->>Service: 요청 전달
    Service-->>API: 응답
    API-->>Client: 데이터 반환
\`\`\`

**보안 계층**:

1. **네트워크 계층**
   - VPC (Virtual Private Cloud)
   - Security Groups
   - Network ACLs

2. **애플리케이션 계층**
   - JWT 인증
   - RBAC (Role-Based Access Control)
   - Rate Limiting
   - Input Validation

3. **데이터 계층**
   - 암호화 at rest (AES-256)
   - 암호화 in transit (TLS 1.3)
   - 데이터베이스 암호화

### 보안 정책

**비밀번호 정책**:
- 최소 8자
- 대문자, 소문자, 숫자, 특수문자 포함
- bcrypt 해싱 (salt rounds: 10)

**토큰 정책**:
- Access Token: 15분 유효
- Refresh Token: 7일 유효
- httpOnly 쿠키에 저장

**Rate Limiting**:
- 인증 없음: 10 req/min
- 인증됨: 100 req/min
- Admin: 1000 req/min

## 성능 최적화

### 캐싱 전략

**Redis 캐싱**:
\`\`\`javascript
// 사용자 세션 캐싱
const cacheUser = async (userId, userData) => {
  await redis.setex(
    \`user:\${userId}\`,
    3600, // 1시간
    JSON.stringify(userData)
  );
};

// 캐시된 사용자 조회
const getCachedUser = async (userId) => {
  const cached = await redis.get(\`user:\${userId}\`);
  return cached ? JSON.parse(cached) : null;
};
\`\`\`

**캐싱 정책**:
- 사용자 세션: 1시간
- 상품 정보: 30분
- 주문 통계: 5분
- 정적 데이터: 24시간

### 데이터베이스 최적화

**인덱싱**:
\`\`\`sql
-- 자주 조회하는 컬럼에 인덱스 추가
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);
CREATE INDEX idx_orders_status ON orders(status);

-- 복합 인덱스
CREATE INDEX idx_orders_user_status ON orders(user_id, status, created_at DESC);
\`\`\`

**쿼리 최적화**:
\`\`\`sql
-- 나쁜 쿼리 (N+1 문제)
SELECT * FROM orders WHERE user_id = '123';
-- 그 다음 각 주문마다...
SELECT * FROM order_items WHERE order_id = '1';
SELECT * FROM order_items WHERE order_id = '2';
-- ...

-- 좋은 쿼리 (JOIN 사용)
SELECT
  o.*,
  json_agg(oi.*) AS items
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = '123'
GROUP BY o.id;
\`\`\`

## 모니터링 및 로깅

### 모니터링 스택

- **Prometheus**: 메트릭 수집
- **Grafana**: 대시보드 시각화
- **AlertManager**: 알림 발송

### 로깅 전략

**구조화된 로그**:
\`\`\`json
{
  "timestamp": "2025-01-15T10:30:00Z",
  "level": "info",
  "service": "order-service",
  "trace_id": "abc123",
  "user_id": "user_456",
  "action": "order_created",
  "order_id": "order_789",
  "duration_ms": 125
}
\`\`\`

**로그 레벨**:
- ERROR: 오류, 즉시 조치 필요
- WARN: 경고, 모니터링 필요
- INFO: 정보, 정상 동작
- DEBUG: 디버그, 개발 환경

## 배포 전략

### CI/CD 파이프라인

\`\`\`mermaid
graph LR
    A[Code Push] --> B[Build]
    B --> C[Test]
    C --> D[Docker Build]
    D --> E[Push to Registry]
    E --> F[Deploy to Staging]
    F --> G[E2E Test]
    G --> H[Deploy to Production]
\`\`\`

### Blue-Green 배포

**배포 절차**:
1. 새 버전을 Green 환경에 배포
2. Smoke Test 실행
3. 트래픽을 Green으로 전환
4. Blue 환경 대기 (롤백 준비)
5. 1시간 후 Blue 환경 정리

## 재해 복구

### 백업 전략

- **데이터베이스**: 매일 밤 전체 백업, 매시간 증분 백업
- **보관 기간**: 30일
- **백업 위치**: AWS S3 (교차 리전 복제)

### 장애 조치

**장애 시나리오**:

1. **단일 서비스 장애**
   - Auto Scaling이 자동으로 교체
   - Health Check가 실패 감지
   - 최대 5분 내 복구

2. **데이터베이스 장애**
   - Read Replica로 승격
   - 최대 10분 내 복구
   - 데이터 손실 없음

3. **전체 리전 장애**
   - 다른 리전으로 트래픽 전환
   - DNS 레코드 업데이트
   - 최대 30분 내 복구

## 용어 사전

| 용어 | 정의 |
|------|------|
| API Gateway | 클라이언트 요청을 받아 적절한 서비스로 라우팅하는 컴포넌트 |
| Microservice | 독립적으로 배포 가능한 작은 서비스 |
| Event-Driven | 이벤트를 통해 서비스가 통신하는 아키텍처 |
| Rate Limiting | 일정 시간 동안의 요청 수를 제한하는 기능 |
| JWT | JSON Web Token, 인증 정보를 담은 토큰 |

## 변경 기록

| 버전 | 날짜 | 변경사항 | 작성자 |
|------|------|----------|--------|
| 1.0.0 | 2025-01-15 | 초기 버전 | 아키텍처 팀 |
| 0.9.0 | 2025-01-01 | 리뷰 초안 | 아키텍처 팀 |

---

## 참고 자료

- [12-Factor App](https://12factor.net/)
- [Microservices Patterns](https://microservices.io/patterns/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
```

---

## 고급 패턴

### 다국어 문서화

다국어 지원은 글로벌 프로젝트에 필수적입니다.

#### 디렉토리 구조

```
docs/
├── ko/
│   ├── README.md
│   ├── api-reference.md
│   ├── tutorials/
│   │   ├── getting-started.md
│   │   └── authentication.md
│   └── architecture.md
├── en/
│   ├── README.md
│   ├── api-reference.md
│   ├── tutorials/
│   │   ├── getting-started.md
│   │   └── authentication.md
│   └── architecture.md
├── ja/
│   └── ...
└── README.md (언어 선택 페이지)
```

#### 언어 선택 페이지

```markdown
# Welcome / 환영합니다 / ようこそ / 欢迎

Choose your language / 언어를 선택하세요 / 言語を選択してください / 选择您的语言:

- 🇰🇷 [한국어](./ko/README.md)
- 🇺🇸 [English](./en/README.md)
- 🇯🇵 [日本語](./ja/README.md)
- 🇨🇳 [中文](./zh/README.md)

---

Choose your language / 언어를 선택하세요 / 言語を選択してください / 选择您的语言:
```

#### i18n 구성

```javascript
// i18n 구성 (Next.js 예시)
module.exports = {
  i18n: {
    locales: ['ko', 'en', 'ja', 'zh'],
    defaultLocale: 'en',
    localeDetection: true,
  },
};
```

### 문서 자동화

자동화로 문서를 최신 상태로 유지하세요.

#### API 문서 자동화 (Swagger/OpenAPI)

```yaml
# openapi.yaml
openapi: 3.0.0
info:
  title: Awesome API
  version: 1.0.0
  description: |
    Awesome API의 공식 문서입니다.

    ## 인증

    모든 요청은 Bearer 토큰이 필요합니다:
    \`\`\`
    Authorization: Bearer YOUR_TOKEN
    \`\`\`

servers:
  - url: https://api.example.com/v1
    description: Production server
  - url: https://staging-api.example.com/v1
    description: Staging server

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      required:
        - id
        - email
      properties:
        id:
          type: string
          format: uuid
          description: 사용자 고유 ID
        email:
          type: string
          format: email
          description: 사용자 이메일
        name:
          type: string
          description: 사용자 이름
        createdAt:
          type: string
          format: date-time
          description: 생성일시

    Error:
      type: object
      required:
        - code
        - message
      properties:
        code:
          type: string
          description: 오류 코드
        message:
          type: string
          description: 오류 메시지
        details:
          type: object
          description: 추가 정보

paths:
  /users/{id}:
    get:
      summary: 사용자 정보 조회
      description: ID로 사용자 정보를 조회합니다
      security:
        - bearerAuth: []
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
          description: 사용자 ID
      responses:
        '200':
          description: 성공
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '401':
          description: 인증 실패
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '404':
          description: 사용자 없음
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
```

#### 코드에서 주석 기반 문서 생성

```javascript
/**
 * 사용자 인증 토큰 생성
 *
 * 이 함수는 JWT 토큰을 생성하여 사용자 인증을 처리합니다.
 * 토큰은 24시간 동안 유효하며, 사용자 ID와 이메일을 포함합니다.
 *
 * @since 1.0.0
 * @example
 * const token = generateAuthToken('user_123', 'user@example.com');
 * console.log(token); // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
 *
 * @param {string} userId - 사용자 고유 ID (UUID 형식)
 * @param {string} email - 사용자 이메일 주소
 * @param {Object} options - 추가 옵션
 * @param {number} [options.expiresIn=24] - 만료 시간 (시간 단위)
 * @param {string[]} [options.roles=[]] - 사용자 역할 목록
 * @returns {string} JWT 토큰
 * @throws {Error} userId가 없으면 에러 발생
 *
 * @see {@link https://jwt.io/} JWT 정보
 * @see verifyToken 토큰 검증 함수
 */
function generateAuthToken(userId, email, options = {}) {
  if (!userId) {
    throw new Error('userId는 필수 항목입니다');
  }

  const payload = {
    userId,
    email,
    roles: options.roles || [],
    iat: Math.floor(Date.now() / 1000)
  };

  const token = jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: `${options.expiresIn || 24}h`
  });

  return token;
}

/**
 * 사용자 인증 토큰 검증
 *
 * @param {string} token - 검증할 JWT 토큰
 * @returns {Object} 디코딩된 토큰 페이로드
 * @throws {Error} 토큰이 유효하지 않으면 에러 발생
 */
function verifyToken(token) {
  return jwt.verify(token, process.env.JWT_SECRET);
}
```

#### JSDoc을 이용한 HTML 문서 생성

```bash
# JSDoc 설치
npm install --save-dev jsdoc

# 문서 생성
jsdoc src/**/*.js -d docs/api
```

### 문서 유지 관리

문서는 살아있는 자산입니다. 지속적으로 관리해야 합니다.

#### 업데이트 워크플로우

1. **코드 변경 시 문서 업데이트**
   - PR 템플릿에 문서 업데이트 확인 항목 추가
   - 코드 리뷰 시 문서 변경 확인

2. **정기적 검토**
   - 분기별로 문서 정확성 확인
   - 사용자 피드백 반영

3. **사용자 피드백**
   - 각 문서 페이지에 "이 문서가 도움이 되었나요?" 피드백 폼
   - GitHub Issues를 통한 문서 개선 제안

4. **버전 관리**
   - 문서 버전과 코드 버전 동기화
   - deprecated 기능 명시

#### Changelog 관리

```markdown
# Changelog

모든 주요 변경사항은 이 파일에 기록됩니다.

포맷은 [Keep a Changelog](https://keepachangelog.com/ko-kr/1.0.0/)를 기반으로 하며,
[Semantic Versioning](https://semver.org/lang/ko/)을 따릅니다.

## [Unreleased]

### 예정된 기능
- OAuth 2.0 지원
- 실시간 알림

## [1.2.0] - 2025-01-15

### Added
- 새로운 사용자 인증 API (`/auth/login`, `/auth/refresh`)
- 다크 모드 지원
- 한국어, 일본어, 중국어 현지화

### Changed
- API 응답 형식 개선 (JSON API 사양 준수)
- 성능 최적화 (응답 시간 50% 단축)
- UI/UX 개선

### Deprecated
- 구버전 인증 API (`/login`) - 2.0에서 제거 예정
- `user.getUsername()` 메서드 - `user.getName()` 사용 권장

### Fixed
- 로그인 시간 초과 버그 수정
- 모바일 레이아웃 문제 해결
- 메모리 누수 수정

### Removed
- 더 이상 사용되지 않는 유틸리티 함수들
- IE 11 지원 (IE 지원 종료)

### Security
- JWT 토큰 보안 강화
- XSS 취약점 수정

## [1.1.0] - 2024-12-01

### Added
- 사용자 프로필 기능
- 파일 업로드 API

### Changed
- 데이터베이스 스키마 변경

## [1.0.0] - 2024-11-15

### Added
- 초기 릴리스
- 기본 사용자 인증
- CRUD API
```

### 시각적 도구 활용

다이어그램이 복잡한 개념을 단순하게 만들어요.

#### Mermaid 다이어그램 예시

**순서도 (Flowchart)**:

```markdown
\`\`\`mermaid
flowchart TD
    A[시작] --> B{사용자 인증?}
    B -->|예| C[대시보드]
    B -->|아니오| D[로그인 페이지]
    D --> E{로그인 성공?}
    E -->|예| C
    E -->|아니오| F[에러 메시지]
    F --> D
    C --> G[기능 선택]
\`\`\`
```

**시퀀스 다이어그램 (Sequence Diagram)**:

```markdown
\`\`\`mermaid
sequenceDiagram
    participant U as 사용자
    participant C as 클라이언트
    participant S as 서버
    participant D as 데이터베이스

    U->>C: 로그인 요청
    C->>S: POST /auth/login
    S->>D: 사용자 조회
    D-->>S: 사용자 정보
    S->>S: 토큰 생성
    S-->>C: 토큰 반환
    C-->>U: 로그인 성공
\`\`\`
```

**클래스 다이어그램 (Class Diagram)**:

```markdown
\`\`\`mermaid
classDiagram
    class User {
        +String id
        +String email
        +String password
        +login()
        +logout()
    }

    class Profile {
        +String userId
        +String name
        +String avatar
        +update()
    }

    class Session {
        +String id
        +String userId
        +Date expiresAt
        +isValid()
    }

    User "1" --> "1" Profile
    User "1" --> "*" Session
\`\`\`
```

**상태 다이어그램 (State Diagram)**:

```markdown
\`\`\`mermaid
stateDiagram-v2
    [*] --> Pending: 주문 생성
    Pending --> Processing: 결제 완료
    Processing --> Shipped: 배송 시작
    Shipped --> Delivered: 배송 완료
    Delivered --> [*]

    Pending --> Cancelled: 주문 취소
    Processing --> Cancelled: 결제 취소

    note right of Pending
        주문 대기 상태
        30분 내 결제 필요
    end note
\`\`\`
```

**ER 다이어그램 (Entity Relationship)**:

```markdown
\`\`\`mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE_ITEM : contains
    PRODUCT ||--o{ LINE_ITEM : "ordered in"
    ORDER ||--|| INVOICE : "billed to"

    CUSTOMER {
        string id PK
        string name
        string email
    }

    ORDER {
        string id PK
        string customer_id FK
        date order_date
    }

    LINE_ITEM {
        string id PK
        string order_id FK
        string product_id FK
        int quantity
    }

    PRODUCT {
        string id PK
        string name
        decimal price
    }
\`\`\`
```

---

## 실전 예제

### 실제 프로젝트 README 예시

```markdown
# 🚀 Awesome Project

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/username/awesome-project.svg?branch=main)](https://travis-ci.org/username/awesome-project)
[![codecov](https://codecov.io/gh/username/awesome-project/branch/main/graph/badge.svg)](https://codecov.io/gh/username/awesome-project)
[![npm version](https://badge.fury.io/js/awesome-project.svg)](https://www.npmjs.com/package/awesome-project)

> 초고속 실시간 데이터 처리 플랫폼

## 📋 목차

- [특징](#특징)
- [빠른 시작](#빠른-시작)
- [설치](#설치)
- [사용법](#사용법)
- [API 문서](#api-문서)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

## ✨ 특징

- ⚡️ **초고속 처리**: 100만 개 레코드를 1초 내 처리
- 🔒 **보안**: JWT 인증, 암호화 통신
- 📊 **실시간**: WebSocket 기반 실시간 데이터 전송
- 🌍 **다국어**: 한국어, 영어, 일본어, 중국어 지원
- 🎯 **TypeScript**: 완전한 타입 정의 제공

## 🚀 빠른 시작

### 5분 만에 시작하기

\`\`\`bash
# 1. 설치
npm install awesome-project

# 2. 초기화
npx awesome-project init

# 3. 시작
npm start
\`\`\`

브라우저에서 [http://localhost:3000](http://localhost:3000)을 열어 확인하세요!

## 📦 설치

### npm

\`\`\`bash
npm install awesome-project
\`\`\`

### yarn

\`\`\`bash
yarn add awesome-project
\`\`\`

### CDN

\`\`\`html
<script src="https://cdn.jsdelivr.net/npm/awesome-project@latest/dist/awesome.min.js"></script>
\`\`\`

## 💻 사용법

### 기본 사용법

\`\`\`typescript
import { Awesome } from 'awesome-project';

const awesome = new Awesome({
  apiKey: process.env.API_KEY,
  debug: true
});

// 데이터 처리
const result = await awesome.process(data);
console.log(result);
\`\`\`

### 고급 사용법

\`\`\`typescript
const awesome = new Awesome({
  apiKey: process.env.API_KEY,
  timeout: 5000,
  maxRetries: 3,
  batchSize: 1000
});

// 실시간 스트리밍
awesome.stream(source)
  .on('data', (data) => console.log('Received:', data))
  .on('error', (error) => console.error('Error:', error))
  .on('end', () => console.log('Done!'));
\`\`\`

## 📚 API 문서

전체 API 문서는 [여기](./docs/api.md)를 참조하세요.

### 주요 API

- `process(data)`: 데이터 처리
- `stream(source)`: 실시간 스트리밍
- `batch(items)`: 배치 처리
- `query(filters)`: 데이터 조회

## 🤝 기여하기

기여를 환영합니다! [기여 가이드](./CONTRIBUTING.md)를 참조하세요.

### 개발

\`\`\`bash
# 1. 포크 & 클론
git clone https://github.com/username/awesome-project.git
cd awesome-project

# 2. 의존성 설치
npm install

# 3. 개발 서버 실행
npm run dev

# 4. 테스트 실행
npm test

# 5. 빌드
npm run build
\`\`\`

## 📝 라이선스

MIT © [Your Name](https://github.com/username)

---

⭐️ 이 프로젝트가 마음에 드신다면 Star를 눌러주세요!
```

---

## 자주 묻는 질문

### 문서 작성 관련

**Q: 얼마나 상세하게 작성해야 하나요?**

A: 독자의 기술 수준에 맞춰세요:
- **초급자**: 모든 단계를 상세히 설명, 용어 정의 포함
- **중급자**: 핵심 개념과 실용 예시 중심
- **전문가**: 고급 주제, 성능 최적화, 내부 동작 원리

**Q: 코드 예시는 어떻게 작성하나요?**

A: 다음 원칙을 따르세요:
1. 실제로 실행 가능한 완전한 코드
2. 주석을 포함하여 왜 이렇게 하는지 설명
3. 실행 결과도 함께 보여주기
4. 에러 처리도 포함

**Q: 문서를 언제 업데이트해야 하나요?**

A: 다음 경우에 업데이트하세요:
- 코드가 변경될 때 (API, 기능 추가/변경)
- 버그 수정로 사용 방식이 바뀔 때
- 사용자 피드백으로 개선 필요성이 확인될 때
- 분기별 정기 검토 시

**Q: 다이어그램은 언제 사용하나요?**

A: 다음 상황에서 다이어그램을 사용하세요:
- 복잡한 시스템 아키텍처 설명
- 데이터 흐름이나 상태 전이 설명
- 구성 요소 간의 관계 설명
- 사용자 경로나 프로세스 설명

### 문서 구조 관련

**Q: 문서를 어떻게 구성해야 하나요?**

A: 논리적인 흐름으로 구성하세요:
1. **개요**: 무엇인지, 왜 필요한지
2. **전제 조건**: 시작하기 전 필요한 것
3. **빠른 시작**: 최소한으로 실행하는 방법
4. **상세 가이드**: 단계별 설명
5. **고급 주제**: 심화 내용
6. **참고 자료**: 추가 정보

**Q: 문서 버전은 어떻게 관리하나요?**

A: 다음 방법을 권장합니다:
- 문서 버전과 코드 버전 동기화
- 각 버전별 별도 문서 (v1.0, v2.0)
- migration guide로 버전 간 변경사항 안내
- deprecated 기능 명시

**Q: 다국어 문서는 어떻게 관리하나요?**

A: 다음 전략을 권장합니다:
- 언어별 디렉토리 분리 (`docs/ko/`, `docs/en/`)
- 번역은 원문보다 간결하게
- 문화적 차이 고려 (예: 공손한 표현)
- 전문 용어는 원어 그대로 사용 (예: API, JWT)

---

## 결론

좋은 문서는 프로젝트의 성공을 결정짓는 중요한 요소입니다. 시간을 투자해서 명확하고 이해하기 쉬운 문서를 작성하세요. 사용자가 감사할 거예요!

더 많은 예시와 패턴은 [moai-docs-generation](https://github.com/moai-adk/docs-generation)을 참조하세요.

자, 어떤 문서를 함께 만들어볼까요? 📝✨
