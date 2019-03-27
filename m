From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2019 19:54:10 +0100
Subject: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
In-Reply-To: <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
References: <20190312163101.155910-1-venture@google.com>
 <20190327164542.GC11712@kroah.com>
 <CAO=notxFvvOmpjMyXvt5PyuWsB92eraN+=8mWk8_aY2w3sK-eQ@mail.gmail.com>
Message-ID: <20190327185410.GA14828@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2019 at 11:44:36AM -0700, Patrick Venture wrote:
> On Wed, Mar 27, 2019 at 11:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> > > +     phys_addr_t mem_base;
> >
> > Is this really a 32bit value?
> 
> It's going to be a 32-bit value if this is in the dts for one of the
> correspondingly supported aspeed models.
> 
> >
> > Your ioctl thinks it is:
> >
> > > +struct aspeed_p2a_ctrl_mapping {
> > > +     __u32 addr;
> >
> > Does this driver not work on a 64bit kernel?
> 
> This driver is aimed at only 32-bit hardware (ast2400/2500).  I
> modeled the approach after the aspeed-lpc-ctrl driver as it's
> providing similar functionality.
> 
> >
> > > +     __u32 length;
> > > +     __u32 flags;
> > > +};
> >
> > addr really should be __u32 here so you don't have to mess with 32/64
> > bit user/kernel issues, right?
> 
> Add is __u32 there.  Are you suggesting it shouldn't be?

Ugh, yes, sorry, I meant to say "__u64".

If you all insist that this is all that is ever going to be needed, ok,
but I reserve the right to complain in 4 years when this needs to be
changed :)

thanks,

greg k-h
