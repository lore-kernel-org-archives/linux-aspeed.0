From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Apr 2019 17:33:15 +0200
Subject: [PATCH] soc: add aspeed folder and misc drivers
In-Reply-To: <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
References: <20190422173838.182736-1-venture@google.com>
 <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
 <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
Message-ID: <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 23, 2019 at 4:24 PM Patrick Venture <venture@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> > >
> > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > currently present into this folder.  These drivers are not generic part
> > > drivers, but rather only apply to the ASPEED SoCs.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> >
> > Looks ok, but please resend to arm at kernel.org or soc at kernel.org
> > so we can track the submission and make sure it gets applied if
> > you want this to go through the arm-soc tree.
>
> Thanks, I didn't see those come up in the get_maintainers output.
>
> I had a longer question related to this patch progression -- if I am
> moving the aspeed gpio driver to the soc folder, the soc tree may have
> the soc/aspeed folder in their next, but the gpio tree wouldn't
> necessarily.  I know the branches sync up when things are merged at
> the top, but I wasn't sure if there was another mechanism for this?

We can generally deal with merge conflicts like this, or you can ask
the respective maintainers about it and let us figure something out.

In this particular case, why would you move the gpio driver into
the soc folder? If there is a proper subsystem for a driver, it should
not be in drivers/misc or drivers/soc.

       Arnd
