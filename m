From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 13:03:36 +0100
Subject: [PATCH 1/6] drivers: usb: remove usage of list iterator past the
 loop body
In-Reply-To: <20220228112413.GA2812@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-2-jakobkoschel@gmail.com>
 <20220228112413.GA2812@kadam>
Message-ID: <E31E215E-C409-40B8-8452-57E70C91484C@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 28. Feb 2022, at 12:24, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> On Mon, Feb 28, 2022 at 12:08:17PM +0100, Jakob Koschel wrote:
>> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
>> index 9040a0561466..0fd0307bc07b 100644
>> --- a/drivers/usb/gadget/udc/at91_udc.c
>> +++ b/drivers/usb/gadget/udc/at91_udc.c
>> @@ -150,13 +150,14 @@ static void proc_ep_show(struct seq_file *s, struct at91_ep *ep)
>> 	if (list_empty (&ep->queue))
>> 		seq_printf(s, "\t(queue empty)\n");
>> 
>> -	else list_for_each_entry (req, &ep->queue, queue) {
>> -		unsigned	length = req->req.actual;
>> +	else
>> +		list_for_each_entry(req, &ep->queue, queue) {
>> +			unsigned int	length = req->req.actual;
>> 
>> -		seq_printf(s, "\treq %p len %d/%d buf %p\n",
>> -				&req->req, length,
>> -				req->req.length, req->req.buf);
>> -	}
>> +			seq_printf(s, "\treq %p len %d/%d buf %p\n",
>> +					&req->req, length,
>> +					req->req.length, req->req.buf);
>> +		}
> 
> Don't make unrelated white space changes.  It just makes the patch
> harder to review.  As you're writing the patch make note of any
> additional changes and do them later in a separate patch.
> 
> Also a multi-line indent gets curly braces for readability even though
> it's not required by C.  And then both sides would get curly braces.
> 
>> 	spin_unlock_irqrestore(&udc->lock, flags);
>> }
>> 
>> @@ -226,7 +227,7 @@ static int proc_udc_show(struct seq_file *s, void *unused)
>> 
>> 	if (udc->enabled && udc->vbus) {
>> 		proc_ep_show(s, &udc->ep[0]);
>> -		list_for_each_entry (ep, &udc->gadget.ep_list, ep.ep_list) {
>> +		list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {
> 
> Another unrelated change.
> 
>> 			if (ep->ep.desc)
>> 				proc_ep_show(s, ep);
>> 		}
> 
> 
> [ snip ]

Thanks for pointing out, I'll remove the changes here and note them down
to send them separately.

> 
>> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
>> index 7c38057dcb4a..bb59200f1596 100644
>> --- a/drivers/usb/gadget/udc/net2272.c
>> +++ b/drivers/usb/gadget/udc/net2272.c
>> @@ -926,7 +926,8 @@ static int
>> net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>> {
>> 	struct net2272_ep *ep;
>> -	struct net2272_request *req;
>> +	struct net2272_request *req = NULL;
>> +	struct net2272_request *tmp;
>> 	unsigned long flags;
>> 	int stopped;
>> 
>> @@ -939,11 +940,13 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>> 	ep->stopped = 1;
>> 
>> 	/* make sure it's still queued on this endpoint */
>> -	list_for_each_entry(req, &ep->queue, queue) {
>> -		if (&req->req == _req)
>> +	list_for_each_entry(tmp, &ep->queue, queue) {
>> +		if (&tmp->req == _req) {
>> +			req = tmp;
>> 			break;
>> +		}
>> 	}
>> -	if (&req->req != _req) {
>> +	if (!req) {
>> 		ep->stopped = stopped;
>> 		spin_unlock_irqrestore(&ep->dev->lock, flags);
>> 		return -EINVAL;
>> @@ -954,7 +957,6 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>> 		dev_dbg(ep->dev->dev, "unlink (%s) pio\n", _ep->name);
>> 		net2272_done(ep, req, -ECONNRESET);
>> 	}
>> -	req = NULL;
> 
> Another unrelated change.  These are all good changes but send them as
> separate patches.

You are referring to the req = NULL, right?

I've changed the use of 'req' in the same function and assumed that I can
just remove the unnecessary statement. But if it's better to do separately
I'll do that.

> 
>> 	ep->stopped = stopped;
>> 
>> 	spin_unlock_irqrestore(&ep->dev->lock, flags);
> 
> regards,
> dan carpenter

thanks,
Jakob Koschel

