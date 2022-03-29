From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Mar 2022 11:04:11 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkK691VG6ON/6Ysn@atomide.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <YkK691VG6ON/6Ysn@atomide.com>
Message-ID: <CAMuHMdXDDNTgBdJTa8+H1H5v1gAarp07xxWu_E1JL8mXS8HPMg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tony,

On Tue, Mar 29, 2022 at 10:03 AM Tony Lindgren <tony@atomide.com> wrote:
> * Daniel Palmer <daniel@0x0f.com> [220328 08:53]:
> > On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > > as the title say, the intention of this ""series"" is to finally categorize
> > > the ARM dts directory in subdirectory for each oem.
> >
> > While I agree with this change and think it's for the good (browsing
> > the ARM dts directory at the moment is frustrating..) I think
> > buildroot and others need to be told about this as it'll potentially
> > break their kernel build scripting for ARM and probably messes up the
> > configs they have for existing boards.
>
> Yeah.. And ideally this would be done in smaller steps as these will
> conflict with all the other pending patches.
>
> For example, I have a pile of pending omap clock clean-up dts patches
> posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
> redoing or fixing up the patches with sed :)

Git merge/rebase/cherry-pick should handle renames fine?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
