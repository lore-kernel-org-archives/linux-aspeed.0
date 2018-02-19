From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Feb 2018 22:37:55 +1030
Subject: [PATCH 3/3] reset: simple: Allow user selection of driver
In-Reply-To: <1519040779.3408.7.camel@pengutronix.de>
References: <20180219065438.19933-1-joel@jms.id.au>
 <20180219065438.19933-4-joel@jms.id.au>
 <1519040779.3408.7.camel@pengutronix.de>
Message-ID: <CACPK8Xe3bKSfp=PqL8Rm9ivaM5HN0M7FbJ9Bwf_O2D5MZxEpPQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 19, 2018 at 10:16 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
>> Currently this driver is only user selectable if COMPILE_TEST is turned
>> on. Users may wish to select (and deselect) it, so remove this
>> restriction.
>
> I would like to keep user visible options to a minimum unless there is a
> good reason. What is the scenario in which a user would decide to
> disable the default-enabled reset-simple driver, or the other way
> around? This should be mentioned in the commit message.

In this SoC's case the driver is not essential. A system that does not
use UART1..4 will not ever call on the driver. This situation is
common as the console uses UART5.

> Maybe this is an indication that there could be a better default than
> just ARCH_ASPEED.

This is an appropriate default, as it causes the least surprise to a
user. Without taking the UART out of reset, the kernel driver still
loads, but characters are never drained from the FIFO.

Advanced users may want to save the few kilobytes that an extra driver
adds, and the boot overhead of loading yet another driver. The saving
is small, so if you feel strongly about it we can drop this patch.

Cheers,

Joel

>
> regards
> Philipp
>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  drivers/reset/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 18f152d251d7..7490a4370900 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -82,7 +82,7 @@ config RESET_PISTACHIO
>>         This enables the reset driver for ImgTec Pistachio SoCs.
>>
>>  config RESET_SIMPLE
>> -     bool "Simple Reset Controller Driver" if COMPILE_TEST
>> +     bool "Simple Reset Controller Driver"
>>       default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>>       help
>>         This enables a simple reset controller driver for reset lines that
