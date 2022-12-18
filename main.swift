/*
Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the WordDictionary class:

WordDictionary() Initializes the object.
void addWord(word) Adds word to the data structure, it can be matched later.
bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.
*/

class WordDictionary {
    class TrieNode {
        var value: Character
        var children: [Character: TrieNode]
        var isLast: Bool

        init(_ value: Character, _ isLast: Bool = false) {
            self.value = value
            self.children = [:]
            self.isLast = isLast
        }
    }

    var main: TrieNode

    init() {
        self.main = TrieNode("*")
    }
    
    func addWord(_ word: String) {
        var node = self.main
        for character in word {
            if node.children[character] == nil {
                node.children[character] = TrieNode(character)
            }
            node = node.children[character]!
        }
        node.isLast = true
    }
    
    func search(_ word: String) -> Bool {
        var word = word.map(Character.init)
        func dfs(_ root: TrieNode, _ word: [Character], _ i: Int) -> Bool {
            guard i < word.count else { return root.isLast }
            if word[i] == "." {
                for child in root.children.values {
                    if dfs(child, word, i + 1) { return true }
                }
            } else if root.children[word[i]] != nil {
                if dfs(root.children[word[i]]!, word, i + 1) { return true }
            }
            return false
        }
        return dfs(self.main, word, 0)
    }
}