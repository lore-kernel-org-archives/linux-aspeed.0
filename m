From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 26 Feb 2024 08:10:24 +0100
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
In-Reply-To: <572d53516dee6db5af7089090056185abb4e78c7.camel@codeconstruct.com.au>
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <572d53516dee6db5af7089090056185abb4e78c7.camel@codeconstruct.com.au>
Message-ID: <74cd8a61-3d9f-437e-8e3a-22139e23bda5@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Supreeth,


Thank you for your patch. Should you resent three more nits.

Am 26.02.24 um 07:55 schrieb Andrew Jeffery:
> On Tue, 2024-01-09 at 21:35 -0600, Supreeth Venkatesh wrote:
>> This patch adds initial device tree and makefile updates for
>> AMD Onyx platform.
>>
>> AMD Onyx platform is an AMD customer reference board with an Aspeed
>> ast2600 BMC manufactured by AMD.
>> It describes I2c devices, Fans, Kcs devices, Uarts, Mac, LEDs, etc.
>> present on AMD Onyx platform.

I?d capitalize I2Cs, UARTs, and MAC, but would write fans.

Also, could you please make the summary a statement by adding a verb in 
imperative mood. Maybe:

Add initial device tree for AMD Onyx Platform

I?d also add spaces after the colons in the commit message summary.

[?]


Kind regards,

Paul
