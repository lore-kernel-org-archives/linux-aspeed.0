From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 20:56:43 -0000
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
In-Reply-To: <20240213-wafer-garnish-88287bc5d4a5@spud>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <20240213-wafer-garnish-88287bc5d4a5@spud>
Message-ID: <CAL_Jsq+9BwYyV9Vu1gfCnK_QjdRHvw2anM==Z6fsJvjyqLYFLw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 13, 2024 at 2:27?PM Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 01:34:24PM -0600, Rob Herring wrote:
> > I had a branch with most of these changes sitting in my tree for some
> > time. Geert's asking about some errors not getting found prompted me to
> > clean it up and send it out. This series fixes all* interrupt related
> > warnings and enables the check by default.
> >
> > SoC maintainers, Can you please take this series directly.
> >
> > Rob
> >
> > *There's a few Renesas warnings still Geert said he would fix.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Rob Herring (6):
> >       arm64: dts: freescale: Disable interrupt_map check
> >       arm: dts: Fix dtc interrupt_provider warnings
> >       arm64: dts: Fix dtc interrupt_provider warnings
> >       arm: dts: Fix dtc interrupt_map warnings
> >       arm64: dts: qcom: Fix interrupt-map cell sizes
> >       dtc: Enable dtc interrupt_provider check
>
> Only fixing it for arm, Sadge.

I was assuming you had things in order. ;)

> Co-incidentally I noticed there was one for riscv while looking at
> Krzysztof's underscore in node name patch earlier, so I'd already
> written a patch to fix it :)

See, I was right.

Actually, I did remember to check right after I sent this and noticed the same.

For powerpc, no one else can be bothered to care, so neither do I. I
think powerpc has been spewing dtc warnings by default for some time
now.

Rob
