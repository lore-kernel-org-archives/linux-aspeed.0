From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 17 Oct 2022 13:40:27 -0700
Subject: [PATCH] usb: gadget: aspeed: Fix probe regression
In-Reply-To: <20221017053006.358520-1-joel@jms.id.au>
References: <20221017053006.358520-1-joel@jms.id.au>
Message-ID: <Y029u+ZZZikW4fYl@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 16, 2022 at 10:30:06PM PDT, Joel Stanley wrote:
>Since commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets"),
>the gadget devices are proper driver core devices, which caused each
>device to request pinmux settings:
>
> aspeed_vhub 1e6a0000.usb-vhub: Initialized virtual hub in USB2 mode
> aspeed-g5-pinctrl 1e6e2080.pinctrl: pin A7 already requested by 1e6a0000.usb-vhub; cannot claim for gadget.0
> aspeed-g5-pinctrl 1e6e2080.pinctrl: pin-232 (gadget.0) status -22
> aspeed-g5-pinctrl 1e6e2080.pinctrl: could not request pin 232 (A7) from group USB2AD  on device aspeed-g5-pinctrl
> g_mass_storage gadget.0: Error applying setting, reverse things back
>
>The vhub driver has already claimed the pins, so prevent the gadgets
>from requesting them too by setting the magic of_node_reused flag. This
>causes the driver core to skip the mux request.
>
>Reported-by: Zev Weiss <zev@bewilderbeest.net>
>Reported-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>Cc: stable at vger.kernel.org
>Signed-off-by: Joel Stanley <joel@jms.id.au>

Thanks Joel!

Tested-by: Zev Weiss <zev@bewilderbeest.net>

