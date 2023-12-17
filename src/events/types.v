module events

pub struct Queue{
	pub mut:
	events []Event
	subscribers []Subscriber
}
pub fn (s &Queue) emit(data string){
	for su in s.subscribers {
		d:=Event{data:data}
		su.receive(d)
	}
}
pub fn (mut s Queue) subscribe(su Subscriber) {
	s.subscribers << su
}

pub struct Event{
	pub mut:
	data string
}

type EventResponder = fn (e Event) bool
pub struct Subscriber{
	name string
	responder EventResponder
}
pub fn subscriber_new(name string,responder EventResponder) &Subscriber{
	return &Subscriber{
		name:name,
		responder:responder
	}
}

pub fn (s &Subscriber) receive(e Event){
	s.responder(e)
}
