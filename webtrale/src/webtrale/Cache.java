package webtrale;

import java.util.*;

public class Cache {
  int _maxItems;
  
  static class Item {
    String key;
    Object data;
    
    Item prev;
    Item next;
  }
  
  Map<String,Item> _key2Item = new TreeMap<String,Item>();
  Item _first = new Item();
  Item _last  = new Item();
  
  void addFront(Item item) {
    item.next = _first.next;
    item.next.prev = item;
    item.prev = _first;
    _first.next = item;
  }
  
  void unlink(Item item) {
    item.next.prev = item.prev;
    item.prev.next = item.next;
  }
  
  public Cache(int maxItems) {
    if (maxItems < 0)
      throw new IllegalArgumentException("maxItems should be non-negative");
    _maxItems = maxItems;
    
    clear();
  }
  
  synchronized void clear() {
    _first.next = _last;
    _last.prev = _first;
    _key2Item.clear();
  }
  
  synchronized Item getItem(String key) {
    Item item = _key2Item.get(key);
    if (item != null) {
      unlink(item);
      addFront(item);
      return item;
    }
    return null;
  }
  
  public Object getData(String key) {
    Item item = getItem(key);
    if (item == null)
      return null;
    synchronized (item) {
      return item.data;
    }
  }
  
  public void insert(String key, Object data) {
    Item item = getItem(key);
    if (item != null) {
      synchronized (item) {
        item.data = data;
      }
    }
    else {
      synchronized (this) {
        item = new Item();
        item.key = key;
        item.data = data;
        addFront(item);
        _key2Item.put(key, item);
        if (_key2Item.size() > _maxItems) {
          Item lastItem = _last.prev;
          unlink(lastItem);
          _key2Item.remove(lastItem.key);
        }
      }
    }
  }
  
  synchronized int getSize() { return _key2Item.size(); }
}
