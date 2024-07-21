package org.zang.util;

import java.util.ArrayList;
import java.util.List;

/**
 * brain-wave
 * 2024/7/8 22:45
 *
 * @author Ben，微信：wz_Fung_Ben，邮箱：842609063@qq.con <br/>
 **/
public class Trie {
    private final TrieNode root;
    public Trie() {
        root = new TrieNode();
    }

    // 插入一个单词并存储其起始下标
    public void insert(String word, int index) {
        TrieNode node = root;
        for (char ch : word.toCharArray()) {
            node.children.putIfAbsent(ch, new TrieNode());
            node = node.children.get(ch);
        }
        node.isEndOfWord = true;
        node.indices.add(index);
    }

    // 查找一个单词的起始下标列表，如果不存在则返回空列表
    public List<Integer> search(String word) {
        TrieNode node = root;
        for (char ch : word.toCharArray()) {
            node = node.children.get(ch);
            if (node == null) {
                return new ArrayList<>();
            }
        }
        return node.isEndOfWord ? node.indices : new ArrayList<>();
    }

    // 查找最长前缀的起始下标和匹配长度
    public int[] longestPrefixMatch(String prefix) {
        TrieNode node = root;
        int lastIndex = -1;
        int matchLength = 0;
        for (int i = 0; i < prefix.length(); i++) {
            char ch = prefix.charAt(i);
            node = node.children.get(ch);
            if (node == null) {
                break;
            }
            if (node.isEndOfWord && !node.indices.isEmpty()) {
                lastIndex = node.indices.get(node.indices.size() - 1); // 获取最后一个下标
                matchLength = i + 1;
            }
        }
        return new int[]{lastIndex, matchLength};
    }
}
