From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 16 Feb 2024 02:20:37 -0800
Subject: [PATCH] Add eSPI device driver (flash channel)
In-Reply-To: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
Message-ID: <f63c3077-f8cc-4f05-92ef-9b2303b181f4@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 13, 2024 at 06:36:08AM PST, Manojkiran Eda wrote:
>This patch adds the driver support for the eSPI controller of
>Aspeed 5/6th generation SoCs. This controller is a slave device
>communicating with a master over Enhanced Serial Peripheral
>Interface (eSPI).
>
>eSPI supports 4 channels, namely peripheral, virtual wire,
>out-of-band, and flash, and operates at max frequency of 66MHz.
>
>But at the moment, this patch set only supports the flash channel.
>
>Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>

Hi Manojkiran,

Glad to see this progressing again!  It sounds like there may still be 
some open questions regarding the approach, and as others have noted 
there are things included here that should be split out into separate 
patches.

I did try it out in its current form though, and encountered a few 
problems...

Firstly, the calls to dev_notice() all appear to be missing the struct 
device * as their first argument and hence don't compile (I hacked 
around this to get it to build).

Second, the device-tree updates only include aspeed-g6.dtsi, so I 
manually imported the corresponding aspeed-g5.dtsi change from the last 
version Chia-Wei posted [1] and used that for the AST2500 system I need 
eSPI support on.

[1] https://lore.kernel.org/linux-arm-kernel/20220516005412.4844-1-chiawei_wang at aspeedtech.com/

And finally, after making the above changes and running it I got the 
following during boot:

[    0.288079] aspeed-espi-ctrl 1e6ee000.espi-ctrl: something went wrong
[    0.288120] aspeed-espi-ctrl 1e6ee000.espi-ctrl: failed to allocate flash channel

I'm not sure if there's some change in this new version such that the 
dtsi patch I imported from the old one no longer works, but if nothing 
else it might at least suggest that the error messages could be made a 
bit more informative.


Thanks,
Zev

