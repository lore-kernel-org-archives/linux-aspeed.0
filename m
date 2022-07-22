From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 22 Jul 2022 09:02:11 +0200
Subject: [PATCH 1/6] ARM: refresh defconfig files
In-Reply-To: <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-2-arnd@kernel.org>
 <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com> <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
Message-ID: <CAK8P3a3jF=7atLkWKwrvgYLcZuEObbMF79cbj0XaFEiVw40Piw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 21, 2022 at 5:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 17:33, Scott Branden wrote:
> > Hi Arnd,
> >
> > On 2022-07-21 07:13, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> A lot of Kconfig options have changed over the years, and we tend
> >> to not do a blind 'make defconfig' to refresh the files, to ensure
> >> we catch options that should not have gone away.
> >>
> >> I used some a bit of scripting to only rework the bits where an
> >> option moved around in any of the defconfig files, without also
> >> dropping any of the other lines, to make it clearer which options
> >> we no longer have.
> > Resync is fine.  But, it would be great if the defconfig files were kept
> > in sync. Almost every kernel version kconfig options change which affect
> > these files. Could we put in place a defconfig refresh per kernel
> > version to keep them all in sync going forward?
> >
>
> Not entirely, because some Kconfig changes are causing symbols to
> disappear. Also defconfig is expected to include user-visible options,
> even if savedefconfig would drop them.
>
> This is why blind savedefconfig is not acceptable.

Right. I mostly scripted the changes to move the options around, but
had to do a few files manually so I can't fully automate this, and
the removed options always need manual inspection. There are still
around 400 lines in the defconfig files that go away after a
savedefconfig, and it's a lot of work to go through those.

I might do a few more of these, but if anyone wants to help, these
are the most common lines that get dropped, sorted by frequency:

     34 -# CONFIG_VGA_CONSOLE is not set
     32 -CONFIG_NET_ETHERNET=y
     26 -CONFIG_NFS_V3=y
     22 -# CONFIG_CRYPTO_ANSI_CPRNG is not set
     20 -CONFIG_PM=y
     18 -CONFIG_FPE_NWFPE=y
     18 -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
     18 -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
     18 -# CONFIG_INET_XFRM_MODE_BEET is not set
     15 -CONFIG_SYSFS_DEPRECATED_V2=y
     15 -CONFIG_DEBUG_KERNEL=y
     15 -# CONFIG_BLK_DEV_BSG is not set
     14 -# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
     14 -# CONFIG_INPUT_MOUSEDEV is not set
     12 -CONFIG_LEDS=y
     12 -CONFIG_AEABI=y
     11 -CONFIG_NET_PCMCIA=y
     11 -CONFIG_GPIO_SYSFS=y
     10 -# CONFIG_ENABLE_MUST_CHECK is not set
      9 -CONFIG_LEDS_CPU=y
      9 -# CONFIG_EXT3_FS_XATTR is not set
      8 -CONFIG_CRYPTO_SHA512=m
      8 -CONFIG_BINFMT_AOUT=y
      8 -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
      7 -CONFIG_SND_PCM_OSS=m
      7 -CONFIG_SND_MIXER_OSS=m
      7 -CONFIG_SMB_FS=m
      7 -CONFIG_MTD_M25P80=y
      6 -CONFIG_NET_PCI=y
      6 -CONFIG_CRYPTO_ECB=m
      5 -CONFIG_SECCOMP=y
      5 -CONFIG_MEDIA_CAMERA_SUPPORT=y
      5 -CONFIG_IPV6=y
      5 -CONFIG_CRYPTO_TEA=m
      5 -CONFIG_CRYPTO_SHA256=m
      5 -CONFIG_CRYPTO_KHAZAD=m
      5 -CONFIG_CRYPTO_ARC4=m
      5 -CONFIG_BACKLIGHT_PWM=y
      5 -# CONFIG_NET_CADENCE is not set

The majority of these lines are options that no longer exist and are
not needed, or things that dropped off because they get selected by
something else.

The interesting ones we need to catch are the ones that should be
enabled but are either renamed to something else or gained a
dependency that now also needs to be turned on.

           Arnd
