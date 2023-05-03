From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 May 2023 08:08:48 -0500
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
Message-ID: <CAL_JsqL-WMNxHrgCzn=LfH6gpE_Yb3uRwo97ssHPoZenK3CEeQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 3, 2023 at 6:02?AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
> > On Tue, May 2, 2023 at 3:15?AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > vendor_map = {
> >     'alphascale' : 'alphascale',
> >     'alpine' : 'alpine',
>
> I would make this one 'amazon' if we go with current manufacturers.
>
> >     'nspire' : 'nspire',
>
> nspire is the name of the end-user product, so that doesn't quite
> fit. The SoC was apparently an LSI logic Zevio, which is now owned
> by Broadcom.

I'm inclined to leave it. I put it in the category of a one-off thing
that's not sharing anything

> >     'mvebu' : 'marvell',
> >     'mmp' : 'marvell',
> >     'berlin' : 'berlin',
>
> While berlin is related to pxa/mmp, this one is now owned
> by Synaptics, and the 64-bit versions are already in the
> synaptics subdir, so I'd go with teh same here.
>
> >     'openbmc' : 'aspeed',
> >     'en7' : 'airoha',
>
> airoha is a separate company now, but the hardware is still
> shared with mediatek, so we could consider lumping it into
> that subdir, but a separate one may be better long-term.
>
> >     'gemini' : 'gemini',
>
> This one is also a product name, not a company. Apparently,
> gemini was originally made by Storm Semiconductor, and then
> by Cortina, which was subsequently acquired by Inphi, and that ended
> up in Marvell after the product was already discontinued.
>
> Out of the four, I'd probably go with 'cortina' as the
> directory name.

I had 'cortina' previously. Linus wanted gemini...

Rob
