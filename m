From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 May 2024 09:22:01 -0000
Subject: [PATCH v2 07/20] pinctrl: renesas: Use scope based of_node_put() cleanups
In-Reply-To: <ZlhAm-giX6jNaUKr@surfacebook.localdomain>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com> <CAMuHMdUD=1rpns_mLF2rMM-x5EnOK7TExaJxoJVkbXjVz1H8uQ@mail.gmail.com>
 <ZlhAm-giX6jNaUKr@surfacebook.localdomain>
Message-ID: <CAMuHMdXqXVT3Y7N8pTb_68E23RkLGi=ySOSDkAWX4MOpP09Q4g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andy,

On Thu, May 30, 2024 at 11:03?AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Mon, May 13, 2024 at 01:59:03PM +0200, Geert Uytterhoeven kirjoitti:
> > On Sat, May 4, 2024 at 3:14?PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > You missed one trivial conversion, presumably because no error handling
> > and thus no of_node_put() is involved?
>
> Nothing is missed. The below is a redundant change.
>
> ...
>
> > -       for_each_child_of_node(np, child) {
> > +       for_each_child_of_node_scoped(np, child) {
> >                 if (of_property_count_u32_elems(child, RZN1_PINS_PROP) > 0)
> >                         count++;
> >         }
> >
> > If you prefer not to include this
>
> I prefer this not to be included as it will give a misleading signals to the
> use of the original API(s).

Thank you for reminding me to send this out as a separate patch :-)

https://lore.kernel.org/r/c0a28f466c42d5d59c7fadfa1fd05fd512d43b6f.1717060708.git.geert+renesas at glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
