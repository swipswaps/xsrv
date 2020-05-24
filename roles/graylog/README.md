## graylog

**STATUS: WORK IN PROGRESS**

### Usage

- [inputs](https://docs.graylog.org/en/3.2/pages/sending_data.html) define network ports on which to listen, and the expected format/protocol (syslog, gelf...)
- [extractors](https://docs.graylog.org/en/3.2/pages/extractors.html) can extract meaningful data fields (addresses, processes, status...) from logs coming from inputs (using regex or _Grok patterns_).
- [streams](https://docs.graylog.org/en/3.2/pages/streams.html) are basic categories for your messages (filtered by message, other fields, source input...). Messages falling into streams can be prevented to reach the `All messages` default stream - use [Search](https://my.example.org/search) to search in all messages.
- [dashboards](https://my.example.org/dashboards) hold log visualization tools (charts, diagrams, counters, widgets...). Widgets can be generated from the search page (from the histogram - or from raw fields data using `Generate chart`,`Quick values`,`Statistics`) while searching for specific terms/time ranges.
- [authentication](https://my.example.org/system/authentication/users) and [roles](https://my.example.org/system/authentication/roles) settings allow granting  read or write access to specific users/groups. LDAP is supported.

### Backups

There are no backups of log data. Graylog settings can be backed up by `mongodump` as binary JSON files - use `bsondump` from the `mongo-tools` package to dump the text contents of a backup.

- `inputs.bson`: input and extractor settings.
- `streams.bson, streamrules.bson`: streams settings.
- `dashboards.bson`: dashboards settings.

