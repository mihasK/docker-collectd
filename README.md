# How to run:

``` docker run -d -e HOST_NAME=dev -e SEND_TO_HOST=13.56.63.97 -e SEND_TO_PORT=5557 --restart=always --name collectd-agent mihas/docker-collectd```

# How to receive:
For example using logstash:

```
input {
  udp {
     port => 5557
     buffer_size => 1452
     codec => collectd { }
     type => "collectd"
  }

}
```
