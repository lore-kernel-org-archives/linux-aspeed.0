From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Jul 2022 22:43:12 +0200
Subject: [PATCH 4/6] ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
In-Reply-To: <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-5-arnd@kernel.org>
 <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
Message-ID: <CAK8P3a0yc_iZ1dqbReckvune6KszCPvysCX9okYoaU-by+YRhQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 21, 2022 at 5:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 16:13, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > CONFIG_DEBUG_INFO is now implicitly selected if one picks one of the
> > explicit options that could be DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> > DEBUG_INFO_DWARF4, DEBUG_INFO_DWARF5.
> >
> > This was actually not what I had in mind when I suggested making
> > it a 'choice' statement, but it's too late to change again now,
> > and the Kconfig logic is more sensible in the new form.
> >
> > Change any defconfig file that had CONFIG_DEBUG_INFO enabled
> > but did not pick DWARF4 or DWARF5 explicitly to now pick the toolchain
> > default.
>
> I think this should be split - into remove DEBUG_INFO (noop) and into
> selecting CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT (a fix).

I'd rather keep them together: while removing the DEBUG_INFO is
now a NOP, keeping the two changes together explains much better
why this is done and is atomically needed based on the single patch
that caused the change.

It's the same with the LEDS patch that replaces the CONFIG_LEDS
option with CONFIG_NEW_LEDS.

       Arnd
