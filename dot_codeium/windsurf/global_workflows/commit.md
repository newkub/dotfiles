# Commit Workflow

## Part 1: Pre-Commit Validation

### 1.1 Check Repository Status
ตรวจสอบสถานะ Git repository ก่อน commit

1. ตรวจสอบว่าอยู่ใน Git repository
2. ตรวจสอบว่าไม่มี uncommitted changes ที่ค้างอยู่
3. ตรวจสอบว่า working directory สะอาด
4. ตรวจสอบว่ามี changes ที่จะ commit

### 1.2 Validate Changes
ตรวจสอบความถูกต้องของการเปลี่ยนแปลง

1. ตรวจสอบว่าไฟล์ที่จะ commit ไม่มี sensitive data
2. ตรวจสอบว่า code ผ่าน linting rules
3. ตรวจสอบว่า tests ผ่านทั้งหมด
4. ตรวจสอบว่าไม่มี merge conflicts

## Part 2: Commit Quality Assessment

### 2.1 Review Changes with Diff
วิเคราะห์การเปลี่ยนแปลงก่อน commit

1. รัน `git diff --stat` เพื่อดูภาพรวมการเปลี่ยนแปลง
2. รัน `git diff` เพื่อตรวจสอบรายละเอียดการเปลี่ยนแปลง
3. จัดกลุ่มการเปลี่ยนแปลงตามความสัมพันธ์กัน
4. ประเมินขนาดและความซับซ้อนของการเปลี่ยนแปลง

### 2.2 Commit Splitting Strategy
แบ่ง commit ตามหลักการ atomic commits

**กฎการแบ่ง commits:**
- **ห้าม commit ทั้งหมดในครั้งเดียว** ถ้ามีการเปลี่ยนแปลงหลายประเภท
- แบ่งตาม **ความสัมพันธ์ของการเปลี่ยนแปลง**
- แบ่งตาม **ฟีเจอร์หรือฟังก์ชัน**
- แบ่งตาม **ประเภทของการเปลี่ยนแปลง** (feat, fix, docs, refactor, etc.)

**ตัวอย่างการแบ่ง commits:**
```bash
# ❌ ผิด - commit ทั้งหมดในครั้งเดียว
git add .
git commit -m "update project"

# ✅ ถูก - แบ่งตามประเภทของการเปลี่ยนแปลง
git add src/auth/ tests/auth.test.js
git commit -m "feat: add user authentication"

git add docs/api.md
git commit -m "docs: update API documentation"

git add package.json yarn.lock
git commit -m "deps: update dependencies"
```

**เกณฑ์การแบ่ง commits:**
- **Feature changes:** การเพิ่มฟีเจอร์ใหม่
- **Bug fixes:** การแก้ไขข้อผิดพลาด
- **Documentation:** การอัปเดตเอกสาร
- **Refactoring:** การปรับโครงสร้างโค้ด
- **Configuration:** การเปลี่ยนแปลง config files
- **Dependencies:** การอัปเดต dependencies

### 2.3 Stage Changes
เลือกไฟล์ที่จะ commit

1. ตรวจสอบว่าไฟล์ที่จะ add ถูกต้อง
2. ใช้ `git add` สำหรับไฟล์ที่ต้องการ commit
3. ตรวจสอบว่า staging area ถูกต้อง
4. ยืนยันการ staging ก่อน commit

### 2.4 Create Commit Message
เขียน commit message ตามมาตรฐาน

1. ใช้ conventional commit format: `type(scope): description`
2. เขียน subject line ไม่เกิน 50 ตัวอักษร
3. เพิ่ม body ถ้าจำเป็น พร้อมเหตุผลของการเปลี่ยนแปลง
4. เพิ่ม footer สำหรับ breaking changes หรือ references

### 2.5 Execute Commit
ทำการ commit

1. ตรวจสอบ commit message อีกครั้ง
2. รัน `git commit` ด้วย message ที่เตรียมไว้
3. ตรวจสอบว่า commit สำเร็จ
4. บันทึก commit hash สำหรับการติดตาม

## Part 3: Verification

### 3.1 Post-Commit Verification
ตรวจสอบภายหลัง commit

1. ตรวจสอบว่า commit ปรากฏใน `git log`
2. ตรวจสอบว่า commit message ถูกต้อง
3. ตรวจสอบว่าไม่มีไฟล์ที่ถูกลืม
4. ตรวจสอบว่า repository state ถูกต้อง

## Part 4: Best Practices

### 5.1 Commit Guidelines
แนวทางการเขียน commit ที่ดี

1. Commit แบบ atomic - การเปลี่ยนแปลงเดียวต่อ commit
2. ใช้ present tense ใน commit message
3. อธิบายว่าทำไม ไม่ใช่ทำอะไก
4. จำกัดขนาด commit ไม่ใหญ่เกินไป
5. **อ่าน diff ทุกครั้งก่อน commit**
6. **แบ่ง commits ตามความสัมพันธ์ของการเปลี่ยนแปลง**

### 5.2 Branch Guidelines
แนวทางการจัดการ branch

1. ทำงานบน feature branch ไม่ใช่ main
2. ใช้ naming convention สำหรับ branches
3. ลบ branches หลัง merge เสร็จ
4. ทำ code review ก่อน merge

### 5.3 Commit Quality Checklist
ตรวจสอบคุณภาพ commit ก่อน commit

- [ ] อ่าน `git diff` แล้วเข้าใจการเปลี่ยนแปลงทั้งหมด
- [ ] แบ่ง commits ตามประเภทของการเปลี่ยนแปลงแล้ว
- [ ] Commit message ตามมาตรฐาน conventional commits
- [ ] ไม่มี sensitive data ใน commits
- [ ] Tests ผ่านทั้งหมด (ถ้ามี)
- [ ] Code ผ่าน linting rules (ถ้ามี)

## Verification

1. ตรวจสอบว่า workflow สร้างสำเร็จใน `commit.md`
2. ทดสอบด้วยการอ้างอิง `[commit](commit.md)` ใน chat
3. ตรวจสอบว่า workflow ทำงานตามขั้นตอนที่ระบุ
4. ตรวจสอบว่า best practices ถูกนำมาใช้งาน
