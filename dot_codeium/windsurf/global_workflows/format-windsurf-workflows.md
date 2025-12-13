---
description: A guide to formatting WindSurf workflows for consistency and readability
auto_execution_mode: 3
---

# WindSurf Workflows Formatting Guide

## Core Principles

หลักการพื้นฐานของการจัดรูปแบบไฟล์ workflows ใน WindSurf ที่สอดคล้องกับ DeepSeek:

- **Consistency**: รูปแบบที่สม่ำเสมอทั่วทั้งโปรเจค
- **Readability**: อ่านง่าย เข้าใจได้เร็ว
- **Maintainability**: ปรับปรุงแก้ไขได้ง่าย
- **Modularity**: แยกส่วนต่างๆ ให้ชัดเจน
- **Documentation**: มีคำอธิบายเพียงพอ
- **DeepSeek Compatibility**: ตรงตามรูปแบบที่ DeepSeek ชอบ

## Structure Guidelines

### 1. Frontmatter Section
```yaml
```

### 2. Main Sections
```markdown
# [Workflow Name]

## [Section Title]

[content with clear explanations]
```

### 3. Code Examples
```markdown
```[language]
[well-commented code example]
```
```

## Best Practices

1. **Descriptive Section Headings**: ใช้หัวข้อที่สื่อความหมายชัดเจน
2. **Step-by-Step Instructions**: แบ่งขั้นตอนเป็นลำดับที่ชัดเจน
3. **Examples**: มีตัวอย่างการใช้งานจริง
4. **Notes and Warnings**: ใส่ข้อควรระวังหรือหมายเหตุพิเศษ

## Example Workflow (DeepSeek Style)

```markdown

# Production Deployment

## Preparation

1. Verify all tests pass
2. Check environment variables
3. Confirm dependencies

## Deployment Steps

```bash
npm run build
npm run test
npm run deploy
```

## Verification

- [ ] Check production logs
- [ ] Verify API endpoints
- [ ] Test critical user flows
```

