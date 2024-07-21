package org.zang.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * brain-wave
 * 2024/7/8 22:32
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class TrieNode {
    public ConcurrentHashMap<Character, TrieNode> children;
    public boolean isEndOfWord;
    // 存储单词的起始下标列表
    public List<Integer> indices;

    public TrieNode() {
        children = new ConcurrentHashMap<>();
        isEndOfWord = false;
        indices = new ArrayList<>();
    }
}
