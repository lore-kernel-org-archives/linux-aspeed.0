From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Oct 2024 16:04:59 +0200
Subject: [PATCH v7 0/7] Add Aspeed G7 gpio support
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
Message-ID: <CAMRc=Md4BOsdv=w+ju00X_R1Z_RAXz2vidVMrb7riaE2HoS9kw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024 at 10:14?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The Aspeed 7th generation SoC features two GPIO controllers: one with 12
> GPIO pins and another with 216 GPIO pins. The main difference from the
> previous generation is that the control logic has been updated to support
> per-pin control, allowing each pin to have its own 32-bit register for
> configuring value, direction, interrupt type, and more.
> This patch serial also add low-level operations (llops) to abstract the
> register access for GPIO registers and the coprocessor request/release in
> gpio-aspeed.c making it easier to extend the driver to support different
> hardware register layouts.
>

I picked up the first two patches for v6.12. The rest conflicts with
my v6.13 branch so I'll send the fixes to Torvalds, wait for rc3 and
then apply the rest.

Thanks,
Bart
