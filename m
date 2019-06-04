From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 4 Jun 2019 10:06:58 +0200
Subject: [PATCH] ARM: configs: Remove useless UEVENT_HELPER_PATH
In-Reply-To: <CAMuHMdV0RNdB3_n7J0FWfhUTvzq4390HVsuzxXhexZ_zX-+nvg@mail.gmail.com>
References: <1559634833-19980-1-git-send-email-krzk@kernel.org>
 <CAMuHMdV0RNdB3_n7J0FWfhUTvzq4390HVsuzxXhexZ_zX-+nvg@mail.gmail.com>
Message-ID: <CAJKOXPcY8w7CVkwGWwhssPtz8=tgffzRoAN8-4SMSTYk2_yKEg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2019 at 09:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Jun 4, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Remove the CONFIG_UEVENT_HELPER_PATH because:
> > 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
> >    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
> >    made default to 'n',
> > 2. It is not recommended (help message: "This should not be used today
> >    [...] creates a high system load") and was kept only for ancient
> >    userland,
> > 3. Certain userland specifically requests it to be disabled (systemd
> >    README: "Legacy hotplug slows down the system and confuses udev").
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> >  arch/arm/configs/proceq_vf_bck_defconfig  | 255 +++++++++++++++++++++++++++
> >  arch/arm/configs/proceq_vf_crc_defconfig  | 278 ++++++++++++++++++++++++++++++
>
> These look like unrelated changes? Please drop.

Ooops, indeed. Thanks for spotting them.

Best regards,
Krzysztof
