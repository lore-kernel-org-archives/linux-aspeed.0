From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Dec 2021 10:18:37 +0000
Subject: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
In-Reply-To: <20211224041352.29405-9-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com>
Message-ID: <Ycw1/XufNWq/FUss@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 24 Dec 2021, Quan Nguyen wrote:

> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>   + First introduced in v6 [Quan]
> 
>  drivers/mfd/smpro-mfd.c   |   1 +

Please pull all of these patches out.

There are no build dependencies here.

>  drivers/misc/Kconfig      |   7 ++
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/smpro-misc.c | 177 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 drivers/misc/smpro-misc.c
> 
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> index a7cd64bf9eaa..5611dd30f8f4 100644
> --- a/drivers/mfd/smpro-mfd.c
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
>  static const struct mfd_cell smpro_devs[] = {
>  	MFD_CELL_NAME("smpro-hwmon"),
>  	MFD_CELL_NAME("smpro-errmon"),
> +	MFD_CELL_NAME("smpro-misc"),

Misc is a Linuxisum which are not allowed in DT.

What does this driver actually do?

-- 
Lee Jones [???]
Senior Technical Lead - Developer Services
Linaro.org ? Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
