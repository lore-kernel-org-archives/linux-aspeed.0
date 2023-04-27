From: Tony Lindgren <tony@atomide.com>
Date: Thu, 27 Apr 2023 10:48:45 +0300
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAMuHMdU91NtZeFKe6mB3B48TNb64wfPu77xRbOEVX4tV65e38w@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
 <CAMuHMdU91NtZeFKe6mB3B48TNb64wfPu77xRbOEVX4tV65e38w@mail.gmail.com>
Message-ID: <20230427074845.GG14287@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Geert Uytterhoeven <geert@linux-m68k.org> [230427 07:47]:
> On Thu, Apr 27, 2023 at 9:37?AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > On 25/04/2023 17:57, Rob Herring wrote:
> > > On Tue, Apr 25, 2023 at 2:28?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> On Tue, Apr 25, 2023 at 12:16?AM Rob Herring <robh+dt@kernel.org> wrote:
> > >>> I have a script[1] that does the conversion written the last time this
> > >>> came up. Just have to agree on directory names. I think the easiest
> > >>> would be for Arnd/Olof to run it at the end of a merge window before
> > >>> rc1.
> > >>
> > >> "emev2" and "sh7" are missing for renesas.
> > >
> > > No doubt it's been bitrotting (or I may have missed some).
> > >
> > >> Does your script also cater for .dts files not matching any pattern,
> > >> but including a .dtsi file that does match a pattern?
> > >
> > > I assume I built everything after moving, but maybe not...
> > >
> > > That's all just "details". First, we need agreement on a) moving
> > > things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> > > been stuck on a) for being 'too much churn'.
> > >
> >
> > I think it makes sense to move them and probably the best way to do so is, as
> > you proposed: that Arnd or Olof run the script to move them just before -rc1
> 
> FTR, no objections from my side.

Sounds good to me.

Regards,

Tony
