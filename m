From: Olof Johansson <olof@lixom.net>
Date: Mon, 29 Apr 2019 09:31:27 -0700
Subject: [PATCH] soc: add aspeed folder and misc drivers
In-Reply-To: <CAO=noty2QN6H_x3RMjqOrY9b0xLLz=MBk6Fb6yCdW9+J0a-bSA@mail.gmail.com>
References: <20190422173838.182736-1-venture@google.com>
 <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
 <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
 <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
 <CAO=noty2QN6H_x3RMjqOrY9b0xLLz=MBk6Fb6yCdW9+J0a-bSA@mail.gmail.com>
Message-ID: <20190429163127.r6k7yfriz5ha5xul@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 23, 2019 at 08:40:25AM -0700, Patrick Venture wrote:
> On Tue, Apr 23, 2019 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Apr 23, 2019 at 4:24 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Looks ok, but please resend to arm at kernel.org or soc at kernel.org
> > > > so we can track the submission and make sure it gets applied if
> > > > you want this to go through the arm-soc tree.
> > >
> > > Thanks, I didn't see those come up in the get_maintainers output.
> > >
> > > I had a longer question related to this patch progression -- if I am
> > > moving the aspeed gpio driver to the soc folder, the soc tree may have
> > > the soc/aspeed folder in their next, but the gpio tree wouldn't
> > > necessarily.  I know the branches sync up when things are merged at
> > > the top, but I wasn't sure if there was another mechanism for this?
> >
> > We can generally deal with merge conflicts like this, or you can ask
> > the respective maintainers about it and let us figure something out.
> 
> Thanks for explaining that.
> 
> >
> > In this particular case, why would you move the gpio driver into
> > the soc folder? If there is a proper subsystem for a driver, it should
> > not be in drivers/misc or drivers/soc.
> 
> Ok, that makes sense. I was trying to get a sense of what belonged in
> soc versus the subsystem folders.  My thinking from the limited
> reading was the purpose of a SoC folder was to contain the drivers
> that were only associated with a system-on-a-chip and not a part you
> could buy and place on any board.  A tmp421 sensor is just a generic
> part, versus the pwm controller, which is only for the specific SoCs.
> 
> That said, there are quite a few misc drivers associated with the
> Aspeed parts -- and there are two under review now, so there's a
> strong motivation to move those at least into the soc/aspeed folder.
> Thanks for these clarifying remarks.

drivers/soc is more about platform-level glue and SoC configuration, etc.
Specific IP blocks and drivers normally don't go into there, unless it's
a shared resource that a lot of drivers need access to.

So, for most of the small drivers around the SoC, other directories than
drivers/soc are still the best answer.


-Olof
