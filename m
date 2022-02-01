From: Joel Stanley <joel@jms.id.au>
Date: Tue, 1 Feb 2022 07:01:42 +0000
Subject: [PATCH next] docs/ABI: testing: aspeed-uart-routing: Escape
 asterisk
In-Reply-To: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
References: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
Message-ID: <CACPK8XfzBT3YiMYqH5cKX5jWSSYx45vNzubdUpXOTnE1xy2TXQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 24 Jan 2022 at 01:44, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Escape asterisk symbols to fix the following warning:
>
> "WARNING: Inline emphasis start-string without end-string"
>
> Fixes: c6807970c3bc ("soc: aspeed: Add UART routing support")
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

Thanks Chai-Wei, I've sent this to the soc maintainers to apply as a fix.

> ---
>  Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> index b363827da437..910df0e5815a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> @@ -1,4 +1,4 @@
> -What:          /sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
> +What:          /sys/bus/platform/drivers/aspeed-uart-routing/\*/uart\*
>  Date:          September 2021
>  Contact:       Oskar Senft <osk@google.com>
>                 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> @@ -9,7 +9,7 @@ Description:    Selects the RX source of the UARTx device.
>                 depends on the selected file.
>
>                 e.g.
> -               cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> +               cat /sys/bus/platform/drivers/aspeed-uart-routing/\*.uart_routing/uart1
>                 [io1] io2 io3 io4 uart2 uart3 uart4 io6
>
>                 In this case, UART1 gets its input from IO1 (physical serial port 1).
> @@ -17,7 +17,7 @@ Description:  Selects the RX source of the UARTx device.
>  Users:         OpenBMC.  Proposed changes should be mailed to
>                 openbmc at lists.ozlabs.org
>
> -What:          /sys/bus/platform/drivers/aspeed-uart-routing/*/io*
> +What:          /sys/bus/platform/drivers/aspeed-uart-routing/\*/io\*
>  Date:          September 2021
>  Contact:       Oskar Senft <osk@google.com>
>                 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> --
> 2.25.1
>
