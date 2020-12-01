# tomlcpp
TOML C++ Library

This is a C++ wrapper around the C library available here: https://github.com/cktan/tomlc99.

## Usage

Here is a simple example that parses this config file:

```
[server]
	host = "example.com"
	port = 80
```

Steps for getting values:

1. Call toml::parseFile on a toml file
2. Get the top-level table
3. Get values from the top-level table
4. Examine the values

```
// parse a file containing toml data
auto result = toml::parseFile("sample.toml");
if (!result.table) {
    handle_error(result.errmsg);
}

// get the top level table
auto server = result.table.getTable("server");
if (!server) {
    handle_error("missing table [server]");
}

// get value from the table
auto host = server->getString("host");
if (!host.first) {
    handle_error("missing or bad host entry");
}
auto port = server->getInt("port");
if (!port.first) {
   handle_error("missing or bad port entry");
}

// examine the values
cout << "server.host is " << host.second << "\n";
cout << "server.port is " << port.second << "\n";

```

## Parsing

To parse a toml text or file, simply call `toml::parse(text)` or `toml::parseFile(path)`. 
The return value is a `Result` struct. On success, the `Result.table` will have a non-NULL 
pointer to the toml table content. On failure, the `Result.table` will be NULL, and `Result.errmsg` 
stores a string describing the error.

## Traversing Table

Toml tables are key-value maps. 

#### Keys

The method `Table::keys()` returns a vector of keys.

#### Content

To extract value by keys, call the `Toml::getXXXX(key)` methods and supply the key:

```
toml::getString(key)
toml::getBool(key)
toml::getInt(key)
toml::getDouble(key)
toml::getTimestamp(key)
```

These methods return a C++ `pair`, in which `pair.first` is a success indicator, and `pair.second` is the result value.

To extract table or array by keys, use these methods which return a `unique_ptr` to an Array or Table:

```
toml::getTable(key)
toml::getArray(key)
```





