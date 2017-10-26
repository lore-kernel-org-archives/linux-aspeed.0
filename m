From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 26 Oct 2017 10:35:39 +1030
Subject: [RFC PATCH 3/5] gpio: gpiolib: Add chardev support for
 maintaining GPIO values on reset
In-Reply-To: <20171025081454.4avrf57mf33khu7c@localhost.localdomain>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-4-andrew@aj.id.au>
 <CACRpkdY4F-ocFxomLEsVyGA0odGooWysQq5MHi9qwUt6E_VDzA@mail.gmail.com>
 <1508490173.24322.53.camel@aj.id.au>
 <20171025081454.4avrf57mf33khu7c@localhost.localdomain>
Message-ID: <1508976339.13477.5.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-10-25 at 09:14 +0100, Charles Keepax wrote:
> On Fri, Oct 20, 2017 at 07:32:53PM +1030, Andrew Jeffery wrote:
> > On Fri, 2017-10-20 at 09:27 +0200, Linus Walleij wrote:
> > > I don't see it as helpful to give userspace control over whether the =
line
> > > is persistent or not. It is more reasonable to assume persistance for
> > > userspace use cases, don't you think? Whether the system goes to sleep
> > > or the gpiochip resets should not make a door suddenly close or the
> > > lights in the christmas tree go out, right? I think if the gpiochip s=
upports
> > > persistance of any kind, we should try to use it and not have userspa=
ce
> > > provide flags for that.
> >=20
> > Right. I guess the counter argument to your examples is if the gpio is
> > controlling any active process that we don't want to continue if we've
> > lost the capacity to monitor some other inputs (some kind of dead-man's=
=C2=A0
> > switch). But maybe the argument is that should be implemented in the
> > kernel anyway?
> >=20
>=20
> To me it certainly feels like decisions like this should live in
> the kernel, your talking about things that could cause very weird
> hardware behaviour if set wrong, so it makes sense to me to have
> that responsibility guarded in the kernel.

I feel that taking this argument to its logical conclusion leads to
never exporting any GPIOs to userspace and doing everything in the
kernel. If userspace has exported the GPIO and is managing its state,
then it can *already* cause very weird hardware behaviour if set wrong.
The fact that userspace is controlling the GPIO state and not the
kernel already says that the kernel doesn't know how to manage it, so
why not expose the option for userspace to set the persistence, given
that it should know what it's doing?

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171026/9=
d80925b/attachment.sig>
