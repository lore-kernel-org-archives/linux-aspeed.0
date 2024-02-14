From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Feb 2024 15:31:40 -0000
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
In-Reply-To: <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
Message-ID: <CAL_JsqKbDdUzkuSBrBTYm0PF8KehK0DnUwTBHqJ6tZfaE=B2_w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 14, 2024 at 9:01?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Feb 13, 2024 at 8:35?PM Rob Herring <robh@kernel.org> wrote:
> > I had a branch with most of these changes sitting in my tree for some
> > time. Geert's asking about some errors not getting found prompted me to
> > clean it up and send it out. This series fixes all* interrupt related
> > warnings and enables the check by default.
>
> > *There's a few Renesas warnings still Geert said he would fix.
>
> Thanks, fix sent
> https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.1707922460.git.geert+renesas at glider.be
>
> >       dtc: Enable dtc interrupt_provider check
>
> >  scripts/Makefile.lib                                  |  3 +--
>
> Just wondering, can the remaining disabler be removed, too?
>
> Documentation/devicetree/bindings/Makefile:     -Wno-interrupt_provider \

I was too. Shockingly, that too will require some fixes. Though I
remember when configuring the warnings for bindings, trying to make
them stricter. So there must have been some case where
no-interrupt_provider was needed. It may have been related to how we
parse interrupts in examples, but that changed back when switching to
validate dtbs directly.

Rob
