package org.zang.util;

import java.util.HashMap;
import java.util.Map;

/**
 * brain-wave
 * 2024/7/8 22:32
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class TrieNode {
    public Map<Character, TrieNode> children;
    public boolean isEndOfWord;
    public int index;  // 存储单词的起始下标

    public TrieNode() {
        children = new HashMap<>();
        isEndOfWord = false;
        index = -1;
    }
}
