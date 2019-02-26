From: Patrick Venture <venture@google.com>
Date: Tue, 26 Feb 2019 14:32:24 -0800
Subject: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
In-Reply-To: <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
References: <20190221222537.137331-1-venture@google.com>
 <692c6c5d-9090-4e1f-9324-a03da381b003@www.fastmail.com>
 <CAO=notx+p5PQ1UXW7XKD=5Lb23RvC5+1R+LcJLxXYEnT6vvgkQ@mail.gmail.com>
 <CAO=notx1OTWbxg5EhgqDUcrpfBpgez3LXXrNKHX5VpOark3GvA@mail.gmail.com>
 <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
Message-ID: <CAO=notzjZQYeNo8nFmDfj+cw=hAMEmQ7GX-5ccY5786rMC_NEA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 26, 2019 at 2:20 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 27 Feb 2019, at 08:26, Patrick Venture wrote:
> > On Tue, Feb 26, 2019 at 1:42 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Sun, Feb 24, 2019 at 5:26 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > >
> > > >
> > > > > +
> > > > > +     /* Access to these needs to be locked, held via probe, mapping ioctl,
> > > > > +      * and release, remove.
> > > > > +      */
> > > > > +     struct mutex tracking;
> > > > > +     u32 readers;
> > > > > +     u32 readerwriters[P2A_REGION_COUNT];
> > > >
> > > > Might be better to use refcount_t here instead of u32?
> > >
> > > Ack
> >
> > refcount requires atomic, is that something we have with the ast2400, 2500?
>
> Ah, we do on the 2500 (armv6) but not the 2400 (armv5)

Ok, so to avoid that complexity I'm not going to swap in refcounts.
but good to know for future reference since it's basically what I was
doing manually.
