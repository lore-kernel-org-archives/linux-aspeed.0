From: Olof Johansson <olof@lixom.net>
Date: Mon, 29 Apr 2019 10:12:48 -0700
Subject: [PATCH v2] soc: add aspeed folder and misc drivers
In-Reply-To: <20190429165137.mwj4ehhwerunbef4@localhost>
References: <20190423142629.120717-1-venture@google.com>
 <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
Message-ID: <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > >
> > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > Ack this version of the patchset since it changes when the soc/aspeed
> > > Makefile is followed.
> >
> > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > maintainers are free to take this.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I'm totally confused. This is the second "PATCH v2" of this patch that I came
> across, I already applied the first.
>
> Patrick: Follow up with incremental patch in case there's any difference.
> Meanwhile, please keep in mind that you're adding a lot of work for people when
> you respin patches without following up on the previous version. Thanks!

Not only that, but subthreads were cc:d to arm at kernel.org and some
were not, so I missed the overnight conversation on the topic.

If this email thread is any indication of how the code will be
flowing, there's definitely need for more structure. Joel, I'm hoping
you'll coordinate.

I'm with Arnd on whether the code should be in drivers/soc or not --
most of it likely should not.


-Olof
