From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 19 Jun 2020 11:41:03 -0700
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200619165154.GA20461@cnn>
References: <20200619165154.GA20461@cnn>
Message-ID: <fa65b6de-b7ea-894b-7fd1-47676cc3c705@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/19/20 9:51 AM, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>

In addition to the other comment - please never send a new version of a patch
with the same sequence number. There are now two different versions of this patch,
both tagged "v4".

Guenter

> ---
> ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> ---    v3 -fix invalid signed-off.
> ---       -removed checkpath warnings.
> ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> ---    v2 -add Signed-off-by.
> ---       -removed ADM1278_TEMP1_EN check.
> ---
> ---
>  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..d4e1925 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
> 

