From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 19 Jun 2020 22:19:19 -0700
Subject: [PATCH v5] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200620043509.GA27532@cnn>
References: <20200620043509.GA27532@cnn>
Message-ID: <9f8820d6-c107-d6b7-1cf7-a8a48eca716d@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/19/20 9:35 PM, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> ---
> ---    v5 -align commit and change log. 
> ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> ---    v3 -fix invalid signed-off.
> ---       -removed checkpath warnings.
> ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> ---    v2 -add Signed-off-by.
> ---       -removed ADM1278_TEMP1_EN check.
> ---
> ---

Not that it matters much here, but why all the "---" instead of just one,
especially after you were advised that this is not the expected format ?

Guenter

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

