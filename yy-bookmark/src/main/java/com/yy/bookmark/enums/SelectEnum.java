package com.yy.bookmark.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@Getter
@AllArgsConstructor
public enum SelectEnum {
    BOOKMARK_FOLDER("folder", "bookmark_folder", "id", "name");

    private final String path;

    private final String tableName;

    private final String valueColumn;

    private final String labelColumn;

    public static SelectEnum getByPath(String path) {
        return Arrays.stream(values()).filter(item -> path.equals(item.getPath())).findFirst().orElse(null);
    }
}
