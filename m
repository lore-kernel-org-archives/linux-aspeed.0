From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 25 Apr 2019 19:25:49 +0200
Subject: [PATCH v2] soc: add aspeed folder and misc drivers
In-Reply-To: <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
References: <20190423142629.120717-1-venture@google.com>
 <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
Message-ID: <20190425172549.GA12376@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > currently present into this folder.  These drivers are not generic part
> > > drivers, but rather only apply to the ASPEED SoCs.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> >
> > Accidentally lost the Acked-by when re-sending this patchset as I
> > didn't see it on v1 before re-sending v2 to the larger audience.
> 
> Since there was a change between v1 and v2, Arnd, I'd appreciate you
> Ack this version of the patchset since it changes when the soc/aspeed
> Makefile is followed.

I have no objection for moving stuff out of drivers/misc/ so the SOC
maintainers are free to take this.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
