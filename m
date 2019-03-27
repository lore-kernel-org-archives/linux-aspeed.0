From: Patrick Venture <venture@google.com>
Date: Wed, 27 Mar 2019 11:44:36 -0700
Subject: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
In-Reply-To: <20190327164542.GC11712@kroah.com>
References: <20190312163101.155910-1-venture@google.com>
 <20190327164542.GC11712@kroah.com>
Message-ID: <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > +     phys_addr_t mem_base;
>
> Is this really a 32bit value?

It's going to be a 32-bit value if this is in the dts for one of the
correspondingly supported aspeed models.

>
> Your ioctl thinks it is:
>
> > +struct aspeed_p2a_ctrl_mapping {
> > +     __u32 addr;
>
> Does this driver not work on a 64bit kernel?

This driver is aimed at only 32-bit hardware (ast2400/2500).  I
modeled the approach after the aspeed-lpc-ctrl driver as it's
providing similar functionality.

>
> > +     __u32 length;
> > +     __u32 flags;
> > +};
>
> addr really should be __u32 here so you don't have to mess with 32/64
> bit user/kernel issues, right?

Add is __u32 there.  Are you suggesting it shouldn't be?
>
> thanks,
>
> greg k-h
