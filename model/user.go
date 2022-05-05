package model

import (
	"time"

	"gorm.io/gorm"
)

type User struct {
	ID        uint           `gorm:"primaryKey"`
	Level     uint           `gorm:"default:4"`
	Status    uint           `gorm:"default:2"`
	Name      string         `gorm:"size:16;unique_index"`
	Pwd       string         `json:"-"`
	Nickname  string         `gorm:"size:16"`
	Avatar    string         `gorm:"default:'https://q1.qlogo.cn/g?b=qq&nk=7619376472&s=640'"`
	Bio       string         `gorm:"default:这个人很懒，什么都没有留下"`
	Email     string         `gorm:"size:50;unique_index" binding:"omitempty,email"`
	CreatedAt *time.Time     `gorm:"type:timestamp"`
	UpdatedAt *time.Time     `gorm:"type:timestamp"`
	DeletedAt gorm.DeletedAt `json:"-"`
}
