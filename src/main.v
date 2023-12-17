module main

import events
import rand

fn main() {
	println('Hello World!')
	mut q:=events.Queue{}
	mut queuea:=&[]string{}
	mut queueb:=&[]string{}
	q.subscribe(events.subscriber_new(
		"aaa",
		fn[mut queuea](d events.Event) bool {
			println("aaa got ${d.data}")
			queuea<<d.data
			return true
		}
	))
	q.subscribe(events.subscriber_new(
		"bbb",
		fn[mut queueb](d events.Event) bool {
			println("bbb got ${d.data}")
			queueb << d.data
			return true
		}
	))
	println(q)
	q.emit("I'm done")
	for i in 1..10 {
		q.emit("numbers incoming : ${rand.uuid_v4()}")
	}
	println(queuea.join(","))
	println(queueb)
}
