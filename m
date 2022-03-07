From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 7 Mar 2022 15:32:36 +0700
Subject: [PATCH v6 8/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
In-Reply-To: <20211224041352.29405-9-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-9-quan@os.amperecomputing.com>
Message-ID: <51603aa7-4113-dba4-9a38-0a6683a1d249@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Lee Jones,

This to reply your comment in https://lkml.org/lkml/2021/12/29/121

Thanks for the review,
- Quan

On 24/12/2021 11:13, Quan Nguyen wrote:
> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>    + First introduced in v6 [Quan]
> 
>   drivers/mfd/smpro-mfd.c   |   1 +

[Lee Jones]
Please pull all of these patches out.

There are no build dependencies here.

[Quan]
Will separate this smpro-mfd and other child drivers in next version

>   drivers/misc/Kconfig      |   7 ++
>   drivers/misc/Makefile     |   1 +
>   drivers/misc/smpro-misc.c | 177 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 drivers/misc/smpro-misc.c
> 
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> index a7cd64bf9eaa..5611dd30f8f4 100644
> --- a/drivers/mfd/smpro-mfd.c
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -28,6 +28,7 @@ static const struct regmap_config simple_word_regmap_config = {
>   static const struct mfd_cell smpro_devs[] = {
>   	MFD_CELL_NAME("smpro-hwmon"),
>   	MFD_CELL_NAME("smpro-errmon"),
> +	MFD_CELL_NAME("smpro-misc"),

[Lee Jones]
Misc is a Linuxisum which are not allowed in DT.

What does this driver actually do?

[Quan]
This drivers is to report the boot progress to BMC and allow BMC to 
configure the Soc Power Limit of Ampere's Altra family processor.



