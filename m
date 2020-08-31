From: Felipe Balbi <balbi@kernel.org>
Date: Mon, 31 Aug 2020 12:54:57 +0300
Subject: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
 <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
Message-ID: <87y2lv9m32.fsf@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

Tao Ren <rentao.bupt@gmail.com> writes:
> On Mon, Aug 17, 2020 at 04:49:32PM +0300, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> rentao.bupt at gmail.com writes:
>> > From: Tao Ren <rentao.bupt@gmail.com>
>> >
>> > This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
>> > improve vhub port irq handling"): for_each_set_bit() is replaced with
>> > simple for() loop because for() loop runs faster on ASPEED BMC.
>> >
>> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>> > ---
>> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
>> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
>> >  2 files changed, 6 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > index cdf96911e4b1..be7bb64e3594 100644
>> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
>> >  
>> >  	/* Handle device interrupts */
>> >  	if (istat & vhub->port_irq_mask) {
>> > -		unsigned long bitmap = istat;
>> > -		int offset = VHUB_IRQ_DEV1_BIT;
>> > -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
>> > -
>> > -		for_each_set_bit_from(offset, &bitmap, size) {
>> > -			i = offset - VHUB_IRQ_DEV1_BIT;
>> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
>> > +		for (i = 0; i < vhub->max_ports; i++) {
>> > +			if (istat & VHUB_DEV_IRQ(i))
>> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
>> 
>> how have you measured your statement above? for_each_set_bit() does
>> exactly what you did. Unless your architecture has an instruction which
>> helps finds the next set bit (like cls on ARM), which, then, makes it
>> much faster.
>
> I did some testing and result shows for() loop runs faster than
> for_each_set_bit() loop. Please refer to details below (discussion with
> Benjamin in the original patch) and kindly let me know your suggestions.

no strong feelings, just surprised that you're already worried about
20~40 cycles of cpu time ;-)

Patch applied for next merge window

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 857 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200831/51107915/attachment.sig>
