-- OrderFlow Database Schema
-- MySQL 8.4 (Aiven Cloud)
-- Created: June 2026

-- ================================================
-- Table 1: orders
-- Stores all successfully validated and processed orders
-- ================================================
CREATE TABLE "orders" (
  "id" int NOT NULL AUTO_INCREMENT,
  "order_id" varchar(50) NOT NULL,
  "customer_name" varchar(100) DEFAULT NULL,
  "customer_email" varchar(100) DEFAULT NULL,
  "product_code" varchar(50) DEFAULT NULL,
  "quantity" int DEFAULT NULL,
  "unit_price" decimal(10,2) DEFAULT NULL,
  "total_value" decimal(10,2) DEFAULT NULL,
  "status" varchar(20) DEFAULT 'received',
  "source_file" varchar(200) DEFAULT NULL,
  "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  UNIQUE KEY "order_id" ("order_id")
);

-- ================================================
-- Table 2: order_events  
-- Order lifecycle audit trail
-- ================================================
CREATE TABLE "order_events" (
  "id" int NOT NULL AUTO_INCREMENT,
  "order_id" varchar(50) NOT NULL,
  "event_type" varchar(50) DEFAULT NULL,
  "event_detail" text,
  "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- ================================================
-- Table 3: failed_orders
-- Dead Letter Queue — all rejected rows
-- ================================================
CREATE TABLE "failed_orders" (
  "id" int NOT NULL AUTO_INCREMENT,
  "order_id" varchar(50) DEFAULT NULL,
  "row_number" int DEFAULT NULL,
  "raw_data" text,
  "failure_type" varchar(50) DEFAULT NULL,
  "failure_reason" text,
  "source_file" varchar(200) DEFAULT NULL,
  "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- ================================================
-- Table 4: execution_metrics
-- Per-file processing observability
-- ================================================
CREATE TABLE "execution_metrics" (
  "id" int NOT NULL AUTO_INCREMENT,
  "file_name" varchar(200) DEFAULT NULL,
  "started_at" timestamp NULL DEFAULT NULL,
  "completed_at" timestamp NULL DEFAULT NULL,
  "total_rows" int DEFAULT NULL,
  "processed" int DEFAULT NULL,
  "failed" int DEFAULT NULL,
  "duplicates" int DEFAULT NULL,
  "status" varchar(20) DEFAULT NULL,
  "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
