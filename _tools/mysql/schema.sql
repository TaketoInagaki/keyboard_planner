CREATE TABLE `user`
(
    `id`       BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ユーザーの識別子',
    `name`     varchar(20) NOT NULL COMMENT 'ユーザー名',
    `password` VARCHAR(80) NOT NULL COMMENT 'パスワードハッシュ',
    `role`     VARCHAR(80) NOT NULL COMMENT 'ロール',
    `created`  DATETIME(6) NOT NULL COMMENT 'レコード作成日時',
    `modified` DATETIME(6) NOT NULL COMMENT 'レコード修正日時',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uix_name` (`name`) USING BTREE
) Engine=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ユーザー';

CREATE TABLE `task`
(
    `id`        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'タスクの識別子',
    `user_id`   BIGINT UNSIGNED NOT NULL COMMENT 'タスクを作成したユーザーの識別子',
    `date`      DATETIME(6) NOT NULL COMMENT 'タスクの日程',
    `date_type` VARCHAR(20) NOT NULL COMMENT 'タスクの種類',
    `created`   DATETIME(6) NOT NULL COMMENT 'レコード作成日時',
    `modified`  DATETIME(6) NOT NULL COMMENT 'レコード修正日時',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_task_user_id`
        FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
            ON DELETE RESTRICT ON UPDATE RESTRICT
) Engine=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='タスク';

CREATE TABLE `reflection`
(
    `id`           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '振り返りの識別子',
    `user_id`      BIGINT UNSIGNED NOT NULL COMMENT '振り返りを作成したユーザーの識別子',
    `content`      VARCHAR(255) NOT NULL COMMENT '振り返り内容',
    `content_type` VARCHAR(20) NOT NULL COMMENT '振り返りの種類',
    `date`         DATETIME(6) NOT NULL COMMENT '振り返り日程',
    `date_type`    VARCHAR(20) NOT NULL COMMENT '振り返り日程の種類',
    `created`      DATETIME(6) NOT NULL COMMENT 'レコード作成日時',
    `modified`     DATETIME(6) NOT NULL COMMENT 'レコード修正日時',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_reflection_user_id`
        FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
            ON DELETE RESTRICT ON UPDATE RESTRICT
) Engine=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='振り返り';