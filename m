From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 02 Apr 2020 21:37:35 +1100
Subject: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
In-Reply-To: <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
 <20200315191632.12536-7-rentao.bupt@gmail.com>
 <20200330192347.GA6388@bogus>
 <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
 <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
Message-ID: <c556467d63cd5de806b4bf1806caee013ba5a808.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-03-31 at 10:21 -0600, Rob Herring wrote:
> Surely the descriptor building code can be shared at a minimum.
> 
> Regardless of whether gadget configfs fits, usually it is pretty clear
> whether something belongs in DT or userspace. That should be decided
> first.
> 
> > Maybe we could expose the port as UDCs but not actually expose them on
> > the bus until the hub is "activated" via a special configfs entry...
> 
> If control of the hub is done by userspace, I'd think configuration
> should be there too.

It's not in the current driver. For now, I expose the hub when the
driver loads/initializes, and it creates UDCs for each port, which are
then controlled from userspace.

That said, I did it this way because it was easy, not because there are
fundamental reasons to do so...

The main reason to want to change the hub descriptor is for the device
to advertise a vendor/device ID rather than our generic linux one,
which some vendors might want to do for ... reasons. I didn't implement
that functionality initially as in openbmc case, we didn't care. But I
know some vendors would like to, if anything because from a user
perspective, it's actually nice to have the string tell you that it's
your BMC rather than Linux Fundation Hub.

Originally I suggested we allow that via the device-tree because it was
the simplest way to get there and I love have to deal with less code ..
:)

However, if we want to support the whole language string set etc... it
gets really clumsy. So if there's a strong will to get there all the
way, then configfs is probably the way to go.

In that case, some sugery will probably be needed to make the gadget
descriptor building code a bit less dependent on the overall gadget
stuff... either that, or pre-create a "hub" gadget at driver loading
time that userspace can modify before "plugging".

In that case, the discussion should move back to linux-usb...

Cheers,
Ben.


