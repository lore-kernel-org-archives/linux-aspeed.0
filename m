From: Joel Stanley <joel@jms.id.au>
Date: Tue, 26 Oct 2021 21:03:22 +0000
Subject: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
In-Reply-To: <20211026200058.2183-1-aladyshev22@gmail.com>
References: <20211026200058.2183-1-aladyshev22@gmail.com>
Message-ID: <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Konstantin,

On Tue, 26 Oct 2021 at 20:01, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Add initial version of device tree for the BMC in the AMD DaytonaX
> platform.
>
> AMD DaytonaX platform is a customer reference board (CRB) with an
> Aspeed ast2500 BMC manufactured by AMD.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

This looks good. I have one comment about the GPIOs below.

> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","FAULT_LED","","","","","",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "CHASSIS_ID_BTN","","","","","","","",
> +       /*D0-D7*/       "","","ASSERT_BMC_READY","","","","","",
> +       /*E0-E7*/       "MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
> +                       "MON_P0_PWR_GOOD","MON_PWROK","",

For systems that will run openbmc, we try to use naming conventions
from this document:

https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

If a GPIO is missing from that doc I encourage you to add it.
