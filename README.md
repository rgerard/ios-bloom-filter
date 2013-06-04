## iOS Bloom Filter

This library is meant to be used as a simple bloom filter for your iOS applications. You can only add strings to the set, for the moment. You can easily create a bloom filter, and set the number of bits for your vector array, and the number of hash functions you want to use:

<pre>
  BloomFilter bfilter = [[BloomFilter alloc] initWithNumberOfBits:1000000 andWithNumberOfHashes:3];
</pre>

To add a word to the set:

<pre>
  [bfilter addToSet:@"my word"];
</pre>

To test whether a word is in the set:

<pre>
  BOOL found = [bfilter lookup:@"my word"];
</pre>

